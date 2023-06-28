# [10, 6] Systematic code

# Author

**Taewon Park** 

- Email: pdtowctor@gmail.com

# Objectives
- Implement (10, 6) SEC-DADAEC (Single Error Correcting-Double bit Aligned Double Adjacent Error Correcting) code
- Design an encode and decode the function of the SEC-DADAEC code
- Design a Systematic code. (Advantage: Simplicity, Efficiency)

# Overview
![An Overview of the exercise](https://github.com/xyz123479/ECC-exercise/blob/main/01_Basic/03_10_6_Systematic_code/%5B10%2C%206%5D%20Systematic%20code.PNG)

# To do
- Fill in the code.py
- 1st step: encode
- 2nd step: decode

# Getting Started
- $ python main.py
- The example of execution can be found at **'ECC 1st homework.pdf'**.

# Answer
- Your code passes all the test cases!!

If the results differ from the above, please modify the code.py.

# Hint
- Consider the conditions the H-Matrix must meet for 1-bit error correction and 2-bit aligned double adjacent error correction.
- All columns of H-Matrix should be unique.
- Modify from the [10, 6] shortened Hamming code **[1]**.
- Understand the code construction method of **[2]**.

# References
- **[1]** Hamming, Richard W. "Error detecting and error correcting codes." The Bell system technical journal 29.2 (1950): 147-160.
- **[2]** Dutta, Avijit, and Nur A. Touba. "Multiple bit upset tolerant memory using a selective cycle avoidance based SEC-DED-DAEC code." 25th IEEE VLSI Test Symposium (VTS'07). IEEE, 2007.
