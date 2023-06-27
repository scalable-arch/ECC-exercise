#include <list>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "FaultDomain.hh"
#include "DomainGroup.hh"

FaultDomain *DomainGroup::pickRandomFD() {
    ErrorType result;
    int posFD = rand() % FDList.size();
    auto it = FDList.begin();
    for (int i=0; i<posFD; i++) {
        ++it;
    }
    return *it;
}
