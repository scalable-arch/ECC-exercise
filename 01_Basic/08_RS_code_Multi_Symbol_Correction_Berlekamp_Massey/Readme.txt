Source code URL: http://www.eccpage.com/rs.c
 -> 해당 코드를 사용이 용이하도록 변경

*** Answer ***

CE_cnt : 1000000
DUE_cnt : 0
SDC_cnt : 0

결과가 위 숫자와 다르면 이상한 것이니 코드를 분석해보세요!
100만가지 random symbol error에 대해서 전부 correction을 하지 못하면 코드를 잘못짠 것!

1. 실행법
    (1) g++ RS_code.cpp
    (2) ./a.out

2. 코드 설명
    해당 경우는 error injection을 1개 이상 여러개 symbol에서 진행한 경우입니다. (tt (correction capability) 이내로 error가 발생합니다.)
    Code configuration은 [20, 16] DSC (Double Symbol Correction)이며, GF(2^8) 입니다. -> 8-bit symbol (bit 단위로 하면 (160, 128) code 입니다.)
    Correction capability : DSC (Double Symbol Correction)
    1~2개 symbol error가 100만 번 발생한다. tt=2 이기에 2개의 symbol까지 correction이 가능하여 CE가 100%가 나와야 한다.
    Systematic-code 입니다.

3. 해야하는 것!!
    ****** decode_rs() 함수 구현 ******

    1. input : recd (received codeword), data (information part), bb (redundancy part)

    2. 함수 내용 : received codeword의 tt개 이하 symbol error를 전부 correction (8-bit symbol 기준)

    3. 해야 하는 것
    (1) codeword의 tt개 이하 symbol error 전부 correction (8-bit symbol 기준)
    (2) result_type_rs_code 갱신 (아래 3가지로 분류합니다. SDC는 error correction 함수 다음에 검사하며, 구현되어 있습니다.)
        [1] codeword를 검사해서 error가 없으면 NE
        [2] error가 있으나 error를 정정할 수 있는 경우이고 error를 correction 했으면 CE
        [3] error가 있으나 error를 정정할 수 없는 경우이면 DUE

4. 정답 코드 : Solution 폴더에 들어 있습니다.


