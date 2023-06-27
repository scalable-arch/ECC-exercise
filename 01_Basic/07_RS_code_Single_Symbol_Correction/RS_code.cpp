/*
** 체크해야 할 것
 (1) conservative : BL32 묶음 내에서 error가 다른 chip에서 나오는가 (1-bit error는 내부 OECC에서 고쳐서 나온다.)
   => on/off 가능하도록 만들기 [일단 끄고 하자.]
 (2) 

*/


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
// 필요로 하면 변경하기
#define CHANNEL_WIDTH 40
#define CHIP_NUM 10
#define CHIP_WIDTH 4
#define BLHEIGHT 32 // RECC가 검사해야 하는 Burst length (ondie ecc의 redundancy는 제외하고 BL32만 검사한다. conservative mode 조건 고려하기)
#define SYMBOL_SIZE 8 // RECC에서 시행하는 symbol size (8이면 GF(2^8))

#define OECC_CW_LEN 136 // ondie ecc의 codeword 길이 (bit 단위)
#define OECC_DATA_LEN 128 // ondie ecc의 dataward 길이 (bit 단위)
#define OECC_REDUN_LEN 8 // ondie ecc의 redundancy 길이 (bit 단위)

#define RECC_CW_LEN 80 // rank-level ecc의 codeword 길이 (bit 단위)
#define RECC_DATA_LEN 64 // rank-level ecc의 dataward 길이 (bit 단위)
#define RECC_REDUN_LEN 16 // rank-level ecc의 redundancy 길이 (bit 단위)

#define RECC_REDUN_SYMBOL_NUM 2 // rank-level ecc의 redundancy 길이 (symbol 단위)
#define RECC_CW_SYMBOL_NUM 10 // rank-level ecc의 codeword 길이 (symbol 단위)

//configuration over

using namespace std;
unsigned int primitive_poly[16][256]={0,}; // 16가지 primitive polynomial 각각 256개 unique 한 값들 (각 row의 맨 끝에는 0을 나타낸다.) ex : primitive_poly[4][254] = a^254, primitive_poly[4][255] = 0 (prim_num=4인 경우이고, primitive_poly = x^8+x^6+x^4+x^3+x^2+x^1+1)
vector<unsigned int> SSC_Syndromes; // Keep Syndromes
unsigned int H_Matrix_RECC[RECC_REDUN_SYMBOL_NUM][RECC_CW_SYMBOL_NUM]; // 2 x 10 => Rank-level ECC H-Matrix 
enum RESULT_TYPE {NE=0, CE=1, DUE=2, SDC=3}; // result_type

// 지정한 정수에서, 몇번째 비트만 읽어서 반환하는 함수
unsigned int getAbit(unsigned short x, int n) { 
  return (x & (1 << n)) >> n;
}

// 다항식 형태를 10진수로 변환
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
    if(strstr(str_read,"^1+")!=NULL) // 무조건 다음에 +1은 붙기 때문!
        primitive_value+=int(pow(2,1));
    if(strstr(str_read,"+1")!=NULL)
        primitive_value+=int(pow(2,0));
    

    return primitive_value;
}

// primitive polynomial table 생성
void generate_primitive_poly(unsigned int prim_value, int m, int prim_num)
{
    unsigned int value = 0x1; // start value (0000 0001)
    int total_count = int(pow(2,m));
    int count=0;
    while (count<total_count-1){ // count : 0~254
        primitive_poly[prim_num][count]=value;
        if(value>=0x80){ // m번째 숫자가 1이면 primitive polynomial과 xor 연산
            // value의 m+1번째 숫자를 0으로 바꾸고 shift
            value=value<<(32-m+1);
            value=value>>(32-m);

            //primitive polynomial과 xor 연산
            value=value^prim_value;
        }
        else // m+1번째 숫자가 0이면 왼쪽으로 1칸 shift
            value=value<<1;
        
        count++;
    }

    return;
}

