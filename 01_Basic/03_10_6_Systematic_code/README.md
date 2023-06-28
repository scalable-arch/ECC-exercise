# [10, 6] Systematic code

# Author

**Taewon Park** 

- Email: pdtowctor@gmail.com

# Objectives
- Implement (10, 6) SEC-DADAEC (Single Error Correcting-Double bit Aligned Double Adjacent Error Correcting) code
- Design an H-Matrix (Parity Check Matrix) with the corresponding correction capability
- Design a Systematic code. (Advantage: Simplicity, Efficiency)

# Overview
![An Overview of the exercise](https://github.com/xyz123479/ECC-exercise/blob/main/01_Basic/03_10_6_Systematic_code/%5B10%2C%206%5D%20Systematic%20code.PNG)

# To do
- Fill the code.py

# Getting Started
- $ python main.py
- The example of execution can be found at **'ECC 1st homework.pdf'**.

# Answer
- Your code passes all the test cases!!

If the results differ from the above, please modify the code.py.

# Hint
- Let's consider the conditions the H-Matrix must meet for 1-bit error correction and 2-bit error detection.
- Also, because Hsiao code is hardware friendly, let's consider ways to minimize the depth of the 'xor' tree.
- While it is possible to implement SEC-DED with Hamming code, the goal is to understand hardware-friendly H-Matrix by implementing it with Hsiao code.
- ECC essentially begins with the design of the H-Matrix.
- Once you construct the H-Matrix, you can derive the corresponding G-Matrix (Generator Matrix).

# Additional Information
- In the codeword, an error is indicated by 1.
- Example) codeword: 0010000....00 => error occurred at the 3rd bit.
- In this problem, only 1-bit and 2-bit errors occur (each in 1000 iterations). Hence, 100% error correction/detection must be achieved.
- If UE_cnt>0, something is off, so try changing the H-Matrix!

