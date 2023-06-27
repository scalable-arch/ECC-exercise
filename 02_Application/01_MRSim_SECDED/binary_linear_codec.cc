/**
 * @file: binary_linear_codec.cc
 * @author: Jungrae Kim <dale40@gmail.com>
 * CODEC implementation (binary linear codec)
 */

#include <string.h>
#include <limits.h>
#include <stdlib.h>

#include "binary_linear_codec.hh"

//--------------------------------------------------------------------
BinaryLinearCodec::BinaryLinearCodec(const char *name, int _bitN, int _bitR)
    : Codec(name, _bitN, _bitR) {
    syndrom = new uint8_t[bitR];
    gMatrix = new uint8_t[bitK*bitN];
    hMatrix = new uint8_t[bitR*bitN];
}

BinaryLinearCodec::~BinaryLinearCodec() {
    delete syndrom;
    delete gMatrix;
    delete hMatrix;
}

void BinaryLinearCodec::encode(Block *data, ECCWord *encoded) {
    // Step 1: 
    // reset encoded message;
    encoded->reset();

    // Step 2:
    // use G matrix to calculate encoded message
    // output = input (1xk) x G (kxn)
    for (int i=bitN-1; i>=0; i--) {
        int buffer = 0;
        for (int j=bitK-1; j>=0; j--) {
            buffer ^= data->getBit(j) & gMatrix[j*bitN+i];
        }
        encoded->setBit(i, buffer);
    }
}

void BinaryLinearCodec::print(FILE *fd) {
    fprintf(fd, "G matrix\n");
    for (int i=bitK-1; i>=0; i--) {
        for (int j=bitN-1; j>=0; j--) {
            fprintf(fd, "%d ", gMatrix[i*bitN+j]);
        }
        fprintf(fd, "\n");
    }
    fprintf(fd, "H matrix\n");
    for (int i=bitR-1; i>=0; i--) {
        for (int j=bitN-1; j>=0; j--) {
            fprintf(fd, "%d ", hMatrix[i*bitN+j]);
        }
        fprintf(fd, "\n");
    }
}

