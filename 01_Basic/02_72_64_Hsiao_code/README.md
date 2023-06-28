# [72, 64] SEC-DED code - Hsiao

# Author

**Dongwhee Kim** 

- Email: xyz12347976@gmail.com
- Google Scholar: https://scholar.google.com/citations?user=8xzqA8YAAAAJ&hl=ko&oi=ao

# Objectives
- Implement (72,64) Hsiao SEC-DED (Single-Error Correction) code **[1]**
- Design an H-Matrix (Parity Check Matrix) with the corresponding correction capability
- Design a hardware-friendly H-Matrix
- Design a Systematic code. (Advantage: Simplicity, Efficiency)

# Overview
![An Overview of the exercise](https://github.com/xyz123479/ECC-exercise/blob/main/01_Basic/02_72_64_Hsiao_code/%5B72%2C%2064%5D%20Hsiao%20code.png)

# To do
- Construct H-Matrix.txt

# Getting Started
- $ python Hsiao_SEC_DED.py

# Answer
- CE_cnt : 1000
- DUE_cnt : 1000
- UCE_cnt: 0

If the results differ from the above, please modify the H_Matrix.txt.

# Hint
- Consider the conditions the H-Matrix must meet for 1-bit error correction and 2-bit error detection.
- Also, because Hsiao code is hardware friendly, let's consider ways to minimize the depth of the 'xor' tree.
- While it is possible to implement SEC-DED with Hamming code, the goal is to understand hardware-friendly H-Matrix by implementing it with Hsiao code.
- ECC essentially begins with the design of the H-Matrix.
- Once you construct the H-Matrix, you can derive the corresponding G-Matrix (Generator Matrix).

# Additional Information
- CE: Correctable Error
- DUE: Detectable but Uncorrectable Error
- UCE: Un-Correctable Error
- In the codeword, an error is indicated by 1.
- Example) codeword: 0010000....00 => error occurred at the 3rd bit.
- In this problem, only 1-bit and 2-bit errors occur (each in 1000 iterations). Hence, 100% error correction/detection must be achieved.
- If UE_cnt>0, something is wrong, so try changing the H-Matrix!

# References
- **[1]** Hsiao, Mu-Yue. "A class of optimal minimum odd-weight-column SEC-DED codes." IBM Journal of Research and Development 14.4 (1970): 395-401.
