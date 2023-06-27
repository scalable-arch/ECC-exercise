/**
 * @file: Fault.hh
 * @author: Jungrae Kim <dale40@gmail.com>
 * Fault declaration
 */

#ifndef __FAULT_HH__
#define __FAULT_HH__

#include <string>
#include <random>
#include "common.hh"
#include "Config.hh"
#include "message.hh"
#include "FaultDomain.hh"
#include "limits.h"

//------------------------------------------------------------------------------
extern std::default_random_engine randomGenerator;

//------------------------------------------------------------------------------
class Fault {
public:
    Fault(std::string _name);
    Fault(FaultDomain *_fd, std::string _name, ADDR _mask, bool _isInherent, bool _isTransient, int _numDQ, bool _isSingleBeat, bool _isMultiRow, bool _isMultiColumn, bool _isChannel, unsigned long long _affectedBlkCount);

public:
    ADDR getAddr() { return addr; }
    ADDR getMask() { return mask; }
    bool getIsInherent() { return isInherent; }
    bool getIsTransient() { return isTransient; }
    int  getNumDQ() { return numDQ; }
    bool getIsSingleDQ() { return numDQ==1; }
    bool getIsSingleBeat() { return isSingleBeat; }
    bool getIsMultiColumn() { return isMultiColumn; }
    bool getIsMultiRow() { return isMultiRow; }
    bool getIsChannel() { return isChannel; }
    unsigned long long  getAffectedBlkCount() { return affectedBlkCount; }
    int  getChipID() { return chipPos; }
    int  getPinID() { return pinPos[0]; }
    int  getPinID1() { return pinPos[1]; }
    double getCellFaultRate() { return cellFaultRate; }

    void print(FILE *fd = stdout) { fprintf(fd, "%s ADDR=%016llx MASK=%016llx (T=%d)\n", name.c_str(), addr, getMask(), isTransient); }
    bool overlap(Fault *other) {
		if(other==NULL) return true;
        // Based on "FaultSim: A Fast, Configurable Memory-Reliability Simulator for Conventional and 3D-Stacked Systems"
        ADDR combinedMask = mask | other->mask;
        ADDR combinedAddr = ~(addr ^ other->addr);
        ADDR total = combinedMask | combinedAddr;
        if (total==0xFFFFFFFFFFFFFFFFull) {
            return true;
        }
        return false;
    }
    virtual void genRandomError(CacheLine *line) {
        if (beatCount*numDQ>64) {
            std::uniform_int_distribution<unsigned long long> randDist = std::uniform_int_distribution<unsigned long long>(0, (1ULL<<numDQ)-1);
            bool noError = true;
            while (noError) {
                for (int beat = 0; beat < beatCount; beat++) {
                    unsigned long long randValue = randDist(randomGenerator);
                    for (int pin = 0; pin<numDQ; pin++) {
                        if ((randValue>>pin)&1) {
                            line->invBit(line->getChannelWidth()*(beat+beatStart)+pinPos[pin]);
                            noError = false;
                        }
                    }
                }
            }
        } else {
            // exclude 0
            std::uniform_int_distribution<unsigned long long> randDist = std::uniform_int_distribution<unsigned long long>(1, (1ULL<<(beatCount*numDQ))-1);
            unsigned long long randValue = randDist(randomGenerator);
            for (int beat = 0; beat < beatCount; beat++) {
                for (int pin = 0; pin<numDQ; pin++) {
                    if ((randValue>>(beat*numDQ+pin))&1) {
                        line->invBit(line->getChannelWidth()*(beat+beatStart)+pinPos[pin]);
                    }
                }
            }
        }
    }

    // static
    static Fault *genRandomFault(std::string type, FaultDomain *fd);
public:
    FaultDomain *fd;
    std::string name;
    ADDR addr;
    ADDR mask;
    bool isInherent;
    bool isTransient;
    int numDQ;
    bool isSingleBeat;
    bool isMultiColumn;
    bool isMultiRow;
    bool isChannel;
    unsigned long long affectedBlkCount;
    int beatStart, beatEnd, beatCount;
    int chipPos;
    int pinPos[8];
    double cellFaultRate;

    static const bool INHERENT = true;
    static const bool OPERATIONAL = false;
    static const bool TRANSIENT = true;
    static const bool PERMANENT = false;
    static const bool SINGLE_BEAT = true;
    static const bool MULTI_BEAT = false;
    static const bool MULTI_COLUMN = true;
    static const bool SINGLE_COLUMN = false;
    static const bool MULTI_ROW = true;
    static const bool SINGLE_ROW = false;
    static const bool CHANNEL = true;
    static const bool NO_CHANNEL = false;
};

