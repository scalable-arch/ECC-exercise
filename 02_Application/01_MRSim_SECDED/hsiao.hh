/**
 * @file: binary_linear_codec.hh
 * @author: Jungrae Kim <dale40@gmail.com>
 * CODEC declaration (HSIAO)
 */

#ifndef __HSIAO_HH__
#define __HSIAO_HH__

#include <stdint.h>
#include "message.hh"
#include "binary_linear_codec.hh"
#include "codec.hh"

class Hsiao: public BinaryLinearCodec {
    // Constructor / destructor
public:
    Hsiao(const char *name, int bitN, int bitR);
    // member methods
	bool genSyndrome(ECCWord *msg);
    ErrorType decode(ECCWord *msg, ECCWord *decoded, std::set<int>* correctedPos = NULL);
private:
    void verifyMatrix();
};

#endif /* __HSIAO_HH__ */
