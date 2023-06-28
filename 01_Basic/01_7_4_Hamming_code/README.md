# [7, 4] Hamming code

# Author

**Dongwhee Kim** 

- Email: xyz12347976@gmail.com
- Google Scholar: https://scholar.google.com/citations?user=8xzqA8YAAAAJ&hl=ko&oi=ao

# Objective
- Construct (7,4) Hamming SEC (Single-Error Correction) code 
- Design the H-Matrix (Parity Check Matrix) with the corresponding correction capability

# Overview
![Hamming code](H)

# To do
- Construct H-Matrix.txt

# Getting Started
- python Hamming_SEC.py

# Answer
- CE_cnt : 1000
- UCE_cnt: 0

If the result differs from the above, please modify the H_Matrix.txt accordingly.

CE: Correctable Error
UCE: Un-Correctable Error

# Hint
- Let's consider the conditions the H-Matrix must meet for 1-bit error correction.

# Additional Information
- In the codeword, an error is indicated by 1.
- Example) codeword: 0010000 => error occurred at the 3rd bit
- In this problem, only a 1-bit error occurs (in 1000 iterations).
- Hence, 100% error correction must be achieved. (If UCE_cnt>0, something is off, so try changing the H-Matrix!)
- ECC essentially begins with the design of the H-Matrix.
- Once you construct the H-Matrix, you can derive the corresponding G-Matrix (Generator Matrix)
