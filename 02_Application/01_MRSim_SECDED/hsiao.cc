/**
 * @file: hsiao.cc
 * @author: Jungrae Kim <dale40@gmail.com>
 * CODEC implementation (HSIAO)
 */

#include <string.h>
#include <limits.h>
#include <stdlib.h>
#include "hsiao.hh"

//--------------------------------------------------------------------
//// From "A Class of Optimal Minimum Odd-weight-column SEC-DED Codes" / Hsiao / 1970
//// (72,64) code
//// 8C1 (=8) + 8C3 (=56) + 8C5 (=8 e.a.)
//// total weight = 8 + 3*56 + 5*8 = 216
//// average number of 1s in each row = 27
//// average number of 1s in Hb = 26

                    /*           8                          8                        8                     8                          8                        8                        8                        8            --> # of columns =    */
uint8_t HSIAO_PT[] = {1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1 ,1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,   
                      1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  //
                      0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  //
                      0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  //  
                      0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  // 
                      1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  //
                      0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  //
                      0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1};

Hsiao::Hsiao(const char *name, int _bitN, int _bitR)
    : BinaryLinearCodec(name, _bitN, _bitR) {
    // G matrix calculation from P matrix (tranposed)
    // G (kxn) = (Ik | P)
    //           MSB   LSB
    for (int i=0; i<bitK; i++) {
        // map Parity (tranposed) matrix
        for (int j=0; j<bitR; j++) {
            gMatrix[i*bitN+j] = HSIAO_PT[j*bitK+i];
        }
        // map indentity matrix, Ik
        for (int j=bitR; j<bitN; j++) {
            gMatrix[i*bitN+j] = ((i==(j-bitR)) ? 1 : 0);
        }
    }

    // H matrix calculation from P matrix (tranposed)
    // H (rxn) = (Pt | I(n-k))
    //           MSB      LSB
    for (int i=0; i<bitR; i++) {
        // map indentity matrix, I(n-k)
        for (int j=0; j<bitR; j++) {
            hMatrix[i*bitN+j] = ((i==j) ? 1 : 0);
        }
        // map Parity (tranposed) matrix
        for (int j=bitR; j<bitN; j++) {
            hMatrix[i*bitN+j] = HSIAO_PT[i*bitK+(j-bitR)];
        }
    }


    //print(stdout);
    verifyMatrix();
}

ErrorType Hsiao::decode(ECCWord *msg, ECCWord *decoded, std::set<int>* correctedPos) {
    // step 1: copy the message data
    decoded->clone(msg);
    
    // step 2: generate syndrome
    bool synError = genSyndrome(msg);

    // Step 3: if all of syndrom bits are zero, the word can be assumed to be error free
    if (synError) {
        // Step 4: trying to find a perfect match between syndrom and a column of the matrix
        for (int i=bitN-1; i>=0; i--) {
            bool all_equal;
            /*
            ///////////////////////////////

             Fill your code here!!

            ////////////////////////////
            */
            if (all_equal) {
                // Step 4.1: Syndrome is the same as the i-th column of matrix -> inverth i-th bit
                decoded->invBit(i);
                if (correctedPos!=NULL) {
                    correctedPos->insert(i);
                }
                if (decoded->isZero()) {
                    return CE;
                } else {
                    return SDC;
                }
            }
        }

        // step 5: Detected
        return DUE;
    } else {
        return SDC;
    }
}

bool Hsiao::genSyndrome(ECCWord *msg) {
    bool synError = false;
    // use H matrix to calculate syndrom
    // output = H (rxn) x input (nx1)
    /*
    ///////////////////////////////

        Fill your code here!!

    ////////////////////////////
    */
    return synError;
}

void Hsiao::verifyMatrix()
{
    int max_row_weight = 0;
    int min_row_weight = INT_MAX;
    for (int i=0; i<bitR; i++) {
        int row_weight = 0;
        for (int j=0; j<bitN; j++) {
            row_weight += hMatrix[i*bitN+j];
        }
        if (row_weight > max_row_weight) max_row_weight = row_weight;
        if (row_weight < min_row_weight) min_row_weight = row_weight;
    }

    if ((max_row_weight - min_row_weight) > 1) {
        fprintf(stderr, "Invalid Hsiao matrix: Max row weight: %d Min row weight: %d\n", max_row_weight, min_row_weight);
        exit(-1);
    }

    // G x Ht = 0
    for (int i=0; i<bitK; i++) {
        for (int j=0; j<bitR; j++) {
            int temp = 0;
            for (int k=0; k<bitN; k++) {
                temp ^= gMatrix[i*bitN+k] & hMatrix[j*bitN+k];
            }
            if (temp!=0) {
                fprintf(stderr, "BAD H and G matrix %d\n", i);
                exit(-1);
            }
        }
    }
}

