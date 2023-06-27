# ECC-exercise

## Author

**Dongwhee Kim** 

- Email: xyz12347976@gmail.com
- Google Scholar: https://scholar.google.com/citations?user=8xzqA8YAAAAJ&hl=ko&oi=ao


I would like to express our gratitude to the people at SAL (Scalable Architecture Lab). 
This will be a great aid in your studies on ECC (Error Correcting Code). 
The methods were applied in the following papers [1-3] (the code can be found in the SAL repo), so we encourage you to read through the issues, study the papers, examine the experimental code, and consider constructing experimental methodologies based on them.

# [1] [ACCESS'22] SEC-BADAEC: An Efficient ECC With No Vacancy for Strong Memory Protection.
# [2] [ITC-CSCC'23] EPA ECC: Error-Pattern-Aligned ECC for HBM2E.
# [3] [SC'23] Unity ECC: Unified Memory Protection Against Bit and Chip Errors.


# Objective
- Construct (7,4) Hamming SEC (Single-Error Correction) code 
- Designing the H-Matrix (Parity Check Matrix) with the corresponding correction capability

# To do
- Construct H-Matrix.txt

# Answer
- CE_cnt : 1000
- UCE_cnt: 0

If the result differs from the above, please modify the H_Matrix.txt accordingly.

CE: Correctable Error
UCE: Un-Correctable Error

# Hint
- Let's consider the conditions the H-Matrix must meet for 1-bit error correction.
- ECC essentially begins with the design of the H-Matrix.
- Once you construct the H-Matrix, you can derive the corresponding G-Matrix (Generator Matrix)

# Additional Information
- In the codeword, an error is indicated by 1.
- Example) codeword: 0010000 => error occurred at the 3rd bit
- In this problem, only a 1-bit error occurs (in 1000 iterations).
- Hence, 100% error correction must be achieved. (If UCE_cnt>0, something is off, so try changing the H-Matrix!)
