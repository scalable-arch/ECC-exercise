#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <ctime>
#include<iostream>
#include<cstdlib>
#include <vector>
#include <set>
#include <algorithm>
#include <math.h>
#include <cstring>
#include <bitset>

// Configuration 
// Modify if necessary
#define CHANNEL_WIDTH 40
#define CHIP_NUM 10
#define CHIP_WIDTH 4
#define BLHEIGHT 32 // RECC checks the Burst length (only considering BL32, excluding the redundancy of on-die ecc. Take into account the conservative mode condition)
#define SYMBOL_SIZE 8 // Symbol size implemented in RECC (if 8, then GF(2^8))

#define OECC_CW_LEN 136 // Length of the codeword for on-die ecc (in bits)
#define OECC_DATA_LEN 128 // Length of the dataword for ondie ecc (in bits)
#define OECC_REDUN_LEN 8 // Length of the redundancy for ondie ecc (in bits)

#define RECC_CW_LEN 80 // Length of the codeword for rank-level ecc (in bits)
#define RECC_DATA_LEN 64 // Length of the dataword for rank-level ecc (in bits)
#define RECC_REDUN_LEN 16 // Length of the redundancy for rank-level ecc (in bits)

#define RECC_REDUN_SYMBOL_NUM 2 // Redundancy length of rank-level ecc (in symbol units)
#define RECC_CW_SYMBOL_NUM 10 // Codeword length of rank-level ecc (in symbol units)

//configuration over

using namespace std;
unsigned int primitive_poly[16][256]={0,}; // 16 primitive polynomials, each with 256 unique values (0 is represented at the end of each row). For example: primitive_poly[4][254] = a^254, primitive_poly[4][255] = 0 (for prim_num=4, with primitive_poly = x^8+x^6+x^4+x^3+x^2+x^1+1)
vector<unsigned int> SSC_Syndromes; // Keep Syndromes
unsigned int H_Matrix_RECC[RECC_REDUN_SYMBOL_NUM][RECC_CW_SYMBOL_NUM]; // 2 x 10 => Rank-level ECC H-Matrix 
enum RESULT_TYPE {NE=0, CE=1, DUE=2, SDC=3}; // result_type

// A function that reads and returns the specified bit from an integer
unsigned int getAbit(unsigned short x, int n) { 
  return (x & (1 << n)) >> n;
}

// Convert polynomial form to decimal
unsigned int conversion_to_int_format(char *str_read, int m)
{
    unsigned int primitive_value=0;
    if(strstr(str_read,"^7")!=NULL)
        primitive_value+=int(pow(2,7));
    if(strstr(str_read,"^6")!=NULL)
        primitive_value+=int(pow(2,6));
    if(strstr(str_read,"^5")!=NULL)
        primitive_value+=int(pow(2,5));
    if(strstr(str_read,"^4")!=NULL)
        primitive_value+=int(pow(2,4));
    if(strstr(str_read,"^3")!=NULL)
        primitive_value+=int(pow(2,3));
    if(strstr(str_read,"^2")!=NULL)
        primitive_value+=int(pow(2,2));
    if(strstr(str_read,"^1+")!=NULL) // Because +1 is always added next!
        primitive_value+=int(pow(2,1));
    if(strstr(str_read,"+1")!=NULL)
        primitive_value+=int(pow(2,0));
    

    return primitive_value;
}

// primitive polynomial table generation
void generate_primitive_poly(unsigned int prim_value, int m, int prim_num)
{
    unsigned int value = 0x1; // start value (0000 0001)
    int total_count = int(pow(2,m));
    int count=0;
    while (count<total_count-1){ // count : 0~254
        primitive_poly[prim_num][count]=value;
        if(value>=0x80){ // If the m-th digit is 1, perform an XOR operation with the primitive polynomial
            // "Change the (m+1)-th digit of the value to 0 and shift
            value=value<<(32-m+1);
            value=value>>(32-m);

            // XOR operation with the primitive polynomial
            value=value^prim_value;
        }
        else // If the (m+1)-th digit is 0, shift one position to the left
            value=value<<1;
        
        count++;
    }

    return;
}

