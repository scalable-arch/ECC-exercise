#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

#include "Config.hh"
#include "Tester.hh"
#include "Scrubber.hh"
#include "FaultDomain.hh"
#include "DomainGroup.hh"
#include "codec.hh"

//------------------------------------------------------------------------------
char errorName[][10] = {"NE ",
                        "CE ",
                        "DE ",
#ifdef DUE_BREAKDOWN
						"DPa","DNE",
#endif
                        "SDC"
#ifdef DUE_BREAKDOWN
					   ,"SEr"
#endif

						};

//------------------------------------------------------------------------------
void TesterSystem::reset() {
    for (int i=0; i<MAX_YEAR; i++) {
        RetireCntYear[i] = 0l;
        DUECntYear[i] = 0l;
        SDCCntYear[i] = 0l;
	}
}

//------------------------------------------------------------------------------
void TesterSystem::printSummary(FILE *fd, long runNum) {
    fprintf(fd, "After %ld runs\n", runNum);
    fprintf(fd, "Retire\n");
    for (int yr=1; yr<MAX_YEAR; yr++) {
        fprintf(fd, "%.11f\n", (double)RetireCntYear[yr]/runNum);
    }
    fprintf(fd, "DUE\n");
    for (int yr=1; yr<MAX_YEAR; yr++) {
        fprintf(fd, "%.11f\n", (double)DUECntYear[yr]/runNum);
    }
    fprintf(fd, "SDC\n");
    for (int yr=1; yr<MAX_YEAR; yr++) {
        fprintf(fd, "%.11f\n", (double)SDCCntYear[yr]/runNum);
    }
    fflush(fd);
}

//------------------------------------------------------------------------------
double TesterSystem::advance(double faultRate) {
    double result = -log(1.0f - (double) rand() / ((long long) RAND_MAX+1)) / faultRate;
    //printf("- %f\n", result);
    return result;
}

//------------------------------------------------------------------------------
void TesterSystem::test(DomainGroup *dg, ECC *ecc, Scrubber *scrubber, long runCnt, char* filePrefix, int faultCount, std::string *faults) {
    assert(faultCount<=1);  // either no or 1 inherent fault

    Fault *inherentFault = NULL;
    // create log file
    std::string nameBuffer = std::string(filePrefix)+".S";


    if (faultCount==1) {    // no inherent fault
        nameBuffer = nameBuffer+"."+faults[0];
        inherentFault = Fault::genRandomFault(faults[0], NULL);
        dg->setInherentFault(inherentFault);
    }


    FILE *fd = fopen(nameBuffer.c_str(), "w");
    assert(fd!=NULL);

    // reset statistics
    reset();

    // for runCnt times
    for (long runNum=0; runNum<runCnt; runNum++) {
        if ((runNum==100) || ((runNum!=0)&&(runNum%100000000==0))) {
            printSummary(fd, runNum);
        }
        if (runNum%10000000==0) {
        //if (runNum%1000000==0) {
            printf("Processing %ldth iteration\n", runNum);
        }

        if (inherentFault!=NULL) {
            dg->setInitialRetiredBlkCount(ecc);
        }

        double hr = 0.;

        while (true) {
            // 1. Advance
            double prevHr = hr;
            hr += advance(dg->getFaultRate());

            if (hr > (MAX_YEAR-1)*24*365) {
                break;
            }

            // 2. scrub soft errors
            scrubber->scrub(dg, hr);

            // 3. generate a fault
            FaultDomain *fd = dg->pickRandomFD();

            // 4. generate an error and decode it
            ErrorType result = fd->genSystemRandomFaultAndTest(ecc);

            // 5. process result
			// default : PF retirement
            if ((result==CE)&&ecc->getDoRetire()&&(fd->getRetiredBlkCount() > ecc->getMaxRetiredBlkCount())) {
//printf("%d %llu %llu\n", ecc->getDoRetire(), fd->getRetiredBlkCount(), ecc->getMaxRetiredBlkCount());
                printf("CE, hours %lf (%lfyrs)\n",hr,hr/(24*365));
                for (int i=0; i<MAX_YEAR; i++) {
                    if (hr < i*24*365) {
                        RetireCntYear[i]++;
                    }
                }
                break;
            } else if (result==DUE) {
                printf("DUE, hours %lf (%lfyrs)\n",hr,hr/(24*365));
                for (int i=0; i<MAX_YEAR; i++) {
                    if (hr < i*24*365) {
                        DUECntYear[i]++;
                    }
                }
                break;
            } else if (result==SDC) {
                printf("hours %lf (%lfyrs)\n", hr, hr/(24*365));
                for (int i=0; i<MAX_YEAR; i++) {
                    if (hr < i*24*365) {
                        SDCCntYear[i]++;
                    }
                }
                break;
            } 
        }

        dg->clear();
        ecc->clear();
    }
    printSummary(fd, runCnt);

    fclose(fd);
}