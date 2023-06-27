/**
 * @file: util.hh
 * @author: Jungrae Kim <dale40@gmail.com>
 * utility declaration 
 */

#include <stdio.h>
#include <assert.h>
#include "util.hh"

//------------------------------------------------------------------------------
void printPoly(POLY p, int m) {
    bool first = true;
    for (int i=m; i>=0; i--) {
        if (p & (1<<i)) {
            if (i==0) {
                printf("%s1", first ? "" : "+");
            } else {
                printf("%sx^%d", first ? "" : "+", i);
            }
            first = false;
        } else {
            if (i==0) {
                printf("%s", first ? "0" : " ");
            } else {
                printf("    ");
            }
        }
    }
}

POLY multiPoly(POLY p1, POLY p2) {
    POLY result(0u);
    for (int i=31; i>=0; i--) {
        if (p2 & (1<<i)) {
            result ^= (p1<<i);
        }
    }
    return result;
}

int degreePoly(POLY p) {
    for (int i=31; i>=0; i--) {
        if (p & (1<<i)) {
            return i;
        }
    }
}

//------------------------------------------------------------------------------
