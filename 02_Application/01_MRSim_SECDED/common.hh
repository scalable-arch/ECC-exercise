#ifndef __COMMON_HH__
#define __COMMON_HH__

typedef unsigned long long ADDR;

//#define DUE_BREAKDOWN

// The order is important.
//: DUE > SDC because any DUE on a block will override SDC
#ifdef DUE_BREAKDOWN 
typedef enum {NE=0, CE=1, DUE=2, DUE_Parity=3, DUE_NoErasure=4, SDC=5, SDC_Erasure=6} ErrorType;
#else
typedef enum {NE=0, CE=1, DUE=2, SDC=3} ErrorType;
#endif
// Duplicate / Miss / Duplicate-or-Miss

ErrorType worseErrorType(ErrorType a, ErrorType b);

#endif /* __COMMON_HH__ */
