#ifndef __FAULT_RATE_INFO_HH__
#define __FAULT_RATE_INFO_HH__

#include <stdlib.h>
#include <assert.h>
#include <string>
#include <iostream>
#include <list>

#include "common.hh"
#include "Config.hh"

class FaultRateInfo {
public:
    FaultRateInfo() { totalRate = .0; }
public:
    double getTotalRate() { return totalRate; }
    void addFaultRate(std::string name, double rate) {
        rateInfo.push_back(std::make_pair(name, rate));
        totalRate += rate;
    }
    std::string pickRandomType() {
        double draw = (double)rand() / RAND_MAX;
        double sum = .0;
        for (auto it=rateInfo.cbegin(); it!=rateInfo.cend(); it++) {
            sum += (*it).second;
            if ((sum/totalRate) >= draw) {
                return (*it).first;
            }
        }
        assert(0);
    }
protected:
    std::list<std::pair<std::string, double>> rateInfo;
    double totalRate;
};

class DefaultFaultRateInfo : public FaultRateInfo {
public:
    DefaultFaultRateInfo() : FaultRateInfo() {
        // single-bit   : transient 14.2 FIT, permanent 18.6 FIT
        addFaultRate("sbit-t", 14.2 FIT);
        addFaultRate("sbit-p", 18.6 FIT);
        // single-word  : transient 1.4 FIT, permanent 0.3 FIT
        addFaultRate("sword-4p-t", 1.4 FIT);
        addFaultRate("sword-4p-p", 0.3 FIT);
        // single-column: transient 1.4 FIT, permanent 5.6 FIT
        //                single-DQ 85.8%
        addFaultRate("scol-1p-t", 1.4 * 0.858 FIT);
        addFaultRate("scol-1p-p", 5.6 * 0.858 FIT);
        addFaultRate("scol-2p-t", 1.4 * 0.033 FIT);
        addFaultRate("scol-2p-p", 5.6 * 0.033 FIT);
        addFaultRate("scol-3p-t", 1.4 * 0.008 FIT);
        addFaultRate("scol-3p-p", 5.6 * 0.008 FIT);
        addFaultRate("scol-4p-t", 1.4 * 0.100 FIT);
        addFaultRate("scol-4p-p", 5.6 * 0.100 FIT);
        // single-row   : transient 0.2 FIT, permanent 8.2 FIT
        //                single-DQ 31.1%
        addFaultRate("srow-1p-t", 0.2 * 0.311 FIT);
        addFaultRate("srow-1p-p", 8.2 * 0.311 FIT);
        addFaultRate("srow-2p-t", 0.2 * 0.668 FIT);
        addFaultRate("srow-2p-p", 8.2 * 0.668 FIT);
        addFaultRate("srow-3p-t", 0.2 * 0.014 FIT);
        addFaultRate("srow-3p-p", 8.2 * 0.014 FIT);
        addFaultRate("srow-4p-t", 0.2 * 0.178 FIT);
        addFaultRate("srow-4p-p", 8.2 * 0.178 FIT);
        // single-bank  : transient 0.8 FIT, permanent 10.0 FIT
        //                single-DQ 55.5%
        addFaultRate("sbank-1p-t", 0.8  * 0.555 FIT);
        addFaultRate("sbank-1p-p", 10.0 * 0.555 FIT);
        addFaultRate("sbank-2p-t", 0.8  * 0.230 FIT);
        addFaultRate("sbank-2p-p", 10.0 * 0.230 FIT);
        addFaultRate("sbank-3p-t", 0.8  * 0.035 FIT);
        addFaultRate("sbank-3p-p", 10.0 * 0.035 FIT);
        addFaultRate("sbank-4p-t", 0.8  * 0.456 FIT);
        addFaultRate("sbank-4p-p", 10.0 * 0.456 FIT);
        // multi-bank   : transient 0.3 FIT, permanent 1.4 FIT
        //                single-DQ 17.5%
        addFaultRate("mbank-1p-t", 0.3 * 0.175 FIT);
        addFaultRate("mbank-1p-p", 1.4 * 0.175 FIT);
        addFaultRate("mbank-2p-t", 0.3 * 0.333 FIT);
        addFaultRate("mbank-2p-p", 1.4 * 0.333 FIT);
        addFaultRate("mbank-3p-t", 0.3 * 0.035 FIT);
        addFaultRate("mbank-3p-p", 1.4 * 0.035 FIT);
        addFaultRate("mbank-4p-t", 0.3 * 0.456 FIT);
        addFaultRate("mbank-4p-p", 1.4 * 0.456 FIT);
        // multi-rank   : transient 0.9 FIT, permanent 2.8 FIT
        //                single-DQ 7.5%
        addFaultRate("mrank-1p-t", 0.9 * 0.075 FIT);
        addFaultRate("mrank-1p-p", 2.8 * 0.075 FIT);
        addFaultRate("mrank-2p-t", 0.9 * 0.071 FIT);
        addFaultRate("mrank-2p-p", 2.8 * 0.071 FIT);
        addFaultRate("mrank-3p-t", 0.9 * 0.018 FIT);
        addFaultRate("mrank-3p-p", 2.8 * 0.018 FIT);
        addFaultRate("mrank-4p-t", 0.9 * 0.836 FIT);
        addFaultRate("mrank-4p-p", 2.8 * 0.836 FIT);

        /*
        addFaultRate("scol-np-t", 1.4 * (1-0.858) FIT);
        addFaultRate("scol-np-p", 5.6 * (1-0.858) FIT);
        addFaultRate("srow-np-t", 0.2 * (1-0.311) FIT);
        addFaultRate("srow-np-p", 8.2 * (1-0.311) FIT);
        addFaultRate("sbank-np-t", 0.8  * (1-0.555) FIT);
        addFaultRate("sbank-np-p", 10.0 * (1-0.555) FIT);
        addFaultRate("mbank-np-t", 0.3 * (1-0.175) FIT);
        addFaultRate("mbank-np-p", 1.4 * (1-0.175) FIT);
        addFaultRate("mrank-np-t", 0.9 * (1-0.075) FIT);
        addFaultRate("mrank-np-p", 2.8 * (1-0.075) FIT);
        */
    }
};
#endif /* __FAULT_RATE_INFO_HH__ */
