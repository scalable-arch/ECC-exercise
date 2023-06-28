# CRC (Cyclic Redundancy Check) code

# Author

**Taewon Park** 

- Email: pdtowctor@gmail.com

# Objectives
- Check the error detection capability of CRC.

# Overview
![An Overview of the exercise](https://github.com/xyz123479/ECC-exercise/blob/main/01_Basic/03_10_6_Systematic_code/%5B10%2C%206%5D%20Systematic%20code.PNG)

# To do
- Fill in the crc.py
- 1st function: encode
- 2nd function: get_period
- 3rd function: monte_carlo_sim
- 4th function: decode

# Getting Started
- $ python main.py
- The example of execution can be found at **'ECC 2nd homework.pdf'**.

# Answer
- Odd error(s) 100% Detection
- Double error(s) 100% Detection
- Burst error(s) (length < n-k+1) 100% Detection
- Burst error(s) (length = n-k+1) 92~94% Detection
- Burst error(s) (length > n-k+1) 95~98% Detection

If the results differ from the above, please modify the crc.py

# Hint
- Modular-2 operation
- CRC code URL: https://ieeexplore.ieee.org/abstract/document/4066263
