# [20, 16] RS (Reed-Solomon) code

- Source code URL: http://www.eccpage.com/rs.c
- This code has been modified for easy use.

# Author

**Dongwhee Kim** 
- Email: xyz12347976@gmail.com
- Google Scholar: https://scholar.google.com/citations?user=8xzqA8YAAAAJ&hl=ko&oi=ao

# Objectives
- Implement a [20, 16] systematic shortened RS code **[1]** over GF(256).
- Understand the decoding method of RS code.
- Implement the **Berlekamp-Massey Algorithm [2]**.
- **The above method must be used for multi-symbol correction in RS codes**.

# Overview
![An Overview of the exercise](https://github.com/xyz123479/ECC-exercise/blob/main/01_Basic/08_RS_code_Multi_Symbol_Correction_Berlekamp_Massey/RS%20code%20-%20DSC.png)

# Code flows
- 1. Codeword setting: all zero (no error)
- 2. Error injection (1~tt symbol error)
- 3. Correct all symbol errors in the codeword (based on 8-bit symbol)
- 4. Return result_type_rs_code (classified into the following 3 types)
>> 1. **NE**: If there is no error when checking the codeword
>> 2. **CE**: If there is an error but it is correctable and the error has been corrected
>> 3. **DUE**: If there is an error but it is not correctable.

# To do
- Construct **decode_rs()** function in RS_code.cpp
- Input: recd (received codeword), data (information part), bb (redundancy part)
- decoding function input: codeword - unsigned integer array
- decoding function content: Correct all symbol errors within **tt (correction capability)** in the received codeword (based on 8-bit symbol)
- decoding function output: result_type_rs_code (NE, CE, DUE)

# Getting Started
- $ g++ RS_code.cpp
- $ ./a.out

# Answer
- CE_cnt: 1,000,000
- DUE_cnt: 0
- SDC_cnt: 0

If the result differs from these numbers, something is wrong. Please analyze the code!

You've coded incorrectly if you can't correct all one million random symbol errors!

The answer code is in the Solution folder.

# Hint
- Correction capability (tt): DSC (Double Symbol Correction)

# Additional Information
- CE: Correctable Error
- DUE: Detectable but Uncorrectable Error
- SDC: Silent-Data Corruption
- This exercise only injects a **1 ~ tt** symbol error.

# Reference
- **[1]** Reed, Irving S., and Gustave Solomon. "Polynomial codes over certain finite fields." Journal of the society for industrial and applied mathematics 8.2 (1960): 300-304.
- **[2]** https://en.wikipedia.org/wiki/Berlekamp%E2%80%93Massey_algorithm




