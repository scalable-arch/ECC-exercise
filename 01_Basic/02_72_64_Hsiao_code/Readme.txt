*** Answer

CE_cnt : 1000
DUE_cnt : 1000
UE_cnt : 0

위 결과와 다르게 나오면 이상한 것이니 H_Matrix.txt를 수정하시기 바랍니다.

1. 과제 목표
 -> (72,64) Hsiao SEC-DED (Single-Error Correction) code 작성
 -> 해당 correction 능력을 가지는 H-Matrix (Parity Check Matrix) 설계
 -> Hardware friendly H-Matrix 설계
 -> 가급적 Systematic code로 설계합시다. (장점 : A faster hash function)

2. 해야할 것
 -> H-Matrix.txt 생성

3. Hint
 -> 1-bit error correction, 2-bit error detection을 하려면 H-Matrix가 어떠한 조건을 가져야 하는지 생각해봅시다.
 -> 또한, Hsiao code는 Hardware friendly 하기에 'xor' tree depth를 최소화하는 방향을 생각합니다. (Hamming code로도 SEC-DED 구현은 가능하지만, Hsiao 코드로 구현하여 hardware에 친화적인 H-matrix를 이해하는 것이 목적입니다.)
 -> ECC는 기본적으로 H-matrix 설계에서 시작합니다. (H-Matrix만 구하면 그에 상응하는 G-Matrix (Generator Matrix)를 구할 수 있습니다.)

4. 기타 설명
 -> codeword에서 error는 1로 표시됩니다.
 -> Ex) codeword : 0010000....00 => 3번째 bit에서 error 발생
 -> 해당 문제에서는 1bit error, 2-bit error만 발생합니다. (각 1000번 iteration) => 즉, 100% error correction/detection이 이루어져야 합니다. (UE_cnt>0 이면 이상한 것이니 H-Matrix를 바꿔보세요!)