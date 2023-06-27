
*** Answer ***

CE_cnt : 1000000
DUE_cnt : 0
SDC_cnt : 0


결과가 위 숫자와 다르면 이상한 것이니 코드를 분석해보세요!
100만가지 random 1 symbol error에 대해서 전부 correction을 하지 못하면 코드를 잘못짠 것!

1. 실행법
    (1) g++ RS_code.cpp
    (2) ./a.out

2. 코드 설명
    해당 경우는 error injection을 1개 symbol만 진행한 경우입니다.
    Code configuration은 DDR5의 AMDCHIPKILL에 맞도록 구성했습니다. Beat 1개마다 (32+8) 이며, 2개의 beat을 모아서 (64+16) 으로 8-bit symbol으로 RS-code 진행.
    Correction capability : SSC (Single Symbol Correction)

3. 해야하는 것!!
    ****** decoding 함수 구현 ******

    1. input : codeword

    2. 함수 내용 : codeword의 1개 symbol error를 전부 correction (8-bit symbol 기준)

    3. 해야 하는 것
    (1) codeword의 1개 symbol error 전부 correction (8-bit symbol 기준)
    (2) result_type_rs_code 갱신 (아래 3가지로 분류합니다.)
        [1] codeword를 검사해서 error가 없으면 NE
        [2] error가 있으나 error를 정정할 수 있는 경우이고 error를 correction 했으면 CE
        [3] error가 있으나 error를 정정할 수 없는 경우이면 DUE

4. 정답 코드 : Solution 폴더에 들어 있습니다.