코드 실행법
 (1) make clean
 (2) make
 (3) python run.py 

채워야 할 코드 부분 : hsiao.cc (Fill your code here!! 2개 부분을 채우면 된다.)

정답코드 : Solution 파일에 있습니다.

Code-Configuration
DDR4의 x4 chip 기준으로 (16 data chip + 2 parity chip) ECC-DIMM 이다.
(72,64) Hsiao SEC-DED 코드를 사용하였다.

정답 확인 방법 : 010.4x18.SECDED.0.S 파일의 결과가 아래와 같은 결과가 나와야 한다!!!
Retire, DUE, SDC는 각각 100번 , 10000번 실행했을때 Retire, DUE, SDC가 나올 확률이다. (0~1)
각 year 마다 Retire, DUE, SDC가 나올 확률 -> 누적이다.

Ex
0.01230000000 -> 1년 경과
0.02430000000 -> 2년 경과
0.03520000000 -> 3년 경과
0.04880000000 -> 4년 경과
0.06110000000 -> 5년 경과

Fault model 데이터 : [SC'12] A_study_of_DRAM_failures_in_the_field 논문
Fault model simulation 논문 : [TACO'15] FAULTSIM_A Fast, Configurable Memory-Reliability Simulator for Conventional and 3D-Stacked Systems 논문기반

After 100 runs
Retire
0.00000000000
0.00000000000
0.00000000000
0.00000000000
0.00000000000
DUE
0.01000000000
0.02000000000
0.02000000000
0.04000000000
0.05000000000
SDC
0.00000000000
0.00000000000
0.00000000000
0.00000000000
0.00000000000
After 10000 runs
Retire
0.00000000000
0.00000000000
0.00000000000
0.00000000000
0.00000000000
DUE
0.01230000000
0.02430000000
0.03520000000
0.04880000000
0.06110000000
SDC
0.00010000000
0.00020000000
0.00030000000
0.00050000000
0.00060000000


