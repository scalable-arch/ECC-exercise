import numpy as np
from tqdm import tqdm

def encode(msg, generator):
    # msg is 1d numpy array
    # Output (codeword) should be 1d numpy array
    ## Fill the code
    
    return codeword

def decode(receive, generator):
    # receive is 1d numpy array
    # If the error is detected, then return 1
    # If not, return 0
    ## Fill the code


    return det

def get_period(gen):
    # gen is the generator polynomial
    # return the period of the generator polynomial
    ## Fill the code
    
    return period

def monte_carlo_sim(gen, msg_len, iteration):
    # gen is the generator polynomial
    # Hint : see the test_functionality function.
    ## Fill the code
    pass

def test_functionality():
    msg = np.array([1,1,0,1,0,0,1,1,1,0,1,1,0,0], dtype=np.int8)
    gen = np.array([1,0,1,1], dtype=np.int8)
    codeword = encode(msg.copy(), gen)
    error = np.random.binomial(1,0.5,len(codeword))
    receive = codeword ^ error
    detection = decode(receive.copy(), gen)
    print("Msg      : ", msg)
    print("Codeword : ", codeword)
    print("Error    : ", error)
    print("Receive  : ", receive)
    if detection:
        print("Error is detected")
    else:
        print("Error is not detected")

if __name__ == '__main__':
    test_functionality()
