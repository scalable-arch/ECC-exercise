# [72, 64] SEC-DED code - Hsiao

# Author

**Dongwhee Kim** 

- Email: xyz12347976@gmail.com
- Google Scholar: https://scholar.google.com/citations?user=8xzqA8YAAAAJ&hl=ko&oi=ao

# Objectives
- Writing a (72,64) Hsiao SEC-DED (Single-Error Correction) code
- Design an H-Matrix (Parity Check Matrix) with the corresponding correction capability
- Design a hardware-friendly H-Matrix
- Design a Systematic code. (Advantage: Simplicity, Efficiency)
- I recommend updating the error_symbol_position and Syndrome as well.
- These could be useful depending on the ECC (Error Correction Code) scheme being used **[1]**.

# Overview
![An Overview of the exercise](https://github.com/xyz123479/ECC-exercise/blob/main/01_Basic/02_72_64_Hsiao_code/%5B72%2C%2064%5D%20Hsiao%20code.png)

# Code flows
- 1. Correct all 1 symbol errors in the codeword (based on 8-bit symbol)
- 2. Update result_type_rs_code (classified into the following 3 types)
>> 1. **NE**: If there is no error when checking the codeword
>> 2. **CE**: If there is an error but it is correctable and the error has been corrected
>> 3. **DUE**: If there is an error but it is not correctable

# To do
- Construct **decoding** function in RS_code.cpp
- decoding function input: codeword - unsigned integer array
- decoding function output: result_type_rs_code (NE, CE, DUE)

# Getting Started
- $ g++ RS_code.cpp
- $ ./a.out

# Answer
- CE_cnt: 1,000,000
- DUE_cnt: 0
- SDC_cnt: 0

If the result differs from these numbers, something is wrong. Please analyze the code!
You've coded incorrectly if you can't correct all one million random 1 symbol errors!
The answer code is in the Solution folder.

# Hint
- Consider the conditions the H-Matrix must meet for 1-bit error correction and 2-bit error detection.
- Also, because Hsiao code is hardware friendly, let's consider ways to minimize the depth of the 'xor' tree.
- While it is possible to implement SEC-DED with Hamming code, the goal is to understand hardware-friendly H-Matrix by implementing it with Hsiao code.
- ECC essentially begins with the design of the H-Matrix.
- Once you construct the H-Matrix, you can derive the corresponding G-Matrix (Generator Matrix).
- Hsiao SEC-DED code URL: https://people.eecs.berkeley.edu/~culler/cs252-s02/papers/hsiao70.pdf

# Additional Information
- CE: Correctable Error
- DUE: Detectable but Uncorrectable Error
- UCE: Un-Correctable Error
- In the codeword, an error is indicated by 1.
- Example) codeword: 0010000....00 => error occurred at the 3rd bit.
- In this problem, only 1-bit and 2-bit errors occur (each in 1000 iterations). Hence, 100% error correction/detection must be achieved.
- If UE_cnt>0, something is wrong, so try changing the H-Matrix!

# Reference
- **[1]** https://www.amd.com/system/files/TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf
- 




Code Description
This case only injects 1 symbol error.
Code configuration is set to match AMDCHIPKILL of DDR5. Each beat is configured as (32+8), and 2 beats are combined to form (64+16) using 8-bit symbols for RS-code.
Correction capability: SSC (Single Symbol Correction)

What needs to be done!!
****** Implementation of decoding function ******

Input: codeword

Function Content: Correct all 1 symbol errors in the codeword (based on 8-bit symbol)
