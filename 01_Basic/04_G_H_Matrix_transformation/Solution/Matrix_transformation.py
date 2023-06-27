# H-Matrix를 입력하면 G-Matrix로 바꾸는 함수이다.
# input : H-Matrix.txt
# output : systematic H-Matrix.txt, systematic G-Matrix.txt, G-Matrix.txt (input H-Matrix.txt에 대응하는 G-Matrix)
# 그와 동시에 GH^T = 0 인지도 검사해준다.
# H-Matrix를 입력하면 systematic H-Matrix, systematic G-Matrix, G-Matrix 3개를 출력한다.

import numpy as np

def main():
    H_Matrix=np.loadtxt("H_Matrix.txt", dtype="int")
    H_Matrix_original=H_Matrix.copy()
    column_swap_index=list()
    row_num=len(H_Matrix) # 16
    column_num=len(H_Matrix[0]) # 144
    f=open("H_Matrix_to_G_Matrix_result.txt","w")


    # 1. H_Matrix를 systematic H_Matrix로 변환
    for row_index in range(row_num-1,-1,-1): # 15~0
        # H-Matrix의 해당 row 위치에서 1이 있는지 검사
        # 없으면 column swap (기록 필요!)
        if H_Matrix[row_index][column_num-row_num+row_index]!=1:
            f.write("\n\ncolumn swap start!\n")
            f.write(np.array2string(H_Matrix))
            swap_start_index=column_num-row_num+row_index-1
            while(1):
                if H_Matrix[row_index][swap_start_index]==1:
                    break
                else:
                    swap_start_index-=1
            temp=list()
            temp.append(column_num-row_num+row_index)
            temp.append(swap_start_index)
            string_output="\ncolumn swap first : %d, " % (column_num-row_num+row_index)
            f.write(string_output)
            string_output="column swap second : %d" % swap_start_index
            f.write(string_output)
            column_swap_index.append(temp)
            temp_row=H_Matrix[:,column_num-row_num+row_index].copy()
            H_Matrix[:,column_num-row_num+row_index]=H_Matrix[:,swap_start_index]
            H_Matrix[:,swap_start_index]=temp_row
            f.write("\ncolumn swap over!\n")
            f.write(np.array2string(H_Matrix))
        # row operation 진행
        f.write("\n\n row operation start!!\n")
        for row_operation_index in range(row_num-1, -1, -1): # 15~0
            if row_operation_index==row_index:
                continue
            if H_Matrix[row_operation_index][column_num-row_num+row_index]==1:
                string_output="\nrow operation base : %d, " % (row_index)
                f.write(string_output)
                string_output="\nrow operation second : %d\n" % (row_operation_index)
                f.write(string_output)
                H_Matrix[row_operation_index]=(H_Matrix[row_operation_index]-H_Matrix[row_index])%2
                f.write(np.array2string(H_Matrix))
            
    np.savetxt('H_Matrix_systematic.txt',H_Matrix, fmt='%d',delimiter=' ')

    # 2. systematic H_Matrix를 systematic G_Matrix로 변환하고 GH^T=0 확인
    G_Matrix=np.empty((column_num-row_num,column_num-row_num))
    for row_index in range(column_num-row_num):
        for column_index in range(column_num-row_num):
            if row_index==column_index:
                G_Matrix[row_index][column_index]=1
            else:
                G_Matrix[row_index][column_index]=0
    H_Matrix_parity_part=H_Matrix[:,:column_num-row_num].copy()
    H_Matrix_parity_part=H_Matrix_parity_part.T # transpose
    G_Matrix=np.concatenate([G_Matrix,H_Matrix_parity_part],1)
    np.savetxt('G_Matrix_systematic.txt',G_Matrix,fmt='%d',delimiter=' ')
    check=np.dot(G_Matrix,H_Matrix.T)
    check[:]=check[:]%2
    if(np.count_nonzero(check)):
        print("GH^T_Systematic all zero! right!")
    else:
        print("GH^T_Systematic non all zero! error!")

    # 3. systematic G-Matrix를 systmeatic H-Matrix로 변환하고 GH^T=0 확인
    print("column swap index : ",column_swap_index)
    column_swap_count=len(column_swap_index)
    for swap_count in range(column_swap_count-1,-1,-1):
        first_swap_position=column_swap_index[swap_count][0]
        second_swap_position=column_swap_index[swap_count][1]
        temp_row=G_Matrix[:,first_swap_position].copy()
        G_Matrix[:,first_swap_position]=G_Matrix[:,second_swap_position]
        G_Matrix[:,second_swap_position]=temp_row

    np.savetxt('G_Matrix.txt',G_Matrix,fmt='%d',delimiter=' ')
    check=np.dot(G_Matrix,H_Matrix_original.T)
    check[:]=check[:]%2
    if(np.count_nonzero(check)):
        print("GH^T_Non systematic all zero! right!")
    else:
        print("GH^T_Non systematic non all zero! error!")

    f.close()

if __name__ == "__main__":
    main()


