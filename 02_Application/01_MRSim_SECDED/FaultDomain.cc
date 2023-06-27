#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

#include "Config.hh"
#include "FaultDomain.hh"
#include "ECC.hh"

//------------------------------------------------------------------------------
ErrorType worseErrorType(ErrorType a, ErrorType b) {
    return (a>b) ? a : b;
}

ErrorType FaultDomain::genSystemRandomFaultAndTest(ECC *ecc) {
    CacheLine blk = {pinsPerDevice, (devicesPerRank -(int) retiredChipIDList.size()) * pinsPerDevice - (int) retiredPinIDList.size(), blkHeight};
    Fault *newFault;
    ErrorType result = NE;

    //----------------------------------------------------------
    // 1. generate a new fault
    //----------------------------------------------------------
    std::string newFaultType = faultRateInfo->pickRandomType();
    newFault = Fault::genRandomFault(newFaultType, this);

    //----------------------------------------------------------
    // check whether the fault is on a retired chip or pin
    //----------------------------------------------------------
    // a new fault on already retired chip -> skip
    for (auto it = retiredChipIDList.cbegin(); it != retiredChipIDList.cend(); ++it) {
        if (newFault->getChipID()==(*it)) {
            delete newFault;
            return NE;
        }
    }
    // a new pin fault on already retired pin -> skip
    if (newFault->getIsSingleDQ()) {
        // retired pin
        for (auto it = retiredPinIDList.cbegin(); it != retiredPinIDList.cend(); ++it) {
            if (newFault->getPinID()==(*it)) {
                delete newFault;
                return NE;
            }
        }
    }

    operationalFaultList.push_back(newFault);

    //----------------------------------------------------------
    // 3. check overlapping previous fault
    // - check the most severe one
    //----------------------------------------------------------
    auto it1 = operationalFaultList.crbegin();
    bool overlap1 = false;
    for (++it1; it1!=operationalFaultList.crend(); ++it1) {
        if ((*it1)->overlap(newFault)) {
            overlap1 = true;
            bool overlap2 = false;
            auto it2 = it1;
            for (++it2; it2!=operationalFaultList.crend(); ++it2) {
                if ((*it2)->overlap(newFault) && (*it2)->overlap(*it1)) {
                    overlap2 = true;
                    bool overlap3 = false;
                    auto it3 = it2;
                    for (++it3; it3!=operationalFaultList.crend(); ++it3) {
                        if ((*it3)->overlap(newFault) && (*it3)->overlap(*it1) && (*it3)->overlap(*it2)) {
                            overlap3 = true;
                            bool overlap4 = false;
                            auto it4 = it3;
                            for (++it4; it4!=operationalFaultList.crend(); ++it4) {
                                if ((*it4)->overlap(newFault) && (*it4)->overlap(*it1) && (*it4)->overlap(*it2) && (*it4)->overlap(*it3)) {
                                    overlap4 = true;
                                    assert(0);
                                }
                            }
                            if (!overlap4) {
                                blk.reset();
                                if (inherentFault!=NULL) inherentFault->genRandomError(&blk);
                                (*it1)->genRandomError(&blk);
                                (*it2)->genRandomError(&blk);
                                (*it3)->genRandomError(&blk);
                                newFault->genRandomError(&blk);
                                result = worseErrorType(result, ecc->decode(this, blk));
                            }
                        }
                    }
                    if (!overlap3) {
                        blk.reset();
                        if (inherentFault!=NULL) inherentFault->genRandomError(&blk);
                        (*it1)->genRandomError(&blk);
                        (*it2)->genRandomError(&blk);
                        newFault->genRandomError(&blk);
                        result = worseErrorType(result, ecc->decode(this, blk));
                    }
                }
            }
            if (!overlap2) {
                blk.reset();
                if (inherentFault!=NULL) inherentFault->genRandomError(&blk);
                (*it1)->genRandomError(&blk);
                newFault->genRandomError(&blk);
                result = worseErrorType(result, ecc->decode(this, blk));
            }
        }
    }
    if (!overlap1) {
        blk.reset();
        if (inherentFault!=NULL) inherentFault->genRandomError(&blk);
        newFault->genRandomError(&blk);
        result = worseErrorType(result, ecc->decode(this, blk));
    }

    if ((result==CE)&&ecc->getDoRetire()&&ecc->needRetire(this, newFault)) {
        retiredBlkCount += newFault->getAffectedBlkCount();
        operationalFaultList.remove(newFault);
        delete newFault;
    }
    return result;
}

//------------------------------------------------------------------------------
void FaultDomain::setInitialRetiredBlkCount(ECC *ecc) {
    retiredBlkCount = ecc->getInitialRetiredBlkCount(this, inherentFault);
    //if (retiredBlkCount!=0) {
    //    printf("%lld\n", retiredBlkCount);
    //}
}

void FaultDomain::scrub() {
    auto it = operationalFaultList.begin();
    while (it != operationalFaultList.end()) {
        if ((*it)->getIsTransient()==true) {
            delete *it;
            it = operationalFaultList.erase(it);
            // continue without advancing the iterator
        } else {
            ++it;
        }
    }
}

//------------------------------------------------------------------------------
void FaultDomain::clear() {
    for (auto it = operationalFaultList.begin(); it != operationalFaultList.end(); ++it) {
        delete *it;
    }
    operationalFaultList.clear();
    retiredChipIDList.clear();
    retiredPinIDList.clear();
}

void FaultDomain::print(FILE *fd) const {
    for (auto it = operationalFaultList.begin(); it != operationalFaultList.end(); it++) {
        (*it)->print(fd);
    }
}

//------------------------------------------------------------------------------//
