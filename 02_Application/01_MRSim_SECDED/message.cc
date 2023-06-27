/**
 * @file: message.cc
 * @author: Jungrae Kim <dale40@gmail.com>
 * message implementation 
 */

#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <random>

#include "message.hh"

//----------------------------------------------------------
//
//----------------------------------------------------------
Block::Block(int bitSize) {
    bitN = bitSize;

    bitArr = new bool[bitN];
    reset();
}

Block::~Block() {
    delete[] bitArr;
}

//----------------------------------------------------------
void Block::reset() {
    memset(bitArr, 0, sizeof(bool)*bitN);
}

//----------------------------------------------------------
bool Block::isZero() {
    for (int i=0; i<bitN; i++) {
        if (bitArr[i]) return false;
    }
    return true;
}

//----------------------------------------------------------
void Block::clone(Block* src) {
    assert(bitN==src->bitN);
    memcpy(bitArr, src->bitArr, sizeof(bool)*bitN);
}

//----------------------------------------------------------
bool Block::equal(Block* ref) {
    if (bitN!=ref->bitN) {
        return false;
    }
    for (int i=0; i<bitN; i++) {
        if (bitArr[i]!=ref->bitArr[i]) {
            return false;
        }
    }
    return true;
}

//----------------------------------------------------------
int Block::getSymbol(int size, int pos) {
    int result = 0;
    for (int i=size-1; i>=0; i--) {
        result = (result<<1) | bitArr[i+pos*size];
    }
    return result;
}

//----------------------------------------------------------
void Block::setSymbol(int size, int pos, int value) {
    for (int i=size-1; i>=0; i--) {
        bitArr[i+pos*size] = (value>>i) & 1;
    }
}

//----------------------------------------------------------
void Block::invSymbol(int size, int pos, int value) {
    for (int i=size-1; i>=0; i--) {
        bitArr[i+pos*size] ^= (value>>i) & 1;
    }
}

//----------------------------------------------------------
void Block::print(FILE *fd) const {
    int buffer = 0;
    for (int i=bitN-1; i>=0; i--) {
        buffer = (buffer<<1) | bitArr[i];
        if (i%4==0) {
            fprintf(fd, "%01X", buffer);
            buffer = 0;
            fprintf(fd, "_");
        }
    }
    fprintf(fd, " (%03d)\n", bitN);
}

