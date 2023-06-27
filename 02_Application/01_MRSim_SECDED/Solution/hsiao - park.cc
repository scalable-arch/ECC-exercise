/**
 * @file: hsiao.cc
 * @author: Jungrae Kim <dale40@gmail.com>
 * CODEC implementation (HSIAO)
 */

#include <string.h>
#include <limits.h>
#include <stdlib.h>
#include "hsiao.hh"
#include <iostream>

//--------------------------------------------------------------------
//// From "A Class of Optimal Minimum Odd-weight-column SEC-DED Codes" / Hsiao / 1970
//// (72,64) code
//// 8C1 (=8) + 8C3 (=56) + 8C5 (=8 e.a.)
//// total weight = 8 + 3*56 + 5*8 = 216
//// average number of 1s in each row = 27
//// average number of 1s in Hb = 26
                    /*           8                          8                        8                     8                          8                        8                        8                        8            --> # of columns = 64(== bitK)  */
uint8_t HSIAO_PT[] = {1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1 ,1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,   
                      1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  //
                      0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  //
                      0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  //  # of rows = 8 (== bitR)
                      0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  // 
                      1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  //
                      0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1,  0, 0, 1, 0, 0, 1, 1, 0,  //
                      0, 0, 1, 0, 0, 1, 1, 0,  0, 1, 0, 0, 1, 0, 0, 1,  1, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 1, 1,  0, 0, 0, 1, 1, 1, 0, 0,  1, 1, 1, 0, 0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1, 1};

Hsiao::Hsiao(const char *name, int _bitN, int _bitR)
    : BinaryLinearCodec(name, _bitN, _bitR) {
    
    /*
        To do:
        1. make generate matrix
        2. make parity check matrix

        Hint:
        G = [Ik: P], shpae is kxn
        H = [-P.T:I(n-k)], shape is nx(n-k)  
    */

    // PARK - Generator matrix
    for(int row=0; row < bitK; row++){
        for(int col=0; col < bitN; col++){

            // Identity matrix
            if(col >= bitR){
                gMatrix[row*bitN+col] = (row==(col-bitR))? 1 : 0;
            }
            // Parity matrix, transpose to P matrix
            else{
                gMatrix[row*bitN+col]=HSIAO_PT[col*bitK+row];
            }
        }
    }

    
    // PARK - Parity Check matrix
    for(int row=0; row < bitR; row++){
        for(int col=0; col < bitN; col++){
            // Identity matrix
            if(col < bitR){
                hMatrix[row*bitN+col] = (row==col)? 1 : 0;
            }
            // Parity matrix, original P matrix
            else{
                hMatrix[row*bitN+col]=HSIAO_PT[row*bitK+(col-bitR)];
            }
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
    //std::cout << "The synError is : "<<synError << std::endl;


    // ** PARK **  //
    //step 3: try to correct using parity check matrix. 
    //step 3-(1): determine the errorType.

    // error is detectd.
    if(synError){
        // search syndrome in hMatrix
        for(int col=0; col<bitN; col++){
            bool all_eqaul=true;
            for(int row=0; row<bitR; row++){
                if(hMatrix[row*bitN+col] != syndrom[row]){
                    all_eqaul=false;
                    break;
                }
            }
            if(all_eqaul){
                decoded->invBit(col);
                if(decoded->isZero()){
                    return CE;
                }else{
                    return SDC;
                }
            }
        }
        return DUE;
    }else{
        return SDC;
    }
}

/**
 * 
 *  @return: wheter there is syndrome or not in received codeword.
 * 
 */
bool Hsiao::genSyndrome(ECCWord *msg) {
    bool synError = false;

    // PARK - H.dot(msg.T)
    for(int row=0; row<bitR; row++){
        syndrom[row] = 0;
        for(int col=0; col<bitN; col++){
            syndrom[row] ^= hMatrix[row*bitN+col]&msg->getBit(col);
        }

        if(syndrom[row])
            synError = true;
    }

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

