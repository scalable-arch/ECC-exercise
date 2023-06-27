/**
 * @file: Fault.cc
 * @author: Jungrae Kim <dale40@gmail.com>
 * Fault implementation
 */

#include <string.h>
#include <stdio.h>
#include <iostream>

#include "common.hh"
#include "Config.hh"
#include "Fault.hh"

//----------------------------------------------------------
std::default_random_engine randomGenerator;

//----------------------------------------------------------
Fault::Fault(std::string _name)
: name(_name), fd(NULL), mask(SBIT_MASK), isInherent(true), isTransient(PERMANENT), numDQ(1), isSingleBeat(SINGLE_BEAT), isMultiRow(SINGLE_ROW), isMultiColumn(SINGLE_COLUMN), isChannel(NO_CHANNEL), affectedBlkCount(0) {}

Fault::Fault(FaultDomain *_fd, std::string _name, ADDR _mask, bool _isInherent, bool _isTransient, int _numDQ, bool _isSingleBeat, bool _isMultiRow, bool _isMultiColumn, bool _isChannel, unsigned long long _affectedBlkCount)
: fd(_fd), name(_name), mask(_mask), isInherent(_isInherent), isTransient(_isTransient), numDQ(_numDQ), isSingleBeat(_isSingleBeat), isMultiRow(_isMultiRow), isMultiColumn(_isMultiColumn), isChannel(_isChannel), affectedBlkCount(_affectedBlkCount) {
    if (isSingleBeat) {
        // start = end, count = 1
        beatStart = rand()%fd->getBeatHeight();
        beatEnd = beatStart;
        beatCount = 1;
    } else {
        beatStart = 0;
        beatEnd = fd->getBeatHeight()-1;
        beatCount = fd->getBeatHeight();
    }
    chipPos = rand() % fd->getChannelWidth() / fd->getChipWidth();
    for (int i=0; i<numDQ; i++) {
        if (numDQ==fd->getChipWidth()) {
            pinPos[i] = chipPos * fd->getChipWidth() + i;
        } else {
            bool isConflict;
            int pin;
            do {
                pin = rand() % fd->getChipWidth() + chipPos*fd->getChipWidth();
                isConflict = false;
                for (int j=0; j<i; j++) {
                    if (pinPos[j]==pin) {
                        isConflict = true;
                    }
                }
            } while (isConflict);
            pinPos[i] = pin;
        }
    }
    addr = RAND_MAX*((ADDR)rand()) + rand();   // 64-bit
    cellFaultRate = .0;
}

