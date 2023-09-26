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
// Modify if necessary

#define CHANNEL_WIDTH 40
#define CHIP_NUM 10
#define DATA_CHIP_NUM 8 // Number of data chips for each sub-channel
#define CHIP_WIDTH 4
#define BLHEIGHT 32 // Rank-level ECC (RECC) checks only the Burst length, excluding the redundancy of On-die ECC (OECC). Only BL32 is considered. Take into account the conservative mode condition.

#define OECC_CW_LEN 136 // Codeword length of OECC (in bits)
#define OECC_DATA_LEN 128 // Dataword length of OECC (in bits)
#define OECC_REDUN_LEN 8 // Redundancy length of OECC (in bits)

#define RECC_CW_LEN 80 // Codeword length of RECC (in bits)
#define RECC_DATA_LEN 64 // Dataword length of RECC (in bits)
#define RECC_REDUN_LEN 16 // Redundancy length of RECC (in bits)

#define SE_ERROR_WEIGHT 0.4 // The weight of SE (Single Error) => Occurs once every 40 out of 100 times
#define DE_ERROR_WEIGHT 0.3 // The weight of DE (Double Error) => Occurs 30 times out of 100.
#define CHIPKILL_ERROR_WEIGHT 0.14 // The weight of CHIPKILL (Random error for single chip) => Occurs 14 times out of 100
#define SE_SE_ERROR_WEIGHT 0.16 // The weight of SE_SE 2chip error (1bit per-chip) => Occurs 16 times out of 100

#define RUN_NUM 1000000 // iteration count

//configuration over

using namespace std;
unsigned int H_Matrix_OECC[OECC_REDUN_LEN][OECC_CW_LEN]; // 8 x 136
unsigned int H_Matrix_RECC[RECC_REDUN_LEN][RECC_CW_LEN]; // 8 x 40

enum OECC_TYPE {OECC_OFF=0, OECC_ON=1}; // oecc_type
enum RECC_TYPE {RECC_OFF=0, RECC_ON=1}; // recc_type
enum RESULT_TYPE {NE=0, CE=1, DUE=2, SDC=3}; // result_type


// Specify the type of OECC and RECC as strings. Based on this, it will determine how to handle them in 'oecc' and 'recc' later on!!!
void oecc_recc_type_assignment(string &OECC, string &RECC, int *oecc_type, int*recc_type, int oecc, int recc)
{
    // 1. Specify OECC TYPE (ON/OFF)
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
    // 2. Specify RECC TYPE (ON/OFF)
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
    // Each of the 136 bits in a single chip has a 50% probability of experiencing an error.
    for(int Fault_pos=0; Fault_pos<OECC_CW_LEN; Fault_pos++){ // 0~135
        if(rand()%2!=0) // 0(no error) 'or' 1(error)
            Chip_array[Fault_Chip_position][Fault_pos]^=1;
    }
    
    return;
}

// OECC 1bit correction
void error_correction_oecc(unsigned int *codeword)
{
    /*
    ///////////////////////////////////////////////////////

        Fill your code here!!!

    ///////////////////////////////////////////////////////
    */
    return;
}

// RECC (80bit codeword, 64bit data, 16bit redundancy)
int error_correction_recc(unsigned int *codeword)
{
    // There are up to three possible outcomes for RECC
    // 1. return NE;
    // 2. return CE;
    // 3. return DUE;
    // There are various methods available, so please feel free to try them
    // RECC does not need to use H_Matrix_RECC.txt

    /*
    ///////////////////////////////////////////////////////

        Fill your code here!!!

    ///////////////////////////////////////////////////////
    */
    
    // You can remove the 'return 0'
    return 0;
}