//------------------------------------------------------------------------------
class SingleBitFault : public Fault{
public:
    SingleBitFault(FaultDomain *fd, bool _isTransient)
    : Fault(fd, "S-bit", SBIT_MASK, OPERATIONAL, _isTransient, 1, SINGLE_BEAT, SINGLE_ROW, SINGLE_COLUMN, NO_CHANNEL, 1) {}
};

class SingleWordFault : public Fault {
public:
    SingleWordFault(FaultDomain *fd, bool _isTransient, int _numDQ)
    : Fault(fd, "S-word", SWORD_MASK, OPERATIONAL, _isTransient, _numDQ, SINGLE_BEAT, SINGLE_ROW, SINGLE_COLUMN, NO_CHANNEL, 1) { assert(numDQ!=1); }
};

class SinglePinFault : public Fault {
public:
    SinglePinFault(FaultDomain *fd, bool _isTransient)
    : Fault(fd, "S-pin", CHANNEL_MASK, OPERATIONAL, _isTransient, 1, MULTI_BEAT, MULTI_ROW, MULTI_COLUMN, NO_CHANNEL, ((MRANK_MASK^DEFAULT_MASK)+1)/8) {}
};

class SingleChipFault : public Fault {
public:
    SingleChipFault(FaultDomain *fd, bool _isTransient, int _numDQ)
    : Fault(fd, "S-chip", CHANNEL_MASK, OPERATIONAL, _isTransient, _numDQ, MULTI_BEAT, MULTI_ROW, MULTI_COLUMN, NO_CHANNEL, ((MBANK_MASK^DEFAULT_MASK)+1)/8) {}
};

class ChannelFault: public Fault {
public:
    ChannelFault(FaultDomain *fd, bool _isTransient)
    : Fault(fd, "Channel", CHANNEL_MASK, OPERATIONAL, _isTransient, fd->getChipWidth(), MULTI_BEAT, MULTI_COLUMN, MULTI_ROW, CHANNEL, ((MRANK_MASK^DEFAULT_MASK)+1)/8) {}
    void genRandomError(CacheLine *line) {
        bool noError = true;
        while (noError) {
            std::uniform_int_distribution<unsigned long long> randDist = std::uniform_int_distribution<unsigned long long>(0, ULLONG_MAX);
            unsigned long long randValue = randDist(randomGenerator);
            int offset = 0;
            for (int i=line->getBitN()-1; i>=0; i--) {
                if ((randValue>>offset)&1) {
                    line->invBit(i);
                    noError = false;
                }
                offset++;
                if (offset==64) {
                    randValue = randDist(randomGenerator);
                    offset = 0;
                }
            }
        }
    }
};

//------------------------------------------------------------------------------
class SingleColumnFault : public Fault {
public:
    SingleColumnFault(FaultDomain *fd, bool _isTransient, int _numDQ)
    : Fault(fd, "S-col", SCOL_MASK, OPERATIONAL, _isTransient, _numDQ, SINGLE_BEAT, MULTI_ROW, SINGLE_COLUMN, NO_CHANNEL, 0) {
        double p = ((double)rand())/RAND_MAX;
        if (p<0.836) {
            // 1 tile (512 rows)
            affectedBlkCount = 512;
        } else if (p < 0.896) {
            // 2 tiles (1024 rows)
            affectedBlkCount = 1024;
        } else if (p < 0.945) {
            // 3 tiles (1536 rows)
            affectedBlkCount = 1536;
        } else if (p < 0.975) {
            // 5 tiles (2560 rows)
            affectedBlkCount = 2560;
        } else {
            // 6 tiles (3072 rows)
            affectedBlkCount = 3072;
        }
    }
};

class SingleRowFault : public Fault {
public:
    SingleRowFault(FaultDomain *fd, bool _isTransient, int _numDQ)
    : Fault(fd, "S-row", SROW_MASK, OPERATIONAL, _isTransient, _numDQ, MULTI_BEAT, SINGLE_ROW, MULTI_COLUMN, NO_CHANNEL, (((SROW_MASK^DEFAULT_MASK)>>15)+1)/8) {}
};

class SingleBankFault : public Fault {
public:
    SingleBankFault(FaultDomain *fd, bool _isTransient, int _numDQ)
    : Fault(fd, "S-bank", SBANK_MASK, OPERATIONAL, _isTransient, _numDQ, MULTI_BEAT, MULTI_ROW, MULTI_COLUMN, NO_CHANNEL, 0) {
        double p = ((double)rand())/RAND_MAX;
        if (p<0.50) {
            // row cluster (entire row)
            int rowCount = (rand()%84)+2;   // 2~85
            affectedBlkCount = rowCount * (((SROW_MASK^DEFAULT_MASK)>>15)+1)/8;
        } else if (p<0.642) {
            // scattered
            int rowCount = (rand()%249) + 86;   // 86~334
            affectedBlkCount = rowCount;
        } else {
            int rowCount = (rand()%3476) + 335;   // 335~3810
            affectedBlkCount = rowCount;
        }
    }
};