Fault *Fault::genRandomFault(std::string type, FaultDomain *fd) {
    if (type=="b") {
        return new SingleBitFault(fd, false);
    } else if (type=="w") {
        return new SingleWordFault(fd, false, fd->getChipWidth());
    } else if (type=="p") {
        return new SinglePinFault(fd, false);
    } else if (type=="c") {
        return new SingleChipFault(fd, false, fd->getChipWidth());
    } else if (type=="r") {
        return new ChannelFault(fd, false);
    } else if (type=="i3") {
        return new InherentFault(fd, 1e-3);
    } else if (type=="i4") {
        return new InherentFault(fd, 1e-4);
    } else if (type=="i5") {
        return new InherentFault(fd, 1e-5);
    } else if (type=="i6") {
        return new InherentFault(fd, 1e-6);
    } else if (type=="i7") {
        return new InherentFault(fd, 1e-7);
    } else if (type=="i8") {
        return new InherentFault(fd, 1e-8);
    } else if (type=="i9") {
        return new InherentFault(fd, 1e-9);
    } else if (type=="i10") {
        return new InherentFault(fd, 1e-10);
    } else if (type=="i3-1") {
        return new InherentFault2(fd, 1e-3, 1);
    } else if (type=="i4-1") {
        return new InherentFault2(fd, 1e-4, 1);
    } else if (type=="i5-1") {
        return new InherentFault2(fd, 1e-5, 1);
    } else if (type=="i6-1") {
        return new InherentFault2(fd, 1e-6, 1);
    } else if (type=="i7-1") {
        return new InherentFault2(fd, 1e-7, 1);
    } else if (type=="i8-1") {
        return new InherentFault2(fd, 1e-8, 1);
    } else if (type=="i9-1") {
        return new InherentFault2(fd, 1e-9, 1);
    } else if (type=="i10-1") {
        return new InherentFault2(fd, 1e-10, 1);
    } else if (type=="i3-2") {
        return new InherentFault2(fd, 1e-3, 2);
    } else if (type=="i4-2") {
        return new InherentFault2(fd, 1e-4, 2);
    } else if (type=="i5-2") {
        return new InherentFault2(fd, 1e-5, 2);
    } else if (type=="i6-2") {
        return new InherentFault2(fd, 1e-6, 2);
    } else if (type=="i7-2") {
        return new InherentFault2(fd, 1e-7, 2);
    } else if (type=="i8-2") {
        return new InherentFault2(fd, 1e-8, 2);
    } else if (type=="i9-2") {
        return new InherentFault2(fd, 1e-9, 2);
    } else if (type=="i10-2") {
        return new InherentFault2(fd, 1e-10, 2);
    } else if (type=="sbit-t") {
        return new SingleBitFault(fd, true);
    } else if (type=="sbit-p") {
        return new SingleBitFault(fd, false);
    } else if (type=="sword-2p-t") {
        return new SingleWordFault(fd, true, 2);
    } else if (type=="sword-2p-p") {
        return new SingleWordFault(fd, false, 2);
    } else if (type=="sword-3p-t") {
        return new SingleWordFault(fd, true, 3);
    } else if (type=="sword-3p-p") {
        return new SingleWordFault(fd, false, 3);
    } else if (type=="sword-4p-t") {
        return new SingleWordFault(fd, true, 4);
    } else if (type=="sword-4p-p") {
        return new SingleWordFault(fd, false, 4);
    } else if (type=="sword-np-t") {
        return new SingleWordFault(fd, true, fd->getChipWidth());
    } else if (type=="sword-np-p") {
        return new SingleWordFault(fd, false, fd->getChipWidth());
    } else if (type=="scol-1p-t") {
        return new SingleColumnFault(fd, true, 1);
    } else if (type=="scol-1p-p") {
        return new SingleColumnFault(fd, false, 1);
    } else if (type=="scol-2p-t") {
        return new SingleColumnFault(fd, true, 2);
    } else if (type=="scol-2p-p") {
        return new SingleColumnFault(fd, false, 2);
    } else if (type=="scol-3p-t") {
        return new SingleColumnFault(fd, true, 3);
    } else if (type=="scol-3p-p") {
        return new SingleColumnFault(fd, false, 3);
    } else if (type=="scol-4p-t") {
        return new SingleColumnFault(fd, true, 4);
    } else if (type=="scol-4p-p") {
        return new SingleColumnFault(fd, false, 4);
    } else if (type=="scol-np-t") {
        return new SingleColumnFault(fd, true, fd->getChipWidth());
    } else if (type=="scol-np-p") {
        return new SingleColumnFault(fd, false, fd->getChipWidth());
    } else if (type=="srow-1p-t") {
        return new SingleRowFault(fd, true, 1);
    } else if (type=="srow-1p-p") {
        return new SingleRowFault(fd, false, 1);
    } else if (type=="srow-2p-t") {
        return new SingleRowFault(fd, true, 2);
    } else if (type=="srow-2p-p") {
        return new SingleRowFault(fd, false, 2);
    } else if (type=="srow-3p-t") {
        return new SingleRowFault(fd, true, 3);
    } else if (type=="srow-3p-p") {
        return new SingleRowFault(fd, false, 3);
    } else if (type=="srow-4p-t") {
        return new SingleRowFault(fd, true, 4);
    } else if (type=="srow-4p-p") {
        return new SingleRowFault(fd, false, 4);
    } else if (type=="srow-np-t") {
        return new SingleRowFault(fd, true, fd->getChipWidth());
    } else if (type=="srow-np-p") {
        return new SingleRowFault(fd, false, fd->getChipWidth());
    } else if (type=="sbank-1p-t") {
        return new SingleBankFault(fd, true, 1);
    } else if (type=="sbank-1p-p") {
        return new SingleBankFault(fd, false, 1);
    } else if (type=="sbank-2p-t") {
        return new SingleBankFault(fd, true, 2);
    } else if (type=="sbank-2p-p") {
        return new SingleBankFault(fd, false, 2);
    } else if (type=="sbank-3p-t") {
        return new SingleBankFault(fd, true, 3);
    } else if (type=="sbank-3p-p") {
        return new SingleBankFault(fd, false, 3);
    } else if (type=="sbank-4p-t") {
        return new SingleBankFault(fd, true, 4);
    } else if (type=="sbank-4p-p") {
        return new SingleBankFault(fd, false, 4);
    } else if (type=="sbank-np-t") {
        return new SingleBankFault(fd, true, fd->getChipWidth());
    } else if (type=="sbank-np-p") {
        return new SingleBankFault(fd, false, fd->getChipWidth());
    } else if (type=="mbank-1p-t") {
        return new MultiBankFault(fd, true, 1);
    } else if (type=="mbank-1p-p") {
        return new MultiBankFault(fd, false, 1);
    } else if (type=="mbank-2p-t") {
        return new MultiBankFault(fd, true, 2);
    } else if (type=="mbank-2p-p") {
        return new MultiBankFault(fd, false, 2);
    } else if (type=="mbank-3p-t") {
        return new MultiBankFault(fd, true, 3);
    } else if (type=="mbank-3p-p") {
        return new MultiBankFault(fd, false, 3);
    } else if (type=="mbank-4p-t") {
        return new MultiBankFault(fd, true, 4);
    } else if (type=="mbank-4p-p") {
        return new MultiBankFault(fd, false, 4);
    } else if (type=="mbank-np-t") {
        return new MultiBankFault(fd, true, fd->getChipWidth());
    } else if (type=="mbank-np-p") {
        return new MultiBankFault(fd, false, fd->getChipWidth());
    } else if (type=="mrank-1p-t") {
        return new MultiRankFault(fd, true, 1);
    } else if (type=="mrank-1p-p") {
        return new MultiRankFault(fd, false, 1);
    } else if (type=="mrank-2p-t") {
        return new MultiRankFault(fd, true, 2);
    } else if (type=="mrank-2p-p") {
        return new MultiRankFault(fd, false, 2);
    } else if (type=="mrank-3p-t") {
        return new MultiRankFault(fd, true, 3);
    } else if (type=="mrank-3p-p") {
        return new MultiRankFault(fd, false, 3);
    } else if (type=="mrank-4p-t") {
        return new MultiRankFault(fd, true, 4);
    } else if (type=="mrank-4p-p") {
        return new MultiRankFault(fd, false, 4);
    } else if (type=="mrank-np-t") {
        return new MultiRankFault(fd, true, fd->getChipWidth());
    } else if (type=="mrank-np-p") {
        return new MultiRankFault(fd, false, fd->getChipWidth());
    } else {
        assert(0);
        return NULL;
    }
}

//----------------------------------------------------------
