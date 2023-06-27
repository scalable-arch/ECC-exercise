#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <random>

#include "Config.hh"
#include "FaultRateInfo.hh"

#include "DomainGroup.hh"
#include "Tester.hh"
#include "Scrubber.hh"
#include "prior.hh"

void testBamboo(int ID, DomainGroup *dg);
void testFrugal(int ID);
void testAIECC(int ID);
void testDUO(int ID);

//#define BAMBOO
#define AGECC

int main(int argc, char **argv)
{
    if (argc<5) {
        printf("Usage: %s ECCID runCnt RandomSeed FaultType1 FaultType2 ...\n", argv[0]);
        exit(1);
    }

    // random seed
    srand(atoi(argv[3]));
    //srand(time(NULL));

    char filePrefix[256];
    DomainGroup *dg = NULL;
    ECC *ecc = NULL;
    Tester *tester = NULL;
    Scrubber *scrubber = NULL;

    //int DIMMcnt = 100000;
    int DIMMcnt = 4;


    switch (atoi(argv[1])) {
            //DomainGroupDDR(int domainsPerGroup, int ranksPerDomain, int devicesPerRank, int pinsPerDevice, int blkHeight)

        case 0:
            dg = new DomainGroupDDR(DIMMcnt/2, 2, 18, 4, 8);
            ecc = new SECDED72b();
            sprintf(filePrefix, "010.4x18.SECDED.%s", argv[3]);
            break;

        default:
            printf("Invalid ECC ID\n");
            exit(1);
    }


    tester = new TesterSystem();
    scrubber = new PeriodicScrubber(8);

    std::string faults[argc-5];
    for (int i=5; i<argc; i++) {
        faults[i-5] = std::string(argv[i]);
    }
    tester->test(dg, ecc, scrubber, atol(argv[2]), filePrefix, argc-5, faults);
    delete tester;
    delete scrubber;
}