void encoding(unsigned int data[RECC_DATA_LEN], unsigned int codeword[RECC_CW_LEN])
{
    // Set the codeword (the first 64 bits are identical to the data, Systematic-Encoding)
    for(int index=0; index<RECC_DATA_LEN; index++)
        codeword[index]=data[index];
    for(int index=RECC_DATA_LEN; index<RECC_CW_LEN; index++)
        codeword[index]=0;

    // Calculate bits 65~72
    for(int index=0; index<RECC_DATA_LEN; index++){
        codeword[RECC_DATA_LEN+index%SYMBOL_SIZE]^=data[index];
    }

    // Calculate bits 73~80
    // data = a^d0, a^d1, a^d2 ... , a^d7
    for(int index=0; index<RECC_DATA_LEN/SYMBOL_SIZE; index++){ // 0~7
        unsigned int symbol_value=0; // 0000_0000 ~ 1111_1111
        symbol_value^=(data[index*8]<<7);
        symbol_value^=(data[index*8+1]<<6);
        symbol_value^=(data[index*8+2]<<5);
        symbol_value^=(data[index*8+3]<<4);
        symbol_value^=(data[index*8+4]<<3);
        symbol_value^=(data[index*8+5]<<2);
        symbol_value^=(data[index*8+6]<<1);
        symbol_value^=(data[index*8+7]<<0);

        for(int exponent=0; exponent<256; exponent++){
            if(symbol_value==primitive_poly[0][exponent]){
                if(exponent!=255){
                    symbol_value=primitive_poly[0][(exponent+index)%255]; // a^(d0+0)%255, a^(d1+1)%255, ...., a^(d7+7)%255
                    break;
                }
            }
        }
    
        codeword[72]^=getAbit(symbol_value,7);
        codeword[73]^=getAbit(symbol_value,6);
        codeword[74]^=getAbit(symbol_value,5);
        codeword[75]^=getAbit(symbol_value,4);
        codeword[76]^=getAbit(symbol_value,3);
        codeword[77]^=getAbit(symbol_value,2);
        codeword[78]^=getAbit(symbol_value,1);
        codeword[79]^=getAbit(symbol_value,0);
    }


    return;
}

void decoding(unsigned int codeword[RECC_CW_LEN], int *result_type_rs_code, int *error_symbol_position, int *Syndrome)
{
    /*
    //////////////////////////////////////////////

        Fill your code here!!!!

    ///////////////////////////////////////////////
    */

    return;
}

void SDC_check(unsigned int codeword[RECC_CW_LEN], int *result_type_rs_code)
{
    if(*result_type_rs_code == NE || *result_type_rs_code == CE){
        for(int index=0; index<RECC_CW_LEN; index++){
            if(codeword[index]==1){ // If errors still exist
                *result_type_rs_code=SDC;
                return;
            }
        }
    }
    else // DUE
        return;

    return;
}

