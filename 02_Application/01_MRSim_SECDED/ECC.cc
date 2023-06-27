#include <assert.h>

#include "ECC.hh"
#include "FaultDomain.hh"
#include "DomainGroup.hh"
#include "codec.hh"
#include "hsiao.hh"

extern std::default_random_engine randomGenerator;

//------------------------------------------------------------------------------
ErrorType worse2ErrorType(ErrorType a, ErrorType b) {
    //if ((a==SDC) || (b==SDC)) {
    //    return SDC;
    //}
    if ((a==DUE) || (b==DUE)) {
        return DUE;
    }
    return (a>b) ? a : b;
}

//------------------------------------------------------------------------------
ErrorType ECC::decode(FaultDomain *fd, CacheLine &errorBlk) {
    ErrorType result;

    // clear corrected position information
    clear();

    // do decoding
    result = decodeInternal(fd, errorBlk);

    if (doPostprocess) {
        result = postprocess(fd, result);
    }
    return result;
}

ErrorType ECC::decodeInternal(FaultDomain *fd, CacheLine &errorBlk) {
    // find appropriate CODEC
    Codec *codec = NULL;
    for (auto it = configList.begin(); it != configList.end(); it++) {
        if (   (fd->getRetiredChipCount() <= it->maxDeviceRetirement)
            && (fd->getRetiredPinCount() <= it->maxPinRetirement) ) {
            codec = it->codec;
            //assert((codec->getBitN()%errorBlk.getChannelWidth())==0);
        }
    }
    if (codec==NULL) { if (errorBlk.isZero()) return NE; else return SDC; }

    ECCWord msg = {codec->getBitN(), codec->getBitK()};
    ECCWord decoded = {codec->getBitN(), codec->getBitK()};

    ErrorType result = NE, newResult;
    std::cout << "========================" << std::endl;
    std::cout << "this is errorBlk blocks " << std::endl;
    errorBlk.print(stdout);
    for (int i=errorBlk.getBitN()/codec->getBitN()-1; i>=0; i--) {
        msg.extract(&errorBlk, layout, i, errorBlk.getChannelWidth());

        std::cout << "this is "<< i << "th burst received codeword" << std::endl;
        msg.print();

        if (msg.isZero()) {        // error-free region of a block -> skip
            newResult = NE;
        } else {
            newResult = codec->decode(&msg, &decoded, &correctedPosSet);
        }
        result = worse2ErrorType(result, newResult);

        std::cout << "this is "<< i << "th burst decoded codeword" << std::endl;
        decoded.print();
    }

    return result;
}

//------------------------------------------------------------------------------
unsigned long long ECC::getInitialRetiredBlkCount(FaultDomain *fd, Fault *fault) {
    double cellFaultRate = fault->getCellFaultRate();
    if (cellFaultRate==0) {
        return 0;
    } else {
        int blkSize = fd->getChannelWidth() * fd->getBeatHeight();
        double goodBlkProb = pow(1-cellFaultRate, blkSize);
        unsigned long long totalBlkCount = ((MRANK_MASK^DEFAULT_MASK)+1)*fd->getChannelWidth()/blkSize;
        std::binomial_distribution<int> distribution(totalBlkCount, goodBlkProb);
        unsigned long long goodBlkCount = distribution(randomGenerator);
        unsigned long long badBlkCount = totalBlkCount - goodBlkCount;
        return badBlkCount;
    }
}

