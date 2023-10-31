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

// Configuration 
// Modify it if needed

#define CHANNEL_WIDTH 40
#define CHIP_NUM 10
#define DATA_CHIP_NUM 8 // The number of data chips per sub-channel
#define CHIP_WIDTH 4
#define BLHEIGHT 32 // Rank-level ECC (RECC) should check the Burst length (BL32) only, excluding the redundancy of On-die ECC (OECC), while considering the conservative mode conditions

#define OECC_CW_LEN 136 // The codeword length of OECC (On-die ECC) in bits
#define OECC_DATA_LEN 128 // The dataword length of OECC (On-die ECC) in bits
#define OECC_REDUN_LEN 8 // The redundancy length of OECC (On-die ECC) in bits

#define RECC_CW_LEN 80 // The codeword length of RECC (Rank-level ECC) in bits
#define RECC_DATA_LEN 64 // The dataward length of RECC (Rank-level ECC) in bits
#define RECC_REDUN_LEN 16 // The redundancy length of RECC (Rank-level ECC) in bits

#define SYMBOL_SIZE 8 // The symbol size employed by RECC (Rank-level ECC), which is optional and can be configured to 8 if desired, representing GF(2^8)
#define RECC_REDUN_SYMBOL_NUM 2 // The redundancy length of rank-level ECC, measured in symbols, is optional and can be configured as needed
#define RECC_CW_SYMBOL_NUM 10 // The codeword length of rank-level ECC, measured in symbols, is optional and can be configured as needed

#define SE_ERROR_WEIGHT 0.4 // The weight of a Single Error (SE) occurs approximately 40 times out of 100
#define DE_ERROR_WEIGHT 0.3 // The weight of a Double Error (DE) occurs approximately 30 times out of 100
#define CHIPKILL_ERROR_WEIGHT 0.14 // The weight of CHIPKILL (Random error for 1 chip) occurs approximately 14 times out of 100
#define SE_SE_ERROR_WEIGHT 0.16 // The weight of SE_SE 2-chip error (1 bit per-chip) occurs approximately 16 times out of 100

#define RUN_NUM 1000000 // Iteration count

//configuration over

using namespace std;
unsigned int H_Matrix_OECC[OECC_REDUN_LEN][OECC_CW_LEN]; // 8 x 136
unsigned int H_Matrix_RECC[RECC_REDUN_LEN][RECC_CW_LEN]; // 8 x 40

unsigned int primitive_poly[16][256]={0,}; // Each of the 16 primitive polynomials has 256 unique values, with a 0 represented at the end of each row. For example, primitive_poly[4][254] = a^254, and primitive_poly[4][255] = 0 (in the case of prim_num=4, and primitive_poly = x^8+x^6+x^4+x^3+x^2+x^1+1)
enum OECC_TYPE {OECC_OFF=0, OECC_ON=1}; // oecc_type
enum RECC_TYPE {RECC_OFF=0, RECC_ON=1}; // recc_type
enum RESULT_TYPE {NE=0, CE=1, DUE=2, SDC=3}; // result_type

// A function that reads and returns a specific bit from a given integer
unsigned int getAbit(unsigned short x, int n) { 
  return (x & (1 << n)) >> n;
}

// To convert a polynomial form to decimal
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
    if(strstr(str_read,"^1+")!=NULL) // Because a '+1' is always appended next!
        primitive_value+=int(pow(2,1));
    if(strstr(str_read,"+1")!=NULL)
        primitive_value+=int(pow(2,0));
    

    return primitive_value;
}

