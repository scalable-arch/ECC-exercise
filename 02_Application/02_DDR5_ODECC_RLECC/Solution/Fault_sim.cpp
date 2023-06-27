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
// 필요로 하면 변경하기

#define CHANNEL_WIDTH 40
#define CHIP_NUM 10
#define DATA_CHIP_NUM 8 // sub-channel마다 data chip 개수
#define CHIP_WIDTH 4
#define BLHEIGHT 32 // Rank-level ECC (RECC)가 검사해야 하는 Burst length (On-die ECC (OECC)의 redundancy는 제외하고 BL32만 검사한다. conservative mode 조건 고려하기)

#define OECC_CW_LEN 136 // OECC의 codeword 길이 (bit 단위)
#define OECC_DATA_LEN 128 // OECC의 dataward 길이 (bit 단위)
#define OECC_REDUN_LEN 8 // OECC의 redundancy 길이 (bit 단위)

#define RECC_CW_LEN 80 // RECC의 codeword 길이 (bit 단위)
#define RECC_DATA_LEN 64 // RECC의 dataward 길이 (bit 단위)
#define RECC_REDUN_LEN 16 // RECC의 redundancy 길이 (bit 단위)

#define SYMBOL_SIZE 8 // RECC에서 시행하는 symbol size (8이면 GF(2^8)) -> optional use
#define RECC_REDUN_SYMBOL_NUM 2 // rank-level ecc의 redundancy 길이 (symbol 단위) -> optional use
#define RECC_CW_SYMBOL_NUM 10 // rank-level ecc의 codeword 길이 (symbol 단위) -> optional use

#define SE_ERROR_WEIGHT 0.4 // SE (Single Error)의 weight => 100번중 40번 꼴로 발생
#define DE_ERROR_WEIGHT 0.3 // DE (Double Error)의 weight => 100번중 30번 꼴로 발생
#define CHIPKILL_ERROR_WEIGHT 0.14 // CHIPKILL (Random error for 1 chip)의 weight => 100번중 14번 꼴로 발생
#define SE_SE_ERROR_WEIGHT 0.16 // SE_SE 2chip error (1bit per-chip) 의 weight => 100번중 16번 꼴로 발생

#define RUN_NUM 100000 // 실행 횟수

//configuration over

using namespace std;
unsigned int H_Matrix_OECC[OECC_REDUN_LEN][OECC_CW_LEN]; // 8 x 136
unsigned int H_Matrix_RECC[RECC_REDUN_LEN][RECC_CW_LEN]; // 8 x 40

unsigned int primitive_poly[16][256]={0,}; // 16가지 primitive polynomial 각각 256개 unique 한 값들 (각 row의 맨 끝에는 0을 나타낸다.) ex : primitive_poly[4][254] = a^254, primitive_poly[4][255] = 0 (prim_num=4인 경우이고, primitive_poly = x^8+x^6+x^4+x^3+x^2+x^1+1)
enum OECC_TYPE {OECC_OFF=0, OECC_ON=1}; // oecc_type
enum RECC_TYPE {RECC_OFF=0, RECC_ON=1}; // recc_type
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

// OECC, RECC 각각의 type을 string으로 지정. 이것을 기준으로 뒤에서 oecc, recc에서 어떻게 할지 바뀐다!!!
void oecc_recc_type_assignment(string &OECC, string &RECC, int *oecc_type, int*recc_type, int oecc, int recc)
{
    // 1. OECC TYPE 지정 (ON/OFF)
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
    // 2. RECC TYPE 지정 (ON/OFF)
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
    // 1개 chip에 있는 136 bit는 각각 50% 확률로 error가 발생한다.
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
        // 1-bit error 일때만 error correction 진행
        if(cnt==OECC_REDUN_LEN){
            codeword[error_pos]^=1;
            return;
        }
    }

    // Error가 발생하지 않았거나, 발생했지만 1-bit error는 아닌 경우이다.
    // 이 경우에는 correction을 진행하지 않는다.
    return;
}

