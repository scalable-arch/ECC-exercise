// Source code URL: http://www.eccpage.com/rs.c

/*             rs.c        */
/* This program is an encoder/decoder for Reed-Solomon codes. Encoding is in
   systematic form, decoding via the Berlekamp iterative algorithm.
   In the present form , the constants mm, nn, tt, and kk=nn-2tt must be
   specified  (the double letters are used simply to avoid clashes with
   other n,k,t used in other programs into which this was incorporated!)
   Also, the irreducible polynomial used to generate GF(2**mm) must also be
   entered -- these can be found in Lin and Costello, and also Clark and Cain.

   The representation of the elements of GF(2**m) is either in index form,
   where the number is the power of the primitive element alpha, which is
   convenient for multiplication (add the powers modulo 2**m-1) or in
   polynomial form, where the bits represent the coefficients of the
   polynomial representation of the number, which is the most convenient form
   for addition.  The two forms are swapped between via lookup tables.
   This leads to fairly messy looking expressions, but unfortunately, there
   is no easy alternative when working with Galois arithmetic.

   The code is not written in the most elegant way, but to the best
   of my knowledge, (no absolute guarantees!), it works.
   However, when including it into a simulation program, you may want to do
   some conversion of global variables (used here because I am lazy!) to
   local variables where appropriate, and passing parameters (eg array
   addresses) to the functions  may be a sensible move to reduce the number
   of global variables and thus decrease the chance of a bug being introduced.

   This program does not handle erasures at present, but should not be hard
   to adapt to do this, as it is just an adjustment to the Berlekamp-Massey
   algorithm. It also does not attempt to decode past the BCH bound -- see
   Blahut "Theory and practice of error control codes" for how to do this.

              Simon Rockliff, University of Adelaide   21/9/89

   26/6/91 Slight modifications to remove a compiler dependent bug which hadn't
           previously surfaced. A few extra comments added for clarity.
           Appears to all work fine, ready for posting to net!

                  Notice
                 --------
   This program may be freely modified and/or given to whoever wants it.
   A condition of such distribution is that the author's contribution be
   acknowledged by his name being left in the comments heading the program,
   however no responsibility is accepted for any financial or other loss which
   may result from some unforseen errors or malfunctioning of the program
   during use.
                                 Simon Rockliff, 26th June 1991
*/

#include <stdio.h>
#include <math.h>
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

//#define mm  4           /* RS code over GF(2**4) - change to suit */
//#define nn  15          /* nn=2**mm -1   length of codeword (unshortened) */
//#define tt  2           /* number of errors that can be corrected */
//#define kk  11           /* kk = nn-2*tt (unshortened) */
//#define nn_short  13      /* length of codeword (shortened) */

#define mm  8           /* RS code over GF(2**8) - change to suit */
#define nn  255          /* nn=2**mm -1   length of codeword */
#define tt  2           /* number of errors that can be corrected */
#define kk  251           /* kk = nn-2*tt  */
#define nn_short  20      /* length of codeword (shortened) */


//int pp [mm+1] = {1, 1, 0, 0, 1}; // GF(2^4) 1+x+x^4
int pp [mm+1] = {1, 0, 1, 1, 1, 0, 0, 0, 1}; /* specify irreducible polynomial coeffts. ex: GF(2^8) 1+x^2+x^3+x^4+x^8 = {1, 0, 1, 1, 1, 0, 0, 0, 1} */ 
int alpha_to [nn+1], index_of [nn+1], gg [nn-kk+1];
enum RESULT_TYPE {NE=0, CE=1, DUE=2, SDC=3}; // result_type


