/**
 * @file: ECC.hh
 * @author: Jungrae Kim <dale40@gmail.com>
 * ECC declaration 
 */

#ifndef __ECC_HH__
#define __ECC_HH__

#include <list>
#include <set>

#include "message.hh"
#include "Fault.hh"

class FaultDomain;
class DomainGroup;
class Codec;

extern ErrorType worse2ErrorType(ErrorType a, ErrorType b);

class ECC {
public:
    ECC() : ECC(LINEAR, false, false, 0) {}
    ECC(ECCLayout _layout) : ECC(_layout, false, false, 0) {}
    ECC(ECCLayout _layout, bool _doPostprocess) : ECC(_layout, _doPostprocess, false, 0) {}
    ECC(ECCLayout _layout, bool _doPostprocess, bool _doRetire, int _maxRetiredBlkCount)
    : layout(_layout), doPostprocess(_doPostprocess), doRetire(_doRetire), maxRetiredBlkCount(_maxRetiredBlkCount) {}

    // decoding
    ErrorType decode(FaultDomain *fd, CacheLine &blk);
    virtual ErrorType decodeInternal(FaultDomain *fd, CacheLine &blk);
    virtual ErrorType postprocess(FaultDomain *fd, ErrorType preResult) {
        // no post-processing
        return preResult;
    }

    // retire
    bool getDoRetire() { return doRetire; }
    void setDoRetire(bool b) { doRetire = b; }
    unsigned long long getMaxRetiredBlkCount() { return maxRetiredBlkCount; }
    void setMaxRetiredBlkCount(unsigned long long size) { doRetire = true; maxRetiredBlkCount = size; }
    virtual bool needRetire(FaultDomain *fd, Fault *fault) { return !fault->getIsTransient(); }
    virtual unsigned long long getInitialRetiredBlkCount(FaultDomain *fd, Fault *fault);

    void clear() { correctedPosSet.clear(); }

    struct config {
        int maxDeviceRetirement;
        int maxPinRetirement;
        Codec *codec;
    };

protected:
    std::list<struct config> configList;    // for graceful downgrade
    ECCLayout layout;

    bool doPostprocess;

    bool doRetire;
    unsigned long long maxRetiredBlkCount;

    std::set<int> correctedPosSet;
};

//------------------------------------------------------------------------------
class ECCNone : public ECC {
public:
    ECCNone() : ECC() {}
};

#endif /* __ECC_HH__ */
