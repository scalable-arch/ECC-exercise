/**
 * @file: binary_linear_codec.hh
 * @author: Jungrae Kim <dale40@gmail.com>
 * CODEC declaration (HSIAO)
 */

#ifndef __BINARY_LINEAR_CODEC_HH__
#define __BINARY_LINEAR_CODEC_HH__

#include <stdint.h>
#include "codec.hh"
#include "message.hh"

class BinaryLinearCodec : public Codec {
    // Constructor / destructor
public:
    BinaryLinearCodec(const char *name, int bitN, int bitR);
    ~BinaryLinearCodec();
    // member methods
public:
    void encode(Block *data, ECCWord *encoded);
    virtual ErrorType decode(ECCWord *msg, ECCWord *decoded, std::set<int>* correctedPos = NULL) = 0;
protected:
    void print(FILE *fd);
    // member fields
protected:
    uint8_t (*syndrom);
    // P matrix: rxk
    uint8_t *gMatrix;       // G: k x n matrix (1D representation) / Identity matrix at MSB
    uint8_t *hMatrix;       // H: r x n matrix (1D representation) / Identity matrix at LSB
};

#endif /* __BINARY_LINEAR_CODEC_HH__ */