/* generate GF(2**mm) from the irreducible polynomial p(X) in pp[0]..pp[mm]
   lookup tables:  index->polynomial form   alpha_to[] contains j=alpha**i;
                   polynomial form -> index form  index_of[j=alpha**i] = i
   alpha=2 is the primitive element of GF(2**mm)

    Based on GF(2^4) -> primitive polynomial: x^4+x+1

    index_of[0] = -1 -> 0000 is treated as a^-1
    index_of[a^0 (0001)] = 0
    index_of[a^1 (0010)] = 1
    index_of[a^2 (0100)] = 2
    index_of[a^3 (1000)] = 3
    index_of[a^4 (0011)] = 4
    index_of[a^5 (0110)] = 5
    index_of[a^6 (1100)] = 6
    index_of[a^7 (1011)] = 7
    index_of[a^8 (0101)] = 8
    index_of[a^9 (1010)] = 9
    index_of[a^10 (0111)] = 10
    index_of[a^11 (1110)] = 11
    index_of[a^12 (1111)] = 12
    index_of[a^13 (1101)] = 13
    index_of[a^14 (1001)] = 14
*/
void generate_gf()
{
  //register int i, mask;
  int i, mask;

  mask = 1;
  alpha_to[mm] = 0;
  
  // In the vector form of a^?, the parts with a single 1 -> 0000_0001, 0000_0010, ... 1000_0000 based on GF(2^8)
  for (i=0; i<mm; i++){ // 0~3 GF(2^4), 0~7 GF(2^8) 
    alpha_to[i] = mask;
    index_of[alpha_to[i]] = i;
    if (pp[i]!=0)
      alpha_to[mm] ^= mask;
    mask <<= 1;
  }
  index_of[alpha_to[mm]] = mm ;
  // Parts with two or more 1s in the vector form of a^?
  mask >>= 1 ;
  for (i=mm+1; i<(int)pow(2.0,mm)-1; i++){ // 5~14, 9~254  (supposed to nn)
    if (alpha_to[i-1] >= mask)
      alpha_to[i] = alpha_to[mm] ^ ((alpha_to[i-1]^mask)<<1);
    else 
      alpha_to[i] = alpha_to[i-1]<<1;
    index_of[alpha_to[i]] = i;
  }
  index_of[0] = -1;
}

/* Obtain the generator polynomial of the tt-error correcting, length
  nn=(2**mm -1) Reed Solomon code  from the product of (X+alpha**i), i=1..2*tt
*/
void gen_poly()
{
  register int i, j;

  gg[0] = 2;    /* primitive element alpha = 2  for GF(2**mm)  */
  gg[1] = 1;    /* g(x) = (X+alpha) initially */
  for (i=2; i<=nn-kk; i++){
    gg[i] = 1;
    for (j=i-1; j>0; j--){
      if (gg[j] != 0)  
        gg[j] = gg[j-1]^ alpha_to[(index_of[gg[j]]+i)%nn];
      else 
        gg[j] = gg[j-1];
    }
    gg[0] = alpha_to[(index_of[gg[0]]+i)%nn];     /* gg[0] can never be zero */
  }
  /* convert gg[] to index form for quicker encoding */
  for (i=0; i<=nn-kk; i++) 
    gg[i] = index_of[gg[i]];
}

/* take the string of symbols in data[i], i=0..(k-1) and encode systematically
   to produce 2*tt parity symbols in bb[0]..bb[2*tt-1]
   data[] is input and bb[] is output in polynomial form.
   Encoding is done by using a feedback shift register with appropriate
   connections specified by the elements of gg[], which was generated above.
   Codeword is   c(X) = data(X)*X**(nn-kk)+ b(X)          */
void encode_rs(int recd[], int data[], int bb[])
{
  register int i,j;
  int feedback;

  for (i=0; i<nn-kk; i++)
  bb[i] = 0;
  for (i=kk-1; i>=0; i--){
    feedback = index_of[data[i]^bb[nn-kk-1]];
    if (feedback != -1){
      for (j=(int)pow(2,mm)-1-kk-1; j>0; j--){
        if (gg[j] != -1)
          bb[j] = bb[j-1]^alpha_to[(gg[j]+feedback)%nn];
        else
          bb[j] = bb[j-1];
      }
      bb[0] = alpha_to[(gg[0]+feedback)%nn];
    }
    else{
      for (j=nn-kk-1; j>0; j--)
        bb[j] = bb[j-1];
      bb[0] = 0;
    }
  }
}


/* assume we have received bits grouped into mm-bit symbols in recd[i],
   i=0..(nn-1),  and recd[i] is index form (ie as powers of alpha).
   We first compute the 2*tt syndromes by substituting alpha**i into rec(X) and
   evaluating, storing the syndromes in s[i], i=1..2tt (leave s[0] zero) .
   Then we use the Berlekamp iteration to find the error location polynomial
   elp[i].  
   
   NE 'or' SDC: If syndromes are all zero

   DUE: If the degree of the elp is >tt, we cannot correct all the errors
   and hence just put out the information symbols uncorrected.
   
   CE 'or' SDC : If the degree of elp is <=tt, we substitute alpha**i , i=1..n into the elp to get the roots,
   hence the inverse roots, the error location numbers. 
   
   The procedure is that found in Lin and Costello. 
   For the cases where the number of errors is known to be too
   large to correct, the information symbols as received are output (the
   advantage of systematic encoding is that hopefully some of the information
   symbols will be okay and that if we are in luck, the errors are in the
   parity part of the transmitted codeword).  Of course, these insoluble cases
   can be returned as error flags to the calling routine if desired.   
*/

