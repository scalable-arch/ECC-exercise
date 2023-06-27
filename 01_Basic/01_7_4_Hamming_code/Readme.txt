*** Answer

CE_cnt : 1000
UCE_cnt : 0

위 결과와 다르게 나오면 이상한 것이니 H_Matrix.txt를 수정하시기 바랍니다.

1. 과제 목표
 -> (7,4) Hamming SEC (Single-Error Correction) code 작성
 -> 해당 correction 능력을 가지는 H-Matrix (Parity Check Matrix) 설계

2. 해야할 것
 -> H-Matrix.txt 생성

3. Hint
 -> 1-bit error correction을 하려면 H-Matrix가 어떠한 조건을 가져야 하는지 생각해봅시다.
 -> ECC는 기본적으로 H-matrix 설계에서 시작합니다. (H-Matrix만 구하면 그에 상응하는 G-Matrix (Generator Matrix)를 구할 수 있습니다.)

4. 기타 설명
 -> codeword에서 error는 1로 표시됩니다.
 -> Ex) codeword : 0010000 => 3번째 bit에서 error 발생
 -> 해당 문제에서는 1bit error만 발생합니다. (1000번 iteration) => 즉, 100% error correction이 이루어져야 합니다. (UCE_cnt>0 이면 이상한 것이니 H-Matrix를 바꿔보세요!)