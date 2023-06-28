# Transformation from H-Matrix to G-Matrix

# Author

**Dongwhee Kim** 

- Email: xyz12347976@gmail.com
- Google Scholar: https://scholar.google.com/citations?user=8xzqA8YAAAAJ&hl=ko&oi=ao

# Objectives
- Understand the transformation process from H-Matrix to G-Matrix.
- Both systematic and non-systematic code.
- H-Matrix.txt as input and generates the corresponding G-Matrix.txt
- I recommend outputting the entire process of H to G-Matrix conversion.


# Overview
![An Overview of the exercise](https://github.com/xyz123479/ECC-exercise/blob/main/01_Basic/02_72_64_Hsiao_code/%5B72%2C%2064%5D%20Hsiao%20code.png)

# To do
- Fill the Matrix_transformation.py code

# Getting Started
- $ python Matrix_transformation.py

# Answer
- Answer folder

# Hint
- Consider the conditions the H-Matrix must meet for 1-bit error correction and 2-bit error detection.
- Also, because Hsiao code is hardware friendly, let's consider ways to minimize the depth of the 'xor' tree.
- While it is possible to implement SEC-DED with Hamming code, the goal is to understand hardware-friendly H-Matrix by implementing it with Hsiao code.
- ECC essentially begins with the design of the H-Matrix.
- Once you construct the H-Matrix, you can derive the corresponding G-Matrix (Generator Matrix).
- Hsiao SEC-DED code URL: https://people.eecs.berkeley.edu/~culler/cs252-s02/papers/hsiao70.pdf

# Additional Information
- In the codeword, an error is indicated by 1.
- Example) codeword: 0010000....00 => error occurred at the 3rd bit.
- In this problem, only 1-bit and 2-bit errors occur (each in 1000 iterations). Hence, 100% error correction/detection must be achieved.
- If UE_cnt>0, something is wrong, so try changing the H-Matrix!