class MultiBankFault : public Fault {
public:
    MultiBankFault(FaultDomain *fd, bool _isTransient, int _numDQ)
    : Fault(fd, "M-bank", MBANK_MASK, OPERATIONAL, _isTransient, _numDQ, MULTI_BEAT, MULTI_ROW, MULTI_COLUMN, NO_CHANNEL, 0) {
        double p = ((double)rand())/RAND_MAX;
        int bankCount;
        if (p<0.462) {
            bankCount = 2;
        } else if (p<0.481) {
            bankCount = 3;
        } else if (p<0.519) {
            bankCount = 4;
        } else if (p<0.596) {
            bankCount = 5;
        } else if (p<0.634) {
            bankCount = 6;
        } else {
            bankCount = 8;
        }
        if (bankCount<=4) {
            for (int i=0; i<bankCount; i++) {
                p = ((double)rand())/RAND_MAX;
                if (p<0.50) {
                    // row cluster (entire row)
                    int rowCount = (rand()%84)+2;   // 2~85
                    affectedBlkCount = rowCount * (((SROW_MASK^DEFAULT_MASK)>>15)+1)/8;
                } else if (p<0.642) {
                    // scattered
                    int rowCount = (rand()%249) + 86;   // 86~334
                    affectedBlkCount = rowCount;
                } else {
                    int rowCount = (rand()%3476) + 335;   // 335~3810
                    affectedBlkCount = rowCount;
                }
            }
        } else {
            affectedBlkCount = bankCount*((SBANK_MASK^DEFAULT_MASK)+1)/8;
        }
    }
};

class MultiRankFault : public Fault {
public:
    MultiRankFault(FaultDomain *fd, bool _isTransient, int _numDQ)
    : Fault(fd, "M-rank", MRANK_MASK, OPERATIONAL, _isTransient, _numDQ, MULTI_BEAT, MULTI_ROW, MULTI_COLUMN, NO_CHANNEL, 0) {
        double p = ((double)rand())/RAND_MAX;
        int bankCount;
        if (p<0.545) {
            bankCount = 8;
        } else if (p<0.697) {
            bankCount = 7;
        } else if (p<0.768) {
            bankCount = 6;
        } else if (p<0.909) {
            bankCount = 5;
        } else if (p<0.939) {
            bankCount = 4;
        } else if (p<0.959) {
            bankCount = 3;
        } else {
            bankCount = 2;
        }
        affectedBlkCount = 2*bankCount*((SBANK_MASK^DEFAULT_MASK)+1)/8;
    }
};

class InherentFault: public Fault {
public:
    InherentFault(FaultDomain *fd, double _cellFaultRate)
    : Fault("Inherent") { cellFaultRate = _cellFaultRate; }

    void genRandomError(CacheLine *line) {
        std::binomial_distribution<int> distribution(line->getBitN(), cellFaultRate);
        int faultyCellCount = distribution(randomGenerator);
        assert(line->isZero());
        for (int i=0; i<faultyCellCount; i++) {
            int bitPos = rand()%line->getBitN();
            if (line->bitArr[bitPos]==0) {
                line->bitArr[bitPos]=1;
            } else {
                // conflict with the previous fault
                // do it again
                i--;
            }
        }
    }
};

class InherentFault2: public Fault {
public:
    InherentFault2(FaultDomain *fd, double _cellFaultRate, int _maxFault)
    : Fault("Inherent2") { cellFaultRate = _cellFaultRate; maxFault = _maxFault; }

    void genRandomError(CacheLine *line) {
        std::binomial_distribution<int> distribution(line->getBitN(), cellFaultRate);
        int faultyCellCount = distribution(randomGenerator);
        assert(line->isZero());
        int limit;
        if (faultyCellCount > maxFault) {
            limit = maxFault;
        } else {
            limit = faultyCellCount;
        }
        for (int i=0; i<limit; i++) {
            int bitPos = rand()%line->getBitN();
            if (line->bitArr[bitPos]==0) {
                line->bitArr[bitPos]=1;
            } else {
                // conflict with the previous fault
                // do it again
                i--;
            }
        }
    }
protected:
    int maxFault;
};

#endif /* __FAULT_HH__ */