int decode_rs(int recd[], int data[], int bb[])
{
    /*
    //////////////////////////////////////////////

        Fill your code here!!!!

    ///////////////////////////////////////////////
    */
}



int main()
{
  register int i;
  srand((unsigned int) time (NULL));

/* generate the Galois Field GF(2**mm) */
  generate_gf();
  /*
  printf("Generate GF table\n");
  printf("Look-up tables for GF(2**%2d)\n",mm);
  printf("  i   alpha_to[i]  index_of[i]\n");
  for (i=0; i<=nn; i++)
   printf("%3d      %3d          %3d\n",i,alpha_to[i],index_of[i]) ;
  printf("\n\n");
  */

/* compute the generator polynomial for this RS code */
  gen_poly();
  /*
  printf("Compute the generator polynomial\n");
  printf("gg: ");
  for(int index=0; index<nn-kk+1; index++)
    printf("%d ",gg[index]);
  printf("\n");
  */

  int runNum=1000000;
  int recd [nn], data [nn-2*tt], bb [tt*2]; // codeword, data, redundancy
  int cnt=0;
  int error_symbol_num;
  int result_type_rs_code;
  int CE_cnt=0, DUE_cnt=0, SDC_cnt=0;
  while(cnt<runNum){
  // Original information (data)
  // Original information (nn_short-tt*2) + Zero-padding (kk-(nn_short-tt*2))
    for (i=0; i<kk; i++)  
      data[i] = 0;

    /* for example, say we transmit the following message (nothing special!) */
    /*
    data[0] = 8;
    data[1] = 6;
    data[2] = 8;
    data[3] = 1; // a^0
    data[4] = 2; // a^1
    data[5] = 4; // a^2
    data[6] = 15;
    data[7] = 9;
    data[8] = 9;
    */

  /* encode */
    encode_rs(recd, data, bb);
    // Systematic encoding

  /* put the transmitted codeword, made up of data plus parity, in recd[] */
    // Systematic format
    // parity
    for (i=0; i<nn-kk; i++)
      recd[i] = bb[i];
    // data
    for (i=0; i<kk; i++)
      recd[i+nn-kk] = data[i];
    
    // original codeword
    /*
      printf("original codeword (shortened): ");
      for(int index=0; index<nn_short; index++)
        printf("%d ",recd[index]);
      printf("\n");
    */

  /* Error injection */
    //printf("error injection!\n");
    error_symbol_num=rand()%(tt)+1; // tt=2 -> error symbol 개수 1~2개 
    int error_count=0;
    while(error_count<error_symbol_num){
      int error_location;
      while(1){
        error_location=rand()%nn_short;
        if(recd[error_location]==0)
          break;
      }
      recd[error_location]=rand()%(nn)+1; // recd[error location] = error value
      error_count++;
    }

    //recd[5] = 7;
    //recd[8] = 13;

    // received codeword
    /*
    printf("received codeword (shortened): ");
    for(int index=0; index<nn_short; index++)
      printf("%d ",recd[index]);
    printf("\n");\
    */

    /* put recd[i] into index form */
    for (i=0; i<nn; i++)
      recd[i] = index_of[recd[i]];        

  /* decode recv[] */
    //printf("decoding!\n");
    result_type_rs_code=decode_rs(recd, data, bb);         /* recd[] is returned in polynomial form */

  // SDC check
    //printf("SDC check\n");
    if (result_type_rs_code==NE || result_type_rs_code==CE){
      for(int index=0; index<nn_short; index++){
        if(recd[index]!=0){ // remained error
          result_type_rs_code=SDC;
          break;
        }
      }
    }

    // decoded codeword {parity, message}
    /*
    printf("decoded codeword (shortened): ");
    // parity
    for (i=0; i<tt*2; i++)
      printf("%d ",recd[i]);
    // original information (data)
    for (i=tt*2; i<nn_short; i++)
      printf("%d ",recd[i]);
    printf("\n");
    */
    //printf("result report\n");

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
