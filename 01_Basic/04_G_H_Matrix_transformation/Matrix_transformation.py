# This function converts an H-Matrix into a G-Matrix.
# input : H-Matrix.txt
# output : systematic H-Matrix.txt, systematic G-Matrix.txt, G-Matrix.txt (the G-Matrix corresponding to the input H-Matrix.txt)
# At the same time, it also checks if GH^T = 0.
# Upon inputting an H-Matrix, it outputs three matrices: systematic H-Matrix, systematic G-Matrix, and G-Matrix.

import numpy as np

def main():
    H_Matrix=np.loadtxt("H_Matrix.txt", dtype="int")
    """
        Fill your code here!! (This part is optional!) 


    """

    f=open("H_Matrix_to_G_Matrix_result.txt","w")


    # 1. Convert H_Matrix to systematic H_Matrix
    """
        Fill your code here!!!!
    """


    np.savetxt('H_Matrix_systematic.txt',H_Matrix, fmt='%d',delimiter=' ')

    # 2. Convert systematic H_Matrix to systematic G_Matrix and verify GH^T = 0
    """
        Fill your code here!!


    """

    np.savetxt('G_Matrix_systematic.txt',G_Matrix,fmt='%d',delimiter=' ')
    
    # 2-1. G*H^T = 0 check

    """
        Fill your code here!!!!

    """


    # 3. Convert systematic G-Matrix to systematic H-Matrix and verify GH^T = 0
    """
        Fill your code here!!!

    """

    np.savetxt('G_Matrix.txt',G_Matrix,fmt='%d',delimiter=' ')


    f.close()

if __name__ == "__main__":
    main()


