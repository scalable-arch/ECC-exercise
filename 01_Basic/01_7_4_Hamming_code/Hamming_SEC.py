import numpy as np
import random

def main():
    H_Matrix=np.loadtxt("H_Matrix.txt", dtype="int")
    redundancy_len=len(H_Matrix) # 3
    codeword_length=len(H_Matrix[0]) # 7
    data_length=codeword_length-redundancy_len # 4

    cnt=0
    iteration_num=10
    CE_cnt=0
    UCE_cnt=0
    while cnt<iteration_num:
        # codeword initialization (no-error)
        codeword=np.zeros(codeword_length, dtype=int)

        # error injection (1-bit error)
        # error position : 0~6
        error_position=random.randrange(0,codeword_length)
        codeword[error_position]^=1

        # Calculate Syndrome
        codeword_transpose = codeword.transpose()
        Syndrome=(np.matmul(H_Matrix, codeword_transpose))%2

        # Error correction
        for error_index in range(codeword_length):
            if np.array_equal(H_Matrix[:,error_index],Syndrome):
                codeword[error_index]^=1
                break

        # count CE(Corrected Error), UCE(Un Corrected Error)
        if np.all(codeword==0):
            CE_cnt+=1
        else:
            UCE_cnt+=1

        # Continue to next iteration
        cnt+=1  
    
    print("CE_cnt : {0}".format(CE_cnt))
    print("UCE_cnt : {0}".format(UCE_cnt))

if __name__ == "__main__":
    main()