void encoding(unsigned int data[RECC_DATA_LEN], unsigned int codeword[RECC_CW_LEN])
{
    // codeword 설정 (앞 64bit는 data와 똑같다. Systematic-Encoding)
    for(int index=0; index<RECC_DATA_LEN; index++)
        codeword[index]=data[index];
    for(int index=RECC_DATA_LEN; index<RECC_CW_LEN; index++)
        codeword[index]=0;

    // 65~72번째 bit 계산
    for(int index=0; index<RECC_DATA_LEN; index++){
        codeword[RECC_DATA_LEN+index%SYMBOL_SIZE]^=data[index];
    }

    // 73~80번째 bit 계산
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
            if(codeword[index]==1){ // 아직 error가 남아 있는 경우
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

    // 1. GF(2^8) primitive polynomial table 생성
    // prim_num으로 구분한다!!!!!!!!!!!!!!!!!
    FILE *fp=fopen("GF_2^8__primitive_polynomial.txt","r");
    int primitive_count=0;
    while(1){
        char str_read[100];
        unsigned int primitive_value=0;
        fgets(str_read,100,fp);
        primitive_value=conversion_to_int_format(str_read, 8);

        generate_primitive_poly(primitive_value,8,primitive_count); // ex : primitive polynomial : a^16 = a^9+a^8+a^7+a^6+a^4+a^3+a^2+1 = 0000 0011 1101 1101 = 0x03DD (O) -> 맨 오른쪽 prim_num : 0
        primitive_count++;

        if(feof(fp))
            break;
    }
    fclose(fp);

    // 2. H_Matrix 설정
    // RECC H-Matrix 설정 (GF(2^8) [10,8] Single Symbol Correction Reed-Solomon code)
    /*
        RECC H-Matrix는 아래와 같은 모양이다.
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

        // 3. Encoding -> 연습할때는 생략하겠습니다. 코드는 구경해보세요
        // 64b data -> 80b codeword (RS-code encoding)
        // input : data
        // output : codeword
        // encoding(data,codeword); -> function call

        int error_symbol_position; // 0~9 (몇번째 symbol에서 error가 발생했는가)
        int result_type_rs_code; // RS-code의 결과 (NE(No-Error), CE(Corrected Error), DUE(Detectable but Uncorrectable Error), SDC(Silent Data Corruption))
                            // 이 중 NE, CE는 SDC일 가능성 있다. (Silent-Data-Corruption. Error가 발생했지만, detection 하지 못하거나 mis-correction 하는 경우)
        int Syndrome=0;

        // 3-1. Error injection
        // 해당 symbol의 모든 bit는 50% 확률로 bit-flip 발생
        // multi-symbol error 등, 다른 error type을 넣고 싶으면 여기를 바꾸면 됩니다!!!!!
        int error_symbol=rand()%10; // 0~9
        for(int index=0; index<SYMBOL_SIZE; index++)
            codeword[error_symbol*SYMBOL_SIZE+index]=(rand()%2==0) ? 1 : 0;


        // 4. Decoding (RS-code Single Symbol Correction)
        // 80b codeword -> 16b Syndrome 생성 -> Single Symbol Correction (1 chip error correction)
        // input : codeword (Error Injected)
        // output : codeword (Error Corrected), result_type_rs_code, error_symbol_position(0~9)
        // 해당 함수롤 짜야 합니다.

        decoding(codeword, &result_type_rs_code, &error_symbol_position, &Syndrome);

        // 5. SDC check
        // NE 또는 CE이라고 판단헀지만, 실제로는 SDC일수도 있으니 이것을 확인한다!
        SDC_check(codeword, &result_type_rs_code);
        

        // 결과 report
        if(result_type_rs_code==NE || result_type_rs_code==CE)
            CE_cnt++;
        else if(result_type_rs_code==DUE)
            DUE_cnt++;
        else if(result_type_rs_code==SDC)
            SDC_cnt++;

        // 다음 루프로 진입
        cnt++;
    }

    printf("CE_cnt : %d\n",CE_cnt);
    printf("DUE_cnt : %d\n",DUE_cnt);
    printf("SDC_cnt : %d\n",SDC_cnt);

    
    return 0;
}

