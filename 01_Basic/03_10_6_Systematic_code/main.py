'''
ECC 1st homework
Author : PTW
Date : 22.6.16
'''

import numpy as np
from code import encode, decode

def test_functionality():

    # This is the flag to check whehter your code is systematic or not
    is_systematic = 1

    # This is the flag to check whehter your code pass the test cases completely
    success = 1

    # Check all cases
    for iteration, case in enumerate(range(2 ** 6)):
        
        # Get the message
        # e.g.) case = 34 -> msg = [1 0 0 0 1 0]
        # msg is numpy array (shape should be (6,))
        msg_packed = np.array(case, dtype=np.uint8)
        msg = np.unpackbits(msg_packed)[2:]

        # Print the case and msg
        print(f"Case #{iteration:2d} : Message {msg}", end = " ")

        # For check the wrong result
        wrong = 0

        # Encode the msg to get codeword
        codeword = encode(msg.copy())

        # Check whether your code is systematic
        if not (msg == codeword[:6]).all():
            is_systematic = 0
            success = 0

        # Decode the codeword
        result = decode(codeword.copy())

        # This case check the decode functionality
        # when there is no error
        if not (codeword==result).all():
            wrong += 1
            success = 0
        # This case check the decode functionality
        # when there is one bit error
        for pos in range(10):
            error = np.zeros(10, dtype=np.int8)
            error[pos] = 1
            receive = codeword ^ error
            result = decode(receive.copy())
            if not (codeword==result).all():
                wrong += 1
                success = 0

        # This case check the decode functionality
        # when there are two bits error which can be corrected.
        for pos in range(0,10,2):
            error = np.zeros(10, dtype=np.int8)
            error[pos] = 1
            error[pos+1] = 1
            receive = codeword ^ error
            result = decode(receive.copy())
            if not (codeword==result).all():
                wrong += 1
                success = 0
        
        # Print the result
        if wrong == 0:
            print(f"{'>' * 10} Pass {16 - wrong} / {16}")
        else:
            print(f"{'>' * 10} Fail {16 - wrong} / {16}")

    # If your code is not systematic, it will print the sentence below.
    if is_systematic == 0:
        print("Your code is not systematic, please check it again")

    if success:
        print("Your code passes all the test cases!!")
    else:
        print("Your code doesn't pass all the test cases!!")

if __name__ == '__main__':
   test_functionality()