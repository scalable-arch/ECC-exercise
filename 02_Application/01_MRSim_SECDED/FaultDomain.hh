#ifndef __FAULT_DOMAIN_HH__
#define __FAULT_DOMAIN_HH__

#include <list>
#include "FaultRateInfo.hh"

class ECC;
class Fault;

//------------------------------------------------------------------------------
class FaultDomain {
public:
    FaultDomain(int _ranksPerDomain, int _devicesPerRank, int _pinsPerDevice, int _blkHeight, FaultRateInfo *_faultRateInfo)
    : ranksPerDomain(_ranksPerDomain), devicesPerRank(_devicesPerRank),
      pinsPerDevice(_pinsPerDevice), blkHeight(_blkHeight),
      faultRateInfo(_faultRateInfo), inherentFault(NULL) {
          clear();
      }

public:
    int getChannelWidth() { return devicesPerRank * pinsPerDevice; }
    int getChipWidth() { return pinsPerDevice; }
    int getChipCount() { return devicesPerRank; }
    int getBeatHeight() { return blkHeight; }
    double getFaultRate() { return ranksPerDomain*devicesPerRank*faultRateInfo->getTotalRate(); }

    void setInherentFault(Fault *fault) { inherentFault = fault; }
    void setInitialRetiredBlkCount(ECC *ecc);

    unsigned long long getRetiredBlkCount() { return retiredBlkCount; }
    size_t getRetiredChipCount() { return retiredChipIDList.size(); }
    size_t getRetiredPinCount() { return retiredPinIDList.size(); }

// For fault generation based on scenario
    ErrorType genScenarioRandomFaultAndTest(ECC *ecc, int faultCount, std::string *faults);
// For fault generation based on fault rates
    ErrorType genSystemRandomFaultAndTest(ECC *ecc);

    void retirePin(int pinID);
    void retireChip(int chipID);

    void scrub();

    void clear();
    void print(FILE *fd = stdout) const;
public:
    int ranksPerDomain;
    int devicesPerRank;
    int pinsPerDevice;
    int blkHeight;

    FaultRateInfo *faultRateInfo;

    Fault *inherentFault;
    std::list<Fault *> operationalFaultList;

    unsigned long long retiredBlkCount;
    std::list<int> retiredPinIDList;
    std::list<int> retiredChipIDList;

	//GONG
	int FaultyChipDetect();
};

//------------------------------------------------------------------------------
class FaultDomainDDR : public FaultDomain {
public:
    FaultDomainDDR(int ranksPerDomain, int devicesPerRank, int pinsPerDevice, int blkHeight)
        : FaultDomain(ranksPerDomain, devicesPerRank, pinsPerDevice, blkHeight, new DefaultFaultRateInfo()) {}
    ~FaultDomainDDR() {
        delete faultRateInfo;
    }
};

//------------------------------------------------------------------------------
#endif /* __FAULT_DOMAIN_HH__ */