int SDC_check(int BL, unsigned int Chip_array[][OECC_CW_LEN], int recc_type)
{
    // Check if there are any remaining errors

    int error_check=0;

    if(recc_type==RECC_ON){
        for(int Error_chip_pos=0; Error_chip_pos<CHIP_NUM; Error_chip_pos++){ // From the 0th to the 9th chip
            for(int Fault_pos=BL*4; Fault_pos<(BL+2)*4; Fault_pos++){ // Check for remaining errors in the Beat where RECC was executed
                if(Chip_array[Error_chip_pos][Fault_pos]==1){
                    error_check++;
                    return error_check;
                }
            }
        }
    }
    else if(recc_type==RECC_OFF){
        for(int Error_chip_pos=0; Error_chip_pos<CHIP_NUM; Error_chip_pos++){ // From the 0th to the 9th chip
            for(int Fault_pos=0; Fault_pos<OECC_DATA_LEN; Fault_pos++){ // From 0-bit to 127-bit
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
    // 1. Set up H_Matrix
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

    // 2. Set the output file name & configure the oecc/recc type.
    // Receive it as the 'argv' parameter of the main function

    // Example of a file name
    // ex : OECC_ON_RECC_ON -> In the case of OECC ON, RECC ON
    string OECC="X", RECC="X"; // => ariables for generating file names. Not used afterward
    int oecc_type, recc_type; // => Variables used for categorizing on-die ECC and Rank-level ECC. Continuously used later on
    oecc_recc_type_assignment(OECC, RECC, &oecc_type, &recc_type, atoi(argv[1]), atoi(argv[2]));
    
    string Result_file_name = OECC + "_" + RECC + ".S";
    FILE *fp3=fopen(Result_file_name.c_str(),"w"); // c_str: A member function of the string class that returns the string it contains as a 'const char*' type in C

    // 3. Loop starts from here
    // Set up DIMM (Based on the chip configuration in the Channel.)
    // DDR5: There are 10 chips based on the x4 chip standard. Each chip has a 136b on-die ECC codeword

    unsigned int Chip_array[CHIP_NUM][OECC_CW_LEN]; // Overall chip configuration (Based on BL34 (Burst Length). [data: BL32, OECC-redundancy: BL2])
    int CE_cnt=0, DUE_cnt=0, SDC_cnt=0; // CE, DUE, SDC counts
    srand((unsigned int)time(NULL)); // Continuously changing the random seed value
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
        // 4. Initialize all 136b of the 10 chips to 0 (no-error)
        // By doing this, encoding is not necessary. If there's no error, the syndrome will come out as 0!
        // Utilizing the properties of linear block codes
        for(int i=0; i<CHIP_NUM; i++)
            memset(Chip_array[i], 0, sizeof(unsigned int) * OECC_CW_LEN); 

        // 5. Error injection
        // 5-1. Select two distinct chips (Fault_Chip_position)
        vector<int> Fault_Chip_position;
        for (;;) {
            Fault_Chip_position.clear();
            Fault_Chip_position.push_back(rand()%CHIP_NUM);
            Fault_Chip_position.push_back(rand()%CHIP_NUM);
            if (Fault_Chip_position[0] != Fault_Chip_position[1]) break;
        }

        // 5-2. Error injection (40% probability for SE, 30% probability for DE, 14% probability for CHIPKILL, 16% probability for SE_SE)
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


        // 6. OD-ECC
        // (136, 128) Hamming SEC code: If it corresponds to 136 1-bit error syndromes, correction is carried out
        // If not, correction is not performed
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


        // 7. RL-ECC
        // Combine 2 Beats (80 bits) to execute RL-ECC (Rank-level ECC)
        // RL-ECC returns NE/CE/DUE results.
        // NE (No-Error) => Since the Syndrome is all zero, it is determined that there is no error and error correction is not performed.
        // CE (Correctable Error) // If the Syndrome is not 0 and is deemed correctable, error correction is carried out.
        // DUE (Detectable but Uncorrectable Error) // If the Syndrome is not 0 and is deemed uncorrectable, error correction is not performed.

        int result_type_recc; // NE, CE, DUE, SDC
        int final_result, final_result_1=CE,final_result_2=CE; // Final results considering each of the two memory transfer blocks, the results of the first memory transfer block, and the results of the second memory transfer block
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

                    // SDC check (If a 1 remains, it's an SDC)
                    if(result_type_recc==CE || result_type_recc==NE){
                        int error_check=SDC_check(BL, Chip_array, recc_type);
                        if(error_check){
                            result_type_recc=SDC;
                        }
                    }
                    // DUE check (Restrained mode [SC'23 Unity ECC])
                    if(result_type_recc==DUE || final_result_1==DUE)
                        final_result_1=DUE;
                    else{ // "The value with the higher priority among the two (SDC > CE > NE). Only if there hasn't been a DUE previously can it be considered
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

                    // SDC check (If a 1 remains, it's an SDC)
                    if(result_type_recc==CE || result_type_recc==NE){
                        int error_check=SDC_check(BL, Chip_array, recc_type);
                        if(error_check){
                            result_type_recc=SDC;
                        }
                    }
                    // DUE check (Restrained mode)
                    if(result_type_recc==DUE || final_result_2==DUE)
                        final_result_2=DUE;
                    else{ // The value with the higher priority among the two (SDC > CE > NE). Only if there hasn't been a DUE previously can it be considered
                        final_result_2 = (final_result_2>result_type_recc) ? final_result_2 : result_type_recc;
                    }
                }

                // Compare the two memory transfer blocks to update the final result
                // SDC: If neither of the two memory transfer blocks has a DUE and at least one has an SDC, the overall result is SDC
                // DUE: If at least one of the two memory transfer blocks has a DUE, the overall result is DUE
                // CE: In all other cases
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

        // 8. Check for CE/DUE/SDC
        // Final update (considering both memory transfer blocks)
        // Count the number of CE, DUE, and SDC occurrences
        CE_cnt   += (final_result==CE)  ? 1 : 0;
        DUE_cnt  += (final_result==DUE) ? 1 : 0;
        SDC_cnt  += (final_result==SDC) ? 1 : 0;
            
    }
    // for-loop end!!

    // 9. Final update
    fprintf(fp3,"\n===============\n");
    fprintf(fp3,"Runtime : %d\n",RUN_NUM);
    fprintf(fp3,"CE : %d\n",CE_cnt);
    fprintf(fp3,"DUE : %d\n",DUE_cnt);
    fprintf(fp3,"SDC : %d\n",SDC_cnt);
    fprintf(fp3,"\n===============\n");
    fflush(fp3);

    // Final update (Decimal representation)
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
