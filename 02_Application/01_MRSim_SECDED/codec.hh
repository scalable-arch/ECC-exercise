/**
 * @file: codec.hh
 * @author: Jungrae Kim <dale40@gmail.com>
 * CODEC declaration 
 */

#ifndef __CODEC_HH__
#define __CODEC_HH__

#include <stdint.h>
#include <string.h>
#include <unordered_map>
#include <set>
#include "message.hh"

// NE: no error
// CE: detected and corrected error
// DUE: detected but uncorrected error
// ME: detected but miscorrected error
// UE: undetected error
// SDC: ME + UE
#include "common.hh"

typedef uint64_t ErrorInfo;
//typedef std::unordered_map<int, int> ErrorInfo; // position, value

//--------------------------------------------------------------------
class Codec {
    // Constructor / destructor
public:
    Codec(const char *name, int _bitN, int _bitR)
        : bitN(_bitN), bitR(_bitR), bitK(_bitN-_bitR) {
        strcpy(this->name, name);
    }
    // member methods
public:
    const char *getName() { return name; }
    inline int getBitN() { return bitN; }
    inline int getBitR() { return bitR; }
    inline int getBitK() { return bitK; }

    virtual void encode(Block *data, ECCWord *encoded) = 0;
    virtual ErrorType decode(ECCWord *msg, ECCWord *decoded, std::set<int>* correctedPos = NULL) = 0;

    virtual int getChipID(int pos) const { return pos; }
    void resetHistory() { correctedChips.clear(); correctedPins.clear(); }
    void insertCorrectionInfo(int symID, int value) {
        correctedChips.insert(getChipID(symID));
        correctedPins.insert(symID);
    }
    virtual bool miscorrectSymDetect() const { return false; }

    // member fields
private:
    char name[256];
protected:
    int bitN;
    int bitR;
    int bitK;

    std::set<int> correctedChips;
    std::set<int> correctedPins;
};

#endif /* __CODEC_HH__ */
