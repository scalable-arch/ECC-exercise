/**
 * @file: message.hh
 * @author: Jungrae Kim <dale40@gmail.com>
 * message declaration
 */

#ifndef __MESSAGE_HH__
#define __MESSAGE_HH__

#include <stdio.h>

#include "util.hh"

//----------------------------------------------------------
typedef enum {LINEAR, AMD, PIN, DPIN, MULTIX4, MULTIX8, PIN9, PIN17, ONCHIPx4, ONCHIPx4_2, ONCHIPx8} ECCLayout;

class Block {
    // constructor / destructor
public:
    Block(int bitSize);
    ~Block();

    // member methods
public:
    int getBitN() { return bitN; }
    void reset();
    bool isZero();
    void clone(Block* src);
    bool equal(Block* ref);
    int  getSymbol(int size, int pos);
    void setSymbol(int size, int pos, int value);
    void invSymbol(int size, int pos, int value);
    bool getBit(int pos) { return bitArr[pos]; }
    void setBit(int pos, bool value) { bitArr[pos] = value; }
    void invBit(int pos) { bitArr[pos] ^= true; }
    void print(FILE *fd = stdout) const;
    void copy(const Block *src) {
        for (int i=0; i<bitN; i++) {
            bitArr[i] = src->bitArr[i];
        }
    }

    Block &operator^=(const Block &rhs) {
        for (int i=0; i<bitN; i++) {
            bitArr[i] ^= rhs.bitArr[i];
        }
        return *this;
    }

    friend class ECCWord;
    friend class CacheLine;
protected:
    int bitN;
public:
    bool *bitArr;
};

//----------------------------------------------------------
// MSB: redudancy
// LSB: data
class ECCWord : public Block {
    // constructor / destructor
public:
    ECCWord(int bitN, int _bitK): Block(bitN), bitK(_bitK) {}

    // member methods
public:
    int getBitK() { return bitK; }

    void extract(Block* data, ECCLayout layout, int pos, int channelWidth);

    // member fields
private:
    int bitK;
};

//----------------------------------------------------------
// data layout: <---------- DQ ------------>
//             | 0  1  2  3  4   5 ...    71
//            BL 72 73 74 75 76 77 ...    143
//             | ...
class CacheLine : public Block {
    // constructor/destructor
public:
    CacheLine(int _chipWidth, int _channelWidth, int _beatHeight)
            : Block(_channelWidth*_beatHeight), chipWidth(_chipWidth),
            channelWidth(_channelWidth), beatHeight(_beatHeight) {}
    // member methods
public:
    int getChipWidth() { return chipWidth; }
    int getChipCount() { return channelWidth/chipWidth; }
    int getChannelWidth() { return channelWidth; }
    int getBeatHeight() { return beatHeight; }

    void print(FILE *fd = stdout) const;
    // member fields
protected:
    int chipWidth, channelWidth, beatHeight;
};

#endif /* __MESSAGE_HH__ */
