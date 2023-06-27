#ifndef __TESTER_HH__
#define __TESTER_HH__

#include <stdio.h>
#include <list>

#include "common.hh"
#include "codec.hh"
#include "Fault.hh"
#include "ECC.hh"

#define MAX_YEAR    6

class FaultDomain;
class DomainGroup;
class Scrubber;

class Tester {
public:
    Tester() {}

    virtual void test(DomainGroup *dg, ECC *ecc, Scrubber *scrubber, long runCnt, char *filePrefix, int faultCount, std::string *faults) = 0;
};

class TesterSystem : public Tester {
public:
    TesterSystem() {}

    void test(DomainGroup *dg, ECC *ecc, Scrubber *scrubber, long runCnt, char *filePrefix, int faultCount, std::string *faults);
protected:
    void reset();
    void printSummary(FILE *fd, long runNum);
    double advance(double faultRate);

protected:
    // CE + DUE + SDC can be bigger than expected error count
    long RetireCntYear[MAX_YEAR] = {0};
    long DUECntYear[MAX_YEAR] = {0};
    long SDCCntYear[MAX_YEAR] = {0};
};


#endif /* __TESTER_HH__ */