// Generation of primitive polynomial table 
void generate_primitive_poly(unsigned int prim_value, int m, int prim_num)
{
    unsigned int value = 0x1; // start value (0000 0001)
    int total_count = int(pow(2,m));
    int count=0;
    while (count<total_count-1){ // count : 0~254
        primitive_poly[prim_num][count]=value;
        if(value>=0x80){ // If the m-th digit is 1, perform XOR operation with the primitive polynomial
            // Set the (m+1)-th digit of the value to 0 and then shift
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

// Specify the type of OECC and RECC as strings. This will determine how to proceed differently between OECC and RECC later!
void oecc_recc_type_assignment(string &OECC, string &RECC, int *oecc_type, int*recc_type, int oecc, int recc)
{
    // 1. OECC TYPE (ON/OFF)
    switch (oecc){
        case OECC_OFF:
            OECC.replace(OECC.begin(), OECC.end(),"OECC_OFF");
            *oecc_type=OECC_OFF;
            break;
        case OECC_ON:
            OECC.replace(OECC.begin(), OECC.end(),"OECC_ON");
            *oecc_type=OECC_ON;
            break;
        default:
            break;
    }
    // 2. RECC TYPE (ON/OFF)
    switch (recc){
        case RECC_OFF: 
            RECC.replace(RECC.begin(), RECC.end(),"RECC_OFF");
            *recc_type=RECC_OFF;
            break;
        case RECC_ON:
            RECC.replace(RECC.begin(), RECC.end(),"RECC_ON");
            *recc_type=RECC_ON;
            break;
        default:
            break;
    }
    return;
}

// SE injection (Single Error injection)
void error_injection_SE(int Fault_Chip_position, unsigned int Chip_array[][OECC_CW_LEN])
{
    int Fault_pos = rand()%OECC_CW_LEN; // 0~135

    Chip_array[Fault_Chip_position][Fault_pos]^=1;
    return;
}

// DE injection (Double Error injection)
void error_injection_DE(int Fault_Chip_position, unsigned int Chip_array[][OECC_CW_LEN])
{
    int First_fault_pos = rand()%OECC_CW_LEN; // 0~135;
    int Second_fault_pos;

    while(1){
        Second_fault_pos = rand()%OECC_CW_LEN; // 0~135
        if(First_fault_pos!=Second_fault_pos)
            break;
    }

    Chip_array[Fault_Chip_position][First_fault_pos]^=1;
    Chip_array[Fault_Chip_position][Second_fault_pos]^=1;
    return;
}

// Chipkill injection
void error_injection_CHIPKILL(int Fault_Chip_position, unsigned int Chip_array[][OECC_CW_LEN])
{
    // The 136 bits within a single chip each have a 50% probability of experiencing an error
    for(int Fault_pos=0; Fault_pos<OECC_CW_LEN; Fault_pos++){ // 0~135
        if(rand()%2!=0) // 0(no error) 'or' 1(error)
            Chip_array[Fault_Chip_position][Fault_pos]^=1;
    }
    
    return;
}

// OECC 1bit correction
void error_correction_oecc(unsigned int *codeword)
{
    unsigned int Syndromes[OECC_REDUN_LEN]; // 8 x 1
    
    // Syndromes = H * C^T
    for(int row=0; row<OECC_REDUN_LEN; row++){
        unsigned int row_value=0;
        for(int column=0; column<OECC_CW_LEN; column++)
            row_value=row_value^(H_Matrix_OECC[row][column] * codeword[column]);
        Syndromes[row]=row_value;
    }

    // error correction (Check Syndromes)
    int cnt=0;
    for(int error_pos=0; error_pos<OECC_CW_LEN; error_pos++){
        cnt=0;
        for(int row=0; row<OECC_REDUN_LEN; row++){
            if(Syndromes[row]==H_Matrix_OECC[row][error_pos])
                cnt++;
            else
                break;
        }
        // Error correction is only performed in the case of a 1-bit error
        if(cnt==OECC_REDUN_LEN){
            codeword[error_pos]^=1;
            return;
        }
    }

    // This applies when there is no error or when an error occurs that is not a 1-bit error
    // In this case, correction is not performed
    return;
}

// RECC (80bit codeword, 64bit data, 16bit redundancy)
// Chipkill-correct ECC (using Reed-Solomon code)
int error_correction_recc(unsigned int *codeword)
{
	// RECC can return a maximum of three cases.
	// 1. return NE;
	// 2. return CE;
	// 3. return DUE;
	// Feel free to explore various methods.
	// The following example is for [10, 8] RS-code over GF(2^8).
	// Please refer to the problem statement in "01_Basic/07_RS_code~" for details.

    // Syndrome calculation
    // S0 = (a^exponent0) ^ (a^exponent1) ^ (a^exponent2) ... ^(a^exponent9)
    // S1 = (a^exponent0) ^ (a^[exponent1+1]) ^ (a^[exponent2+2]) ... ^ (a^[exponent9+9])
    // S0 계산
    unsigned int S0=0,S1=0;
    for(int symbol_index=0; symbol_index<RECC_CW_SYMBOL_NUM; symbol_index++){ // 0~9
        unsigned exponent=255; // 255 if 0000_0000 (exception case!)
        unsigned symbol_value=0; // 0000_0000 ~ 1111_1111
        // ex : if the first 8bit in codeword is 0 1 0 1 1 1 0 0,
        // symbol_value = (0<<7) ^ (1<<6) ^ (0<<5) ^ (1<<4) ^ (1<<3) ^ (1<<2) ^ (0<<1) ^ (0<<0) = 0101_1100
        for(int symbol_value_index=0; symbol_value_index<SYMBOL_SIZE; symbol_value_index++){ // 8-bit symbol
            symbol_value^=(codeword[symbol_index*8+symbol_value_index] << (SYMBOL_SIZE-1-symbol_value_index)); // <<7, <<6, ... <<0
        }
        for(int prim_exponent=0; prim_exponent<255; prim_exponent++){
            if(symbol_value==primitive_poly[0][prim_exponent]){
                exponent=prim_exponent;
                break;
            }
        }
        //printf("symbol_index : %d, symbol_value : %d\n",symbol_index, symbol_value);

        if(exponent!=255) // S0 = (a^exponent0) ^ (a^exponent1) ^ (a^exponent2) ... ^(a^exponent9)
            S0^=primitive_poly[0][exponent];
    }


    // S1 calculation
    for(int symbol_index=0; symbol_index<RECC_CW_SYMBOL_NUM; symbol_index++){ // 0~9
        unsigned exponent=255; // 255 if 0000_0000 (exception case!)
        unsigned symbol_value=0; // 0000_0000 ~ 1111_1111
        for(int symbol_value_index=0; symbol_value_index<SYMBOL_SIZE; symbol_value_index++){ // 8-bit symbol
            symbol_value^=(codeword[symbol_index*8+symbol_value_index] << (SYMBOL_SIZE-1-symbol_value_index)); // <<7, <<6, ... <<0
        }
        for(int prim_exponent=0; prim_exponent<255; prim_exponent++){
            if(symbol_value==primitive_poly[0][prim_exponent]){
                exponent=prim_exponent;
                break;
            }
        }
        
        if(exponent!=255) // S1 = (a^exponent0) ^ (a^[exponent1+1]) ^ (a^[exponent2+2]) ... ^ (a^[exponent9+9])
            S1^=primitive_poly[0][(exponent+symbol_index)%255];
    }

    // S0 = a^p, S1= a^q (a^0 ~ a^254)
    unsigned int p,q;
    for(int prim_exponent=0; prim_exponent<255; prim_exponent++){
        if(S0==primitive_poly[0][prim_exponent])
            p=prim_exponent;
        if(S1==primitive_poly[0][prim_exponent])
            q=prim_exponent;
    }
    //printf("S0 : %d(a^%d), S1 : %d(a^%d)\n",S0,p,S1,q);

    //printf("S0 : %d\n",S0);
    if(S0==0 && S1==0){ // NE (No Error)
        return NE;
    }
    
    // CE 'or' DUE
    // error chip position
    int error_symbol_position_recc;
    error_symbol_position_recc=(q+255-p)%255;

    // Table
    if(0<=error_symbol_position_recc && error_symbol_position_recc < CHIP_NUM){ // CE (error chip location : 0~9)
        // printf("CE case! error correction start!\n");
        //error correction
        for(int symbol_index=0; symbol_index<SYMBOL_SIZE; symbol_index++){ // 0~7
            codeword[error_symbol_position_recc*SYMBOL_SIZE+symbol_index]^=getAbit(S0, SYMBOL_SIZE-1-symbol_index); // S0 >> 7, S0 >> 6 ... S0 >> 0
            //Chip_array[error_symbol_position_recc][BL*4+symbol_index]^=getAbit(S0, SYMBOL_SIZE-1-symbol_index); // S0 >> 7, S0 >> 6 ... S0 >> 0
        }
        // printf("CE case! error correction done!\n");     

        return CE;
    }
    // Table End!!!!!
    
    // DUE
    // When the syndrome is not zero, and correction is not performed
    return DUE;
}

int SDC_check(int BL, unsigned int Chip_array[][OECC_CW_LEN], int recc_type)
{
    // Check if errors are still present

    int error_check=0;

    if(recc_type==RECC_ON){
        for(int Error_chip_pos=0; Error_chip_pos<CHIP_NUM; Error_chip_pos++){ // 0~9th chip
            for(int Fault_pos=BL*4; Fault_pos<(BL+2)*4; Fault_pos++){ // Check for remaining errors in the Beat after executing RECC
                if(Chip_array[Error_chip_pos][Fault_pos]==1){
                    error_check++;
                    return error_check;
                }
            }
        }
    }
    else if(recc_type==RECC_OFF){
        for(int Error_chip_pos=0; Error_chip_pos<CHIP_NUM; Error_chip_pos++){ // 0~9 th chip
            for(int Fault_pos=0; Fault_pos<OECC_DATA_LEN; Fault_pos++){ // 0~127b th bit
                if(Chip_array[Error_chip_pos][Fault_pos]==1){
                    error_check++;
                    return error_check;
                }
            }
        }
    }

    return error_check;
}

int main(int argc, char* argv[])
{
    ///////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////
    // newly added!

    // 0. Generate the GF(2^8) primitive polynomial table, distinguished by prim_num!
    FILE *fp=fopen("GF_2^8__primitive_polynomial.txt","r");
    int primitive_count=0;
    while(1){
        char str_read[100];
        unsigned int primitive_value=0;
        fgets(str_read,100,fp);
        primitive_value=conversion_to_int_format(str_read, 8);

        generate_primitive_poly(primitive_value,8,primitive_count); // ex : primitive polynomial : a^16 = a^9+a^8+a^7+a^6+a^4+a^3+a^2+1 = 0000 0011 1101 1101 = 0x03DD (O) -> most right primitive poly: prim_num : 0
        primitive_count++;

        if(feof(fp))
            break;
    }
    fclose(fp);

    ///////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////

    // 1. H_Matrix setting
    // OECC (On-die ECC)
    FILE *fp1=fopen("H_Matrix_OECC.txt","r");
    while(1){
        unsigned int value;
        for(int row=0; row<OECC_REDUN_LEN; row++){
            for(int column=0; column<OECC_CW_LEN; column++){
                fscanf(fp1,"%d ",&value);
                H_Matrix_OECC[row][column]=value;
                //printf("%d ",H_Matrix_binary[row][column]);
            }
        }
        if(feof(fp1))
            break;
    }
    fclose(fp1);

    // RECC (Rank-level ECC)
    // In this answer, we will not be using H-Matrix_RECC.txt
    // Trash Value!!!!!!!
    FILE *fp2=fopen("H_Matrix_RECC.txt","r");
    while(1){
        unsigned int value;
        for(int row=0; row<RECC_REDUN_LEN; row++){
            for(int column=0; column<RECC_CW_LEN; column++){
                fscanf(fp2,"%d ",&value);
                H_Matrix_RECC[row][column]=value;
                //printf("%d ",H_Matrix_binary[row][column]);
            }
        }
        if(feof(fp2))
            break;
    }
    fclose(fp2);

    // 2. Set the output file name and configure OECC/fault(error)/RECC types using the argv parameter in the main function.

    // Example file names:
    // e.g., OECC_ON_RECC_ON_SE -> OECC ON, RECC ON, with errors where 1 chip out of 10 has a 1-bit error (SE [Single Error]), and the remaining 9 chips have no errors (NE [No Error]).
    // e.g., OECC_ON_RECC_ON_SE_SE -> OECC ON, RECC ON, with errors where 2 chips out of 10 each have a 1-bit error (SE [Single Error]), and the remaining 8 chips have no errors (NE [No Error])
	
    string OECC="X", RECC="X"; // => Variables for generating file names. They are not used thereafter
    int oecc_type, recc_type; // => Variables used for categorizing On-die ECC, Rank-level ECC, and fault_type. They continue to be used later on
    oecc_recc_type_assignment(OECC, RECC, &oecc_type, &recc_type, atoi(argv[1]), atoi(argv[2]));
    
    string Result_file_name = OECC + "_" + RECC + ".S";
    FILE *fp3=fopen(Result_file_name.c_str(),"w"); // c_str : Member function in the string class that converts and returns the contained string as a const char* type in C

    // 3. Loop start!
    // DIMM configuration based on the chip arrangement in the channel
    // DDR5: There are 10 chips based on the x4 chip configuration. Each chip has an on-die ECC codeword of 136 bits
	
    unsigned int Chip_array[CHIP_NUM][OECC_CW_LEN]; // Overall chip configuration (BL34 기준. [data : BL32, OECC-redundancy : BL2])
    int CE_cnt=0, DUE_cnt=0, SDC_cnt=0; // CE, DUE, SDC count
    srand((unsigned int)time(NULL)); // Random seed
    double error_scenario;
    for(int runtime=0; runtime<RUN_NUM; runtime++){
        if(runtime%1000000==0){
            fprintf(fp3,"\n===============\n");
            fprintf(fp3,"Runtime : %d/%d\n",runtime,RUN_NUM);
            fprintf(fp3,"CE : %d\n",CE_cnt);
            fprintf(fp3,"DUE : %d\n",DUE_cnt);
            fprintf(fp3,"SDC : %d\n",SDC_cnt);
            fprintf(fp3,"\n===============\n");
	    fflush(fp3);
        }
	// 4-1. Initialize all 136 bits in all 10 chips to 0 (no-error)
	// By doing this, encoding is not necessary when there are no errors, as the syndrome will be 0, taking advantage of the properties of a linear block code.
	    
        for(int i=0; i<CHIP_NUM; i++)
            memset(Chip_array[i], 0, sizeof(unsigned int) * OECC_CW_LEN); 

        // 4-2. Error injection
        // [1] Select two different chips (Fault_Chip_position)
        vector<int> Fault_Chip_position;
        for (;;) {
            Fault_Chip_position.clear();
            Fault_Chip_position.push_back(rand()%CHIP_NUM);
            Fault_Chip_position.push_back(rand()%CHIP_NUM);
            if (Fault_Chip_position[0] != Fault_Chip_position[1]) break;
        }

        // [2] error injection (40% SE, 30% DE, 14% CHIPKILL, 16% SE_SE)
        error_scenario = (double) rand() / RAND_MAX;

        if(error_scenario<SE_ERROR_WEIGHT) // 0.0~0.4
            error_injection_SE(Fault_Chip_position[0],Chip_array);
        else if(error_scenario<SE_ERROR_WEIGHT+DE_ERROR_WEIGHT) // 0~0.7
            error_injection_DE(Fault_Chip_position[0],Chip_array);
        else if(error_scenario<SE_ERROR_WEIGHT+DE_ERROR_WEIGHT+CHIPKILL_ERROR_WEIGHT) // 0.7~0.84
            error_injection_CHIPKILL(Fault_Chip_position[0],Chip_array);
        else{ // 0.84~1.0
            error_injection_SE(Fault_Chip_position[0],Chip_array);
            error_injection_SE(Fault_Chip_position[1],Chip_array);
        }


        // 4-3. OECC
	// SEC: Correction is performed if it corresponds to a 1-bit error syndrome out of the 136. 
	// Correction is not performed in other cases
        switch(oecc_type){
            case OECC_OFF:
                break;
            case OECC_ON:
                for(int Error_chip_pos=0; Error_chip_pos<CHIP_NUM; Error_chip_pos++){ // 0~9
                    unsigned int codeword[OECC_CW_LEN];
                    memcpy(codeword, Chip_array[Error_chip_pos], sizeof(unsigned int)*OECC_CW_LEN); // memory copy
                    error_correction_oecc(codeword); // OECC implimentation
                    memcpy(Chip_array[Error_chip_pos], codeword, sizeof(unsigned int)*OECC_CW_LEN);
                }
                break;
            default:
                break;
        }


        // 4-4. RECC
	// For each Beat (40 bits), execute RECC (Rank-level ECC).
	// RECC returns NE/CE/DUE results.
	// NE (No-Error) => It determines that there are no errors as the syndrome is all zero and does not proceed with error correction.
	// CE (Correctable Error) => The syndrome is not zero, but it is considered correctable, so error correction is performed.
	// DUE (Detectable but Uncorrectable Error) => The syndrome is not zero, but it is considered uncorrectable, so error correction is not performed.

        int result_type_recc; // NE, CE, DUE, SDC flag
        int final_result, final_result_1=CE,final_result_2=CE; // The final results considering two memory transfer blocks, the results of the first memory transfer block, and the results of the second memory transfer block
        int Chip_idx=0;
        switch(recc_type){ 
            case RECC_ON:
                // First memory transfer block
                for(int BL=0; BL<16; BL+=2){ // BL (Burst Length)<16 
                    unsigned int codeword[RECC_CW_LEN];
                    Chip_idx=0;
                    while(Chip_idx<CHIP_NUM){
                        //cout<< "Chip_idx: " << Chip_idx << endl;
                        codeword[Chip_idx*8]=Chip_array[Chip_idx][BL*CHIP_WIDTH];
                        codeword[Chip_idx*8+1]=Chip_array[Chip_idx][BL*CHIP_WIDTH+1];
                        codeword[Chip_idx*8+2]=Chip_array[Chip_idx][BL*CHIP_WIDTH+2];
                        codeword[Chip_idx*8+3]=Chip_array[Chip_idx][BL*CHIP_WIDTH+3];
                        codeword[Chip_idx*8+4]=Chip_array[Chip_idx][BL*CHIP_WIDTH+4];
                        codeword[Chip_idx*8+5]=Chip_array[Chip_idx][BL*CHIP_WIDTH+5];
                        codeword[Chip_idx*8+6]=Chip_array[Chip_idx][BL*CHIP_WIDTH+6];
                        codeword[Chip_idx*8+7]=Chip_array[Chip_idx][BL*CHIP_WIDTH+7];
                        Chip_idx++;
                    }

                    // RECC implimentation
                    result_type_recc = error_correction_recc(codeword); 

                    Chip_idx=0;
                    while(Chip_idx<CHIP_NUM){
                        Chip_array[Chip_idx][BL*CHIP_WIDTH]=codeword[Chip_idx*8];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+1]=codeword[Chip_idx*8+1];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+2]=codeword[Chip_idx*8+2];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+3]=codeword[Chip_idx*8+3];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+4]=codeword[Chip_idx*8+4];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+5]=codeword[Chip_idx*8+5];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+6]=codeword[Chip_idx*8+6];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+7]=codeword[Chip_idx*8+7];
                        Chip_idx++;
                    }

                    // SDC check (SDC if '1' is remain)
                    if(result_type_recc==CE || result_type_recc==NE){
                        int error_check=SDC_check(BL, Chip_array, recc_type);
                        if(error_check){
                            result_type_recc=SDC;
                        }
                    }
                    // DUE check (Restrained mode [SC'23] Unity ECC)
                    if(result_type_recc==DUE || final_result_1==DUE)
                        final_result_1=DUE;
                    else{ // The higher priority value between the two (SDC > CE > NE) can only be assigned if DUE has not occurred previously
                        final_result_1 = (final_result_1>result_type_recc) ? final_result_1 : result_type_recc;
                    }
                }
                // Second memory transfer block
                for(int BL=16; BL<32; BL+=2){ // BL : 16~31
                    unsigned int codeword[RECC_CW_LEN];
                    Chip_idx=0;
                    while(Chip_idx<CHIP_NUM){
                        codeword[Chip_idx*8]=Chip_array[Chip_idx][BL*CHIP_WIDTH];
                        codeword[Chip_idx*8+1]=Chip_array[Chip_idx][BL*CHIP_WIDTH+1];
                        codeword[Chip_idx*8+2]=Chip_array[Chip_idx][BL*CHIP_WIDTH+2];
                        codeword[Chip_idx*8+3]=Chip_array[Chip_idx][BL*CHIP_WIDTH+3];
                        codeword[Chip_idx*8+4]=Chip_array[Chip_idx][BL*CHIP_WIDTH+4];
                        codeword[Chip_idx*8+5]=Chip_array[Chip_idx][BL*CHIP_WIDTH+5];
                        codeword[Chip_idx*8+6]=Chip_array[Chip_idx][BL*CHIP_WIDTH+6];
                        codeword[Chip_idx*8+7]=Chip_array[Chip_idx][BL*CHIP_WIDTH+7];
                        Chip_idx++;
                    }

                    // RECC implimentation
                    result_type_recc = error_correction_recc(codeword); 

                    Chip_idx=0;
                    while(Chip_idx<CHIP_NUM){
                        Chip_array[Chip_idx][BL*CHIP_WIDTH]=codeword[Chip_idx*8];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+1]=codeword[Chip_idx*8+1];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+2]=codeword[Chip_idx*8+2];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+3]=codeword[Chip_idx*8+3];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+4]=codeword[Chip_idx*8+4];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+5]=codeword[Chip_idx*8+5];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+6]=codeword[Chip_idx*8+6];
                        Chip_array[Chip_idx][BL*CHIP_WIDTH+7]=codeword[Chip_idx*8+7];
                        Chip_idx++;
                    }

                    // SDC check (SDC if '1' is remain)
                    if(result_type_recc==CE || result_type_recc==NE){
                        int error_check=SDC_check(BL, Chip_array, recc_type);
                        if(error_check){
                            result_type_recc=SDC;
                        }
                    }
                    // DUE check (Restrained mode [SC'23] Unity ECC)
                    if(result_type_recc==DUE || final_result_2==DUE)
                        final_result_2=DUE;
                    else{ // The higher priority value between the two (SDC > CE > NE) can only be assigned if DUE has not occurred previously
                        final_result_2 = (final_result_2>result_type_recc) ? final_result_2 : result_type_recc;
                    }
                }


		// Compare the results of the two memory transfer blocks and update the final result as follows:
		// SDC: If there is no DUE in both memory transfer blocks and at least one has SDC, the final result is SDC.
		// DUE: If at least one of the two memory transfer blocks has DUE, the final result is DUE.
		// CE: In all other cases, the final result is CE."
		    
                final_result = (final_result_1 > final_result_2) ? final_result_1 : final_result_2;
                break;
            case RECC_OFF:{
                int error_check;
                int BL=0; // trash value
                error_check = SDC_check(BL, Chip_array, recc_type);
                final_result = (error_check>0) ? SDC : CE;
                break;
            }
            default:
                break;
        }

        // 4-5. CE/DUE/SDC check
        // final state update (check two memory transfer blocks)
        // CE, DUE, SDC count
        CE_cnt   += (final_result==CE)  ? 1 : 0;
        DUE_cnt  += (final_result==DUE) ? 1 : 0;
        SDC_cnt  += (final_result==SDC) ? 1 : 0;
            
    }
    // for loop end!!

    // Final update
    fprintf(fp3,"\n===============\n");
    fprintf(fp3,"Runtime : %d\n",RUN_NUM);
    fprintf(fp3,"CE : %d\n",CE_cnt);
    fprintf(fp3,"DUE : %d\n",DUE_cnt);
    fprintf(fp3,"SDC : %d\n",SDC_cnt);
    fprintf(fp3,"\n===============\n");
    fflush(fp3);

    // Final update (Decimal point representation)
    fprintf(fp3,"\n===============\n");
    fprintf(fp3,"Runtime : %d\n",RUN_NUM);
    fprintf(fp3,"CE : %.11f\n",(double)CE_cnt/(double)RUN_NUM);
    fprintf(fp3,"DUE : %.11f\n",(double)DUE_cnt/(double)RUN_NUM);
    fprintf(fp3,"SDC : %.11f\n",(double)SDC_cnt/(double)RUN_NUM);
    fprintf(fp3,"\n===============\n");
    fflush(fp3);

    fclose(fp3);


    return 0;
}