// RECC (80bit codeword, 64bit data, 16bit redundancy)
int error_correction_recc(unsigned int *codeword)
{
    // RECC의 return은 최대 3가지 경우가 있다.
    // 1. return NE;
    // 2. return CE;
    // 3. return DUE;
    // 다양한 방법이 있으니 자유롭게 시도해보시기 바랍니다.
    // 아래 예시는 [10, 8] RS-code over GF(2^8) 예시입니다.
    // rs code: 01_Basic/07_RS_code~ 문제를 참조하시기 바랍니다.

    // Syndrome 계산
    // S0 = (a^exponent0) ^ (a^exponent1) ^ (a^exponent2) ... ^(a^exponent9)
    // S1 = (a^exponent0) ^ (a^[exponent1+1]) ^ (a^[exponent2+2]) ... ^ (a^[exponent9+9])
    // S0 계산
    unsigned int S0=0,S1=0;
    for(int symbol_index=0; symbol_index<RECC_CW_SYMBOL_NUM; symbol_index++){ // 0~9
        unsigned exponent=255; // 0000_0000이면 255 (해당 사항만 예외케이스!)
        unsigned symbol_value=0; // 0000_0000 ~ 1111_1111
        // ex : codeword의 첫 8개 bit가 0 1 0 1 1 1 0 0 이면
        // symbol_value는 (0<<7) ^ (1<<6) ^ (0<<5) ^ (1<<4) ^ (1<<3) ^ (1<<2) ^ (0<<1) ^ (0<<0) = 0101_1100 이다.
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


    // S1 계산
    for(int symbol_index=0; symbol_index<RECC_CW_SYMBOL_NUM; symbol_index++){ // 0~9
        unsigned exponent=255; // 0000_0000이면 255 (해당 사항만 예외케이스!)
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
    // 신드롬이 0이 아니고, correction 진행 안한 경우
    return DUE;
}

int SDC_check(int BL, unsigned int Chip_array[][OECC_CW_LEN], int recc_type)
{
    // Error가 남아있는지 검사

    int error_check=0;

    if(recc_type==RECC_ON){
        for(int Error_chip_pos=0; Error_chip_pos<CHIP_NUM; Error_chip_pos++){ // 0~9번쨰 chip까지
            for(int Fault_pos=BL*4; Fault_pos<(BL+2)*4; Fault_pos++){ // RECC를 실행한 Beat에서 error가 남아있는지 검사
                if(Chip_array[Error_chip_pos][Fault_pos]==1){
                    error_check++;
                    return error_check;
                }
            }
        }
    }
    else if(recc_type==RECC_OFF){
        for(int Error_chip_pos=0; Error_chip_pos<CHIP_NUM; Error_chip_pos++){ // 0~9번쨰 chip까지
            for(int Fault_pos=0; Fault_pos<OECC_DATA_LEN; Fault_pos++){ // 0~127b 까지
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
    // 새롭게 추가한 부분

    // 0. GF(2^8) primitive polynomial table 생성
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

    ///////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////

    // 1. H_Matrix 설정
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
    // 해당 정답에서는 H-Matrix_RECC 코드를 사용하지 않을 것입니다.
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

    // 2. 출력 파일 이름 설정 & oecc/fault(error)/recc type 설정. 
    // main 함수의 argv parameter로 받는다.

    // 파일명 예시
    // ex : OECC_ON_RECC_ON_SE -> OECC ON, RECC ON, ERROR는 10chip중에서 1개 chip에만 1bit error (SE[Single Error]) 가 발생하고 나머지 9개 chip에는 error가 발생하지 않는(NE[No Error]) 경우
    // ex : OECC_ON_RECC_ON_SE_SE -> OECC ON, RECC ON, ERROR는 10chip중에서 2개 chip에 각각 1bit error (SE[Single Error]) 가 발생하고 나머지 8개 chip에는 error가 발생하지 않는(NE[No Error]) 경우
    string OECC="X", RECC="X"; // => 파일 이름 생성을 위한 변수들. 그 이후로는 안쓰인다.
    int oecc_type, recc_type; // => on-die ECC, Rank-level ECC, fault_type 분류를 위해 쓰이는 변수. 뒤에서도 계속 사용된다.
    oecc_recc_type_assignment(OECC, RECC, &oecc_type, &recc_type, atoi(argv[1]), atoi(argv[2]));
    
    string Result_file_name = OECC + "_" + RECC + ".S";
    FILE *fp3=fopen(Result_file_name.c_str(),"w"); // c_str : string class에서 담고 있는 문자열을 c에서의 const char* 타입으로 변환하여 반환해주는 멤버함수

    // 3. 여기서부터 반복문 시작
    // DIMM 설정 (Channel에 있는 chip 구성을 기본으로 한다.)
    // DDR5 : x4 chip 기준으로 10개 chip이 있다. 각 chip은 on-die ECC codeword 136b이 있다.

    unsigned int Chip_array[CHIP_NUM][OECC_CW_LEN]; // 전체 chip 구성 (BL34 기준. [data : BL32, OECC-redundancy : BL2])
    int CE_cnt=0, DUE_cnt=0, SDC_cnt=0; // CE, DUE, SDC 횟수
    srand((unsigned int)time(NULL)); // 난수 시드값 계속 변화
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
        // 4-1. 10개 chip의 136b 전부를 0으로 초기화 (no-error)
        // 이렇게 하면 굳이 encoding을 안해도 된다. no-error라면 syndrome이 0으로 나오기 때문!
        // Linear block code의 특성 활용
        for(int i=0; i<CHIP_NUM; i++)
            memset(Chip_array[i], 0, sizeof(unsigned int) * OECC_CW_LEN); 

        // 4-2. Error injection
        // [1] 서로 다른 2개의 chip을 선택 (Fault_Chip_position)
        vector<int> Fault_Chip_position;
        for (;;) {
            Fault_Chip_position.clear();
            Fault_Chip_position.push_back(rand()%CHIP_NUM);
            Fault_Chip_position.push_back(rand()%CHIP_NUM);
            if (Fault_Chip_position[0] != Fault_Chip_position[1]) break;
        }

        // [2] error injection (40% 확률 SE, 30% 확률 DE, 14% 확률 CHIPKILL, 16% 확률 SE_SE)
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
        // SEC : 136개의 1-bit error syndrome에 대응하면 correction 진행.
        // 아닌 경우에는 correction을 진행하지 않는다.
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
        // 각 Beat (40 bit) 마다 RECC (Rank-level ECC) 실행
        // RECC는 NE/CE/DUE 결과를 return 한다.
        // NE (No-Error) => Syndrome이 all zero이기에 error가 없다고 판별하여 error correction을 진행하지 않는다.
        // CE (Correctable Error) // Syndrome이 0이 아니고, Correctable 하다고 판단하여 error correction을 진행한다.
        // DUE (Detectable but Uncorrectable Error) // Syndrome이 0이 아니고, Correctable 하지 않다고 판단하여 error correction을 진행하지 않는다.

        int result_type_recc; // NE, CE, DUE, SDC 저장
        int final_result, final_result_1=CE,final_result_2=CE; // 각각 2개 memory transfer block 고려한 최종 결과, 첫번째 memory transfer block, 두번째 memory transfer block 검사 결과
        int Chip_idx=0;
        switch(recc_type){ 
            case RECC_ON:
                // 첫번째 memory transfer block
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

                    // SDC 검사 (1이 남아있으면 SDC)
                    if(result_type_recc==CE || result_type_recc==NE){
                        int error_check=SDC_check(BL, Chip_array, recc_type);
                        if(error_check){
                            result_type_recc=SDC;
                        }
                    }
                    // DUE 검사 (Restrained mode)
                    if(result_type_recc==DUE || final_result_1==DUE)
                        final_result_1=DUE;
                    else{ // 둘 중 우선순위가 큰 값 (SDC > CE > NE), 이전에 DUE가 나온 적이 없는 경우에만 들어갈 수 있다.
                        final_result_1 = (final_result_1>result_type_recc) ? final_result_1 : result_type_recc;
                    }
                }
                // 두번째 memory transfer block
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

                    // SDC 검사 (1이 남아있으면 SDC)
                    if(result_type_recc==CE || result_type_recc==NE){
                        int error_check=SDC_check(BL, Chip_array, recc_type);
                        if(error_check){
                            result_type_recc=SDC;
                        }
                    }
                    // DUE 검사 (Restrained mode)
                    if(result_type_recc==DUE || final_result_2==DUE)
                        final_result_2=DUE;
                    else{ // 둘 중 우선순위가 큰 값 (SDC > CE > NE), 이전에 DUE가 나온 적이 없는 경우에만 들어갈 수 있다.
                        final_result_2 = (final_result_2>result_type_recc) ? final_result_2 : result_type_recc;
                    }
                }

                // 2개 memory transfer block 비교해서 최종결과 update
                // SDC : 2개 memory transfer block 중에서 DUE 없고, 1개라도 SDC가 있으면 전체는 SDC
                // DUE : 2개 memory transfer block 중에서 1개라도 DUE가 있으면 전체는 DUE
                // CE : 그 외 경우
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

        // 4-5. CE/DUE/SDC 체크
        // 최종 update (2개 memory transfer block 전부 고려)
        // CE, DUE, SDC 개수 세기
        CE_cnt   += (final_result==CE)  ? 1 : 0;
        DUE_cnt  += (final_result==DUE) ? 1 : 0;
        SDC_cnt  += (final_result==SDC) ? 1 : 0;
            
    }
    // for문 끝!!

    // 최종 update
    fprintf(fp3,"\n===============\n");
    fprintf(fp3,"Runtime : %d\n",RUN_NUM);
    fprintf(fp3,"CE : %d\n",CE_cnt);
    fprintf(fp3,"DUE : %d\n",DUE_cnt);
    fprintf(fp3,"SDC : %d\n",SDC_cnt);
    fprintf(fp3,"\n===============\n");
    fflush(fp3);

    // 최종 update (소숫점 표현)
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