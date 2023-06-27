# H-Matrix를 입력하면 G-Matrix로 바꾸는 함수이다.
# input : H-Matrix.txt
# output : systematic H-Matrix.txt, systematic G-Matrix.txt, G-Matrix.txt (input H-Matrix.txt에 대응하는 G-Matrix)
# 그와 동시에 GH^T = 0 인지도 검사해준다.
# H-Matrix를 입력하면 systematic H-Matrix, systematic G-Matrix, G-Matrix 3개를 출력한다.

import numpy as np

def main():
    H_Matrix=np.loadtxt("H_Matrix.txt", dtype="int")
    """
        Fill your code here!! (This part is optional!) 


    """

    f=open("H_Matrix_to_G_Matrix_result.txt","w")


    # 1. H_Matrix를 systematic H_Matrix로 변환
    """
        Fill your code here!!!!
    """


    np.savetxt('H_Matrix_systematic.txt',H_Matrix, fmt='%d',delimiter=' ')

    # 2. systematic H_Matrix를 systematic G_Matrix로 변환하고 GH^T=0 확인
    """
        Fill your code here!!


    """

    np.savetxt('G_Matrix_systematic.txt',G_Matrix,fmt='%d',delimiter=' ')
    
    # 2-1. G*H^T = 0 확인

    """
        Fill your code here!!!!

    """


    # 3. systematic G-Matrix를 systmeatic H-Matrix로 변환하고 GH^T=0 확인
    """
        Fill your code here!!!

    """

    np.savetxt('G_Matrix.txt',G_Matrix,fmt='%d',delimiter=' ')


    f.close()

if __name__ == "__main__":
    main()