int main(int argc, char* argv[])
{
    srand((unsigned int) time (NULL));

    // 1. Create a GF(2^8) primitive polynomial table
    // Distinguish by prim_num!!!!!!!!!!
    FILE *fp=fopen("GF_2^8__primitive_polynomial.txt","r");
    int primitive_count=0;
    while(1){
        char str_read[100];
        unsigned int primitive_value=0;
        fgets(str_read,100,fp);
        primitive_value=conversion_to_int_format(str_read, 8);

        generate_primitive_poly(primitive_value,8,primitive_count); // ex : primitive polynomial : a^16 = a^9+a^8+a^7+a^6+a^4+a^3+a^2+1 = 0000 0011 1101 1101 = 0x03DD (O) -> prim_num : 0
        primitive_count++;

        if(feof(fp))
            break;
    }
    fclose(fp);

    // 2. Set up the H_Matrix
    // Configure RECC H-Matrix (GF(2^8) [10,8] Single Symbol Correction Reed-Solomon code)
    // H_Matrix_RECC can be omitted
    /*
        The RECC H-Matrix has the following shape
        primitive polynomial : 𝑥^8+ 𝑥^4+ 𝑥^3+ 𝑥^2+ 1

        1    1   1   1   1   1   1   1  1 0
        a^0 a^1 a^2 a^3 a^4 a^5 a^6 a^7 0 1
    */
    H_Matrix_RECC[0][0]=0,H_Matrix_RECC[0][1]=0,H_Matrix_RECC[0][2]=0,H_Matrix_RECC[0][3]=0,H_Matrix_RECC[0][4]=0,H_Matrix_RECC[0][5]=0,H_Matrix_RECC[0][6]=0,H_Matrix_RECC[0][7]=0,H_Matrix_RECC[0][8]=0,H_Matrix_RECC[0][9]=255;
    H_Matrix_RECC[1][0]=0,H_Matrix_RECC[1][1]=1,H_Matrix_RECC[1][2]=2,H_Matrix_RECC[1][3]=3,H_Matrix_RECC[1][4]=4,H_Matrix_RECC[1][5]=5,H_Matrix_RECC[1][6]=6,H_Matrix_RECC[1][7]=7,H_Matrix_RECC[1][8]=255,H_Matrix_RECC[1][9]=0;

    int runNum=1000000;
    int cnt=0;
    int CE_cnt=0, DUE_cnt=0, SDC_cnt=0;
    while(cnt<runNum){
        unsigned int data[RECC_DATA_LEN]={0,};
        unsigned int codeword[RECC_CW_LEN]={0,};

        // 3. Encoding -> I will skip this when practicing. Freely to take a look at the code
        // 64b data -> 80b codeword (RS-code encoding)
        // input : data
        // output : codeword
        // encoding(data,codeword); -> function call

        int error_symbol_position; // 0~9 (At which symbol did the error occur?)
        int result_type_rs_code; // RS-code result (NE(No-Error), CE(Corrected Error), DUE(Detectable but Uncorrectable Error), SDC(Silent Data Corruption))
                            // Among these, NE and CE have the possibility of being SDC (Silent-Data-Corruption. Error occurred but not detected or mis-corrected)
        int Syndrome=0;

        // 3-1. Error injection
        // All bits of the corresponding symbol have a 50% probability of experiencing a bit-flip
        // If you want to introduce different error types, such as multi-symbol errors, you can modify it here!
        int error_symbol=rand()%10; // 0~9
        for(int index=0; index<SYMBOL_SIZE; index++)
            codeword[error_symbol*SYMBOL_SIZE+index]=(rand()%2==0) ? 1 : 0;


        // 4. Decoding (RS-code Single Symbol Correction)
        // 80b codeword -> 16b Syndrome generation -> Single Symbol Correction (1 chip error correction)
        // input : codeword (Error Injected)
        // output : codeword (Error Corrected), result_type_rs_code, error_symbol_position(0~9)
        // Your to do!

        decoding(codeword, &result_type_rs_code, &error_symbol_position, &Syndrome);

        // 5. SDC check
        // Even though it was determined as NE or CE, it could actually be SDC, so this is verified!
        SDC_check(codeword, &result_type_rs_code);
        

        // Result report
        if(result_type_rs_code==NE || result_type_rs_code==CE)
            CE_cnt++;
        else if(result_type_rs_code==DUE)
            DUE_cnt++;
        else if(result_type_rs_code==SDC)
            SDC_cnt++;

        // Enter the next loop
        cnt++;
    }

    printf("CE_cnt : %d\n",CE_cnt);
    printf("DUE_cnt : %d\n",DUE_cnt);
    printf("SDC_cnt : %d\n",SDC_cnt);

    
    return 0;
}

