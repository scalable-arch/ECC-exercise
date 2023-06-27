#ifndef __DOMAIN_GROUP_HH__
#define __DOMAIN_GROUP_HH__

#include <list>

#include "common.hh"
#include "FaultDomain.hh"

//------------------------------------------------------------------------------
class DomainGroup {     // Corresponds to a cluster
public:
    DomainGroup() {}
    ~DomainGroup() {
        for (auto it=FDList.begin(); it!=FDList.end(); ++it) {
            delete *it;
        }
        FDList.clear();
    }

    double getFaultRate() { return (FDList.size()==0) ? 0 : FDList.size() * FDList.front()->getFaultRate(); }
    void setInherentFault(Fault *fault) { for (auto it=FDList.begin(); it!=FDList.end(); ++it) { (*it)->setInherentFault(fault); } }
    void setInitialRetiredBlkCount(ECC *ecc) { for (auto it=FDList.begin(); it!=FDList.end(); ++it) { (*it)->setInitialRetiredBlkCount(ecc); } }

    FaultDomain *pickRandomFD();

    void scrub() { for (auto it=FDList.begin(); it!=FDList.end(); ++it) { (*it)->scrub(); } }
    void clear() { for (auto it=FDList.begin(); it!=FDList.end(); ++it) { (*it)->clear(); } }
    FaultDomain *getFD() { return FDList.front(); }

protected:
    std::list<FaultDomain *> FDList;
};

//----------------------------------------------------------
class DomainGroupDDR : public DomainGroup {
public:
    DomainGroupDDR(int domainsPerGroup, int ranksPerDomain, int devicesPerRank, int pinsPerDevice, int blkHeight) {
        for (int i=0; i<domainsPerGroup; i++) {
            FDList.push_back(new FaultDomainDDR(ranksPerDomain, devicesPerRank, pinsPerDevice, blkHeight));
        }
    }
};

#endif /* __DOMAIN_GROUP_HH__ */
