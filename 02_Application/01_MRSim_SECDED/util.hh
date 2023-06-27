/**
 * @file: util.hh
 * @author: Jungrae Kim <dale40@gmail.com>
 * utility declaration 
 */

#ifndef __UTIL_HH__
#define __UTIL_HH__

#include <stdint.h>

typedef unsigned POLY;
typedef int INDEX;

void printPoly(POLY p, int m);
POLY multiPoly(POLY p1, POLY p2);
int degreePoly(POLY p);

typedef bool DataArrType;
//typedef uint16_t DataArrType;
//typedef uint8_t DataArrType;

#endif /* __UTIL_HH__ */
