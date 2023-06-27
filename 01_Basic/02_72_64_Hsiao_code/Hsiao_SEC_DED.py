import numpy as np
import random

def main():
    H_Matrix=np.loadtxt("H_Matrix.txt", dtype="int")
    redundancy_len=len(H_Matrix) # 8
    codeword_length=len(H_Matrix[0]) # 72
    data_length=codeword_length-redundancy_len # 64

    iteration_num=1000
    CE_cnt=0
    DUE_cnt=0
    UE_cnt=0

    # 1-bit error injection
    cnt=0
    while cnt<iteration_num:
        # codeword initialization (no-error)
        codeword=np.zeros(codeword_length, dtype=int)

        # error injection (1-bit error)
        # error position : 0~71
        error_position=random.randrange(0,codeword_length)
        codeword[error_position]^=1

        # Calculate Syndrome
        codeword_transpose = codeword.transpose()
        Syndrome=np.matmul(H_Matrix, codeword_transpose)

        # Error correction
        for error_index in range(codeword_length):
            if np.array_equal(H_Matrix[:,error_index],Syndrome):
                codeword[error_index]^=1
                break

        # count CE(Corrected Error), DUE(Detected Error), UE(Un Detected and UnCorrected Error)
        if np.all(codeword==0) and np.any(Syndrome>0):
            CE_cnt+=1
        elif np.any(codeword>0) and np.any(Syndrome>0):
            DUE_cnt+=1
        else:
            UE_cnt+=1

        # Continue to next iteration
        cnt+=1

    # 2-bit error injection
    cnt=0
    while cnt<iteration_num:
        # codeword initialization (no-error)
        codeword=np.zeros(codeword_length, dtype=int)

        # error injection (2-bit error)
        # error position : 0~71
        error_position1=0
        error_position2=0
        while(1):
            error_position1=random.randrange(0,codeword_length)
            error_position2=random.randrange(0,codeword_length)
            if error_position1!=error_position2:
                break
        codeword[error_position1]^=1
        codeword[error_position2]^=1

        # Calculate Syndrome
        codeword_transpose = codeword.transpose()
        Syndrome=np.matmul(H_Matrix, codeword_transpose)

        # Error correction
        for error_index in range(codeword_length):
            if np.array_equal(H_Matrix[:,error_index],Syndrome):
                codeword[error_index]^=1
                break

        # count CE(Corrected Error), DUE(Detected Error), UE(Un Detected and UnCorrected Error)
        if np.all(codeword==0) and np.any(Syndrome>0):
            CE_cnt+=1
        elif np.any(codeword>0) and np.any(Syndrome>0):
            DUE_cnt+=1
        else:
            UE_cnt+=1

        # Continue to next iteration
        cnt+=1
    
    # Hsiao code check
    Hsiao_check=0
    for H_Matrix_index in range(codeword_length):
        if np.count_nonzero(H_Matrix[:,H_Matrix_index])%2==0:
            Hsiao_check+=1


    # Final result report
    print("CE_cnt : {0}".format(CE_cnt))
    print("DUE_cnt : {0}".format(DUE_cnt))
    print("UE_cnt : {0}".format(UE_cnt))
    if Hsiao_check==0:
        print("Right H-Matrix!! It is Hsiao code.")
    else:
        print("Wrong H-Matrix!! It is not Hsiao code.")


if __name__ == "__main__":
    main()