//----------------------------------------------------------
//
//----------------------------------------------------------
void ECCWord::extract(Block* data, ECCLayout layout, int pos, int channelWidth) {
    if (layout==LINEAR) {
        memcpy(bitArr, &(data->bitArr[channelWidth*pos]), sizeof(bool)*channelWidth);
    } else if (layout==PIN) {
        // original layout (bits)
        // 0  1  2  3  4  5  6  7  - 8  9  10 11 12 13 14 15 - ... - 64 65 66 67 68 69 70 71
        // 72 73 74 75 76 77 78 79 - 80 81 82 83 84 85 86 87 - ... - 
        for (int i=0; i<channelWidth; i++) {
            bitArr[i*8+0] = data->bitArr[channelWidth*0+i];
            bitArr[i*8+1] = data->bitArr[channelWidth*1+i];
            bitArr[i*8+2] = data->bitArr[channelWidth*2+i];
            bitArr[i*8+3] = data->bitArr[channelWidth*3+i];
            bitArr[i*8+4] = data->bitArr[channelWidth*4+i];
            bitArr[i*8+5] = data->bitArr[channelWidth*5+i];
            bitArr[i*8+6] = data->bitArr[channelWidth*6+i];
            bitArr[i*8+7] = data->bitArr[channelWidth*7+i];
        }
    } else if (layout==PIN9) {
        for (int i=0; i<channelWidth; i++) {
            bitArr[i*9+0] = data->bitArr[channelWidth*0+i];
            bitArr[i*9+1] = data->bitArr[channelWidth*1+i];
            bitArr[i*9+2] = data->bitArr[channelWidth*2+i];
            bitArr[i*9+3] = data->bitArr[channelWidth*3+i];
            bitArr[i*9+4] = data->bitArr[channelWidth*4+i];
            bitArr[i*9+5] = data->bitArr[channelWidth*5+i];
            bitArr[i*9+6] = data->bitArr[channelWidth*6+i];
            bitArr[i*9+7] = data->bitArr[channelWidth*7+i];
            bitArr[i*9+8] = data->bitArr[channelWidth*8+i];
            //printf("%x %d %d %d %d %d %d %d %d %d (%d)\n", getSymbol(9, i),
            //                data->bitArr[channelWidth*0+i],
            //                data->bitArr[channelWidth*1+i],
            //                data->bitArr[channelWidth*2+i],
            //                data->bitArr[channelWidth*3+i],
            //                data->bitArr[channelWidth*4+i],
            //                data->bitArr[channelWidth*5+i],
            //                data->bitArr[channelWidth*6+i],
            //                data->bitArr[channelWidth*7+i],
            //                data->bitArr[channelWidth*8+i],
            //                channelWidth);
        }
    } else if (layout==PIN17) {
		// assuming burst length is 17	
		int BurstLength = 17;
		int symSize = 8;
		int chipWidth = 4;
		bool tmpArr[BurstLength*channelWidth];
		for(int i=0; i< channelWidth/chipWidth; i++){
			for(int j=0; j< BurstLength; j++){
				bitArr[(BurstLength*i + j)*chipWidth + 0] = data->bitArr[channelWidth * j + chipWidth * i + 0];		
				bitArr[(BurstLength*i + j)*chipWidth + 1] = data->bitArr[channelWidth * j + chipWidth * i + 1];		
				bitArr[(BurstLength*i + j)*chipWidth + 2] = data->bitArr[channelWidth * j + chipWidth * i + 2];		
				bitArr[(BurstLength*i + j)*chipWidth + 3] = data->bitArr[channelWidth * j + chipWidth * i + 3];		
			}
		}
		//for(int a=0; a< channelWidth*BurstLength/symSize; a++){

		//	bitArr[a * symSize + 0] = tmpArr[2*a * chipWidth + 0]; 
		//	bitArr[a * symSize + 1] = tmpArr[2*a * chipWidth + 1]; 
		//	bitArr[a * symSize + 2] = tmpArr[2*a * chipWidth + 2]; 
		//	bitArr[a * symSize + 3] = tmpArr[2*a * chipWidth + 3]; 
		//	bitArr[a * symSize + 4] = tmpArr[(2*a+1) * chipWidth + 0]; 
		//	bitArr[a * symSize + 5] = tmpArr[(2*a+1) * chipWidth + 1]; 
		//	bitArr[a * symSize + 6] = tmpArr[(2*a+1) * chipWidth + 2]; 
		//	bitArr[a * symSize + 7] = tmpArr[(2*a+1) * chipWidth + 3]; 
		//}
		/*

        for (int i=0; i<channelWidth; i++) {
					for(int j=0; j< BurstLength; j++){
						int n = (BurstLength*i) + j;
						int a = n / symSize;
						int b = n % symSize;
						bitArr[a * symSize + b] = data->bitArr[channelWidth* j + i]; 
					}
        }
		*/
    } else if (layout==DPIN) {
        // original layout (2-bits)
        // 0  1  2  3  - 4  5  6  7  - ... - 32 33 34 35
        // 36 37 38 39 - 40 41 42 43 - ... - 68 69 70 71
        for (int i=0; i<channelWidth/2; i++) {
            bitArr[i*8+0] = data->bitArr[channelWidth*0+i*2+0];
            bitArr[i*8+1] = data->bitArr[channelWidth*0+i*2+1];
            bitArr[i*8+2] = data->bitArr[channelWidth*1+i*2+0];
            bitArr[i*8+3] = data->bitArr[channelWidth*1+i*2+1];
            bitArr[i*8+4] = data->bitArr[channelWidth*2+i*2+0];
            bitArr[i*8+5] = data->bitArr[channelWidth*2+i*2+1];
            bitArr[i*8+6] = data->bitArr[channelWidth*3+i*2+0];
            bitArr[i*8+7] = data->bitArr[channelWidth*3+i*2+1];
        }
    } else if (layout==AMD) {
        for (int i=0; i<channelWidth/4; i++) {
            bitArr[i*8+0] = data->bitArr[channelWidth*(pos*2+0)+i*4+0];
            bitArr[i*8+1] = data->bitArr[channelWidth*(pos*2+0)+i*4+1];
            bitArr[i*8+2] = data->bitArr[channelWidth*(pos*2+0)+i*4+2];
            bitArr[i*8+3] = data->bitArr[channelWidth*(pos*2+0)+i*4+3];
            bitArr[i*8+4] = data->bitArr[channelWidth*(pos*2+1)+i*4+0];
            bitArr[i*8+5] = data->bitArr[channelWidth*(pos*2+1)+i*4+1];
            bitArr[i*8+6] = data->bitArr[channelWidth*(pos*2+1)+i*4+2];
            bitArr[i*8+7] = data->bitArr[channelWidth*(pos*2+1)+i*4+3];
        }
    } else if (layout==MULTIX8) {
        for (int i=0; i<channelWidth/8; i++) {
            bitArr[i*16+0] = data->bitArr[channelWidth*(pos*2+0)+i*8+0];
            bitArr[i*16+1] = data->bitArr[channelWidth*(pos*2+0)+i*8+1];
            bitArr[i*16+2] = data->bitArr[channelWidth*(pos*2+0)+i*8+2];
            bitArr[i*16+3] = data->bitArr[channelWidth*(pos*2+0)+i*8+3];
            bitArr[i*16+4] = data->bitArr[channelWidth*(pos*2+0)+i*8+4];
            bitArr[i*16+5] = data->bitArr[channelWidth*(pos*2+0)+i*8+5];
            bitArr[i*16+6] = data->bitArr[channelWidth*(pos*2+0)+i*8+6];
            bitArr[i*16+7] = data->bitArr[channelWidth*(pos*2+0)+i*8+7];
            bitArr[i*16+8] = data->bitArr[channelWidth*(pos*2+1)+i*8+0];
            bitArr[i*16+9] = data->bitArr[channelWidth*(pos*2+1)+i*8+1];
            bitArr[i*16+10]= data->bitArr[channelWidth*(pos*2+1)+i*8+2];
            bitArr[i*16+11]= data->bitArr[channelWidth*(pos*2+1)+i*8+3];
            bitArr[i*16+12]= data->bitArr[channelWidth*(pos*2+1)+i*8+4];
            bitArr[i*16+13]= data->bitArr[channelWidth*(pos*2+1)+i*8+5];
            bitArr[i*16+14]= data->bitArr[channelWidth*(pos*2+1)+i*8+6];
            bitArr[i*16+15]= data->bitArr[channelWidth*(pos*2+1)+i*8+7];
        }
    } else if (layout==MULTIX4) {
        for (int i=0; i<channelWidth/4; i++) {
            bitArr[i*16+0] = data->bitArr[channelWidth*(pos*4+0)+i*4+0];
            bitArr[i*16+1] = data->bitArr[channelWidth*(pos*4+0)+i*4+1];
            bitArr[i*16+2] = data->bitArr[channelWidth*(pos*4+0)+i*4+2];
            bitArr[i*16+3] = data->bitArr[channelWidth*(pos*4+0)+i*4+3];
            bitArr[i*16+4] = data->bitArr[channelWidth*(pos*4+1)+i*4+0];
            bitArr[i*16+5] = data->bitArr[channelWidth*(pos*4+1)+i*4+1];
            bitArr[i*16+6] = data->bitArr[channelWidth*(pos*4+1)+i*4+2];
            bitArr[i*16+7] = data->bitArr[channelWidth*(pos*4+1)+i*4+3];
            bitArr[i*16+8] = data->bitArr[channelWidth*(pos*4+2)+i*4+0];
            bitArr[i*16+9] = data->bitArr[channelWidth*(pos*4+2)+i*4+1];
            bitArr[i*16+10]= data->bitArr[channelWidth*(pos*4+2)+i*4+2];
            bitArr[i*16+11]= data->bitArr[channelWidth*(pos*4+2)+i*4+3];
            bitArr[i*16+12]= data->bitArr[channelWidth*(pos*4+3)+i*4+0];
            bitArr[i*16+13]= data->bitArr[channelWidth*(pos*4+3)+i*4+1];
            bitArr[i*16+14]= data->bitArr[channelWidth*(pos*4+3)+i*4+2];
            bitArr[i*16+15]= data->bitArr[channelWidth*(pos*4+3)+i*4+3];
        }
    } else if (layout==ONCHIPx4) {
        for (int i=0; i<18; i++) {   // height
            bitArr[i*4+0] = data->bitArr[channelWidth*i+pos*4+0];
            bitArr[i*4+1] = data->bitArr[channelWidth*i+pos*4+1];
            bitArr[i*4+2] = data->bitArr[channelWidth*i+pos*4+2];
            bitArr[i*4+3] = data->bitArr[channelWidth*i+pos*4+3];
        }
    } else if (layout==ONCHIPx4_2) {
        for (int i=0; i<18; i++) {   // height
            bitArr[i*4+0] = data->bitArr[channelWidth*i+pos*4+0];
            bitArr[i*4+1] = data->bitArr[channelWidth*i+pos*4+1];
            bitArr[i*4+2] = data->bitArr[channelWidth*i+pos*4+2];
            bitArr[i*4+3] = data->bitArr[channelWidth*i+pos*4+3];
        }
        /*
        for (int i=0; i<9; i++) {
            bitArr[i*8+0] = data->bitArr[channelWidth*0+pos*9+i];
            bitArr[i*8+1] = data->bitArr[channelWidth*1+pos*9+i];
            bitArr[i*8+2] = data->bitArr[channelWidth*2+pos*9+i];
            bitArr[i*8+3] = data->bitArr[channelWidth*3+pos*9+i];
            bitArr[i*8+4] = data->bitArr[channelWidth*4+pos*9+i];
            bitArr[i*8+5] = data->bitArr[channelWidth*5+pos*9+i];
            bitArr[i*8+6] = data->bitArr[channelWidth*6+pos*9+i];
            bitArr[i*8+7] = data->bitArr[channelWidth*7+pos*9+i];
        }
        */
        //for (int i=0; i<9; i++) {   // height
        //    bitArr[i*8+0] = data->bitArr[channelWidth*(i+0)+pos*4];
        //    bitArr[i*8+1] = data->bitArr[channelWidth*(i+1)+pos*4];
        //    bitArr[i*8+2] = data->bitArr[channelWidth*(i+2)+pos*4];
        //    bitArr[i*8+3] = data->bitArr[channelWidth*(i+3)+pos*4];
        //    bitArr[i*8+4] = data->bitArr[channelWidth*(i+4)+pos*4];
        //    bitArr[i*8+5] = data->bitArr[channelWidth*(i+5)+pos*4];
        //    bitArr[i*8+6] = data->bitArr[channelWidth*(i+6)+pos*4];
        //    bitArr[i*8+7] = data->bitArr[channelWidth*(i+7)+pos*4];
        //}
    } else if (layout==ONCHIPx8) {
        for (int i=0; i<9; i++) {   // height
            bitArr[i*8+0] = data->bitArr[channelWidth*i+pos*8+0];
            bitArr[i*8+1] = data->bitArr[channelWidth*i+pos*8+1];
            bitArr[i*8+2] = data->bitArr[channelWidth*i+pos*8+2];
            bitArr[i*8+3] = data->bitArr[channelWidth*i+pos*8+3];
            bitArr[i*8+4] = data->bitArr[channelWidth*i+pos*8+4];
            bitArr[i*8+5] = data->bitArr[channelWidth*i+pos*8+5];
            bitArr[i*8+6] = data->bitArr[channelWidth*i+pos*8+6];
            bitArr[i*8+7] = data->bitArr[channelWidth*i+pos*8+7];
        }
    } else {
        assert(0);
    }
}

//----------------------------------------------------------
void CacheLine::print(FILE *fd) const {
    char format[5];
    if (chipWidth==4) {
        strcpy(format, "%01x");
    } else {
        strcpy(format, "%02x");
    }
    int buffer;
    for (int i=beatHeight-1; i>=0; i--) {
        buffer = 0;            
        for (int j=channelWidth-1; j>=0; j--) {
            buffer = (buffer<<1) | bitArr[channelWidth*i+j];
            if ((j%chipWidth)==0) {
                if (chipWidth==4) {
                    fprintf(fd, "%01X", buffer);
                } else if (chipWidth==8) {
                    fprintf(fd, "%02X", buffer);
                } else {
                    fprintf(fd, "%03X", buffer);
                }
                if (j>0) {
                    fprintf(fd, "_");
                } 
                buffer = 0;
            }
        }
        fprintf(fd, "\n");
    }
}
