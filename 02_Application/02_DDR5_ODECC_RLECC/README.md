# DDR5 On-Die ECC & Rank-Level ECC

# Author

**Dongwhee Kim** 
- Email: xyz12347976@gmail.com
- Google Scholar: https://scholar.google.com/citations?user=8xzqA8YAAAAJ&hl=ko&oi=ao

# Objectives
- Implement **On-Die ECC (OD-ECC) [1-2]** and **Rank-Level ECC (RL-ECC)** of DDR5 ECC-DIMM
- Understand the ECC scheme to improve reliability
- The above method has been used for several papers **[3-5]**
- **I encourage you to implement the Rank-Level ECC (RL-ECC) freely**
- **This assignment is designed to be open-ended, so don't be afraid to be innovative and creative with your approach**

# Overview
![An Overview of the exercise](https://github.com/xyz123479/ECC-exercise/blob/main/02_Application/02_DDR5_ODECC_RLECC/DDR5%20OD-ECC%20%26%20RL-ECC.png)

# PREREQUIREMENTS
- You need to read the Fault-sim (TACO'15) paper **[2]**
- This exercise applied the **Fault-masking** method from this paper, and the code is written in a simpler manner

# Code flows (Fault_sim.cpp)
- 1. **(Start loop)** We calculate the future time point when the fault is expected to occur by inputting the FIT value [6] into the Poisson function. (Tester.cc -> TesterSystem::advance)
- 2. If the expected time point is after the interval used for reliability measurement, we bypass the fault-masking and return to step '1'.
- 3. For instance, in this exercise, the reliability measurement period is 5 years. If the fault occurs 10 years later, we skip the fault-masking process.
- 4. Scrub the soft error.
- 5. If the time point falls within the reliability measurement interval, we apply fault-masking and record that time. (Tester.cc -> hr += advance(dg->getFaultRate());)
- 6. Generate a fault.
- 7. Based on the fault, generate an error and proceed with decoding using Rank-Level ECC. (This is the part we need to handle)
- 8. **(End loop)** Record the results of Retire, DUE, and SDC, and go back to step 1 to repeat a certain number of times.
- 9. This exercise is repeated 10,000 times. For actual experiments, it is recommended to do it more than 1,000,000 times to ensure reliability.

# DIMM configuration (per-sub channel)
- DDR5 ECC-DIMM
- Num of rank: 1
- Beat length: 40 bit
- Burst length: 16
- Num of data chips: 8
- Num of parity chips: 2
- Num of DQ: 4 (x4 chip)

# ECC configuration
- OD-ECC: (136, 128) Hamming SEC code **[1]**
- RL-ECC: (80,64) ECC **(configure freely)**
>> Ex) BCH (Bose–Chaudhuri–Hocquenghem) code, CRC code, RS (Reed-Solomon) code, Unity ECC (SC'23) **[5]** 

# Error pattern configuration
- SE(SBE): per-chip Single Bit Error
- DE(DBE): per-chip Double Bit Error
- CHIPKILL(SCE): Single Chip Error (All Random)

# Error Scenario configuration
- SE(SBE): Among 10 chips, there's a single bit error (SE[Single Bit Error]) occurring in just one chip, with the remaining 9 chips having no errors
- DE(DBE): Among 10 chips, there's a double bit error (DE[Double Bit Error]) occurring in just one chip, with the remaining 9 chips having no errors
- CHIPKILL(SCE): Among 10 chips, there's a random error (SCE [Single Chip Error]) occurring in just one chip, with the remaining 9 chips having no errors. Errors can occur up to a maximum of 136 bits
- SE(SBE)+SE(SBE): Among 10 chips, there's a single bit error (SE[Single Bit Error]) occurring in each of two chips, with the remaining 8 chips having no errors

# To do
- Fill in the **hsiao.cc**
- You just need to fill in 2 parts labeled "Fill your code here!!"
- Generate H-matrix.
- Determine whether there is an error ((H * cT) = 0 judgment).
- If there's an error, decode it.

# Getting Started
- $ make clean
- $ make
- $ python run.py

# Answer (.S files)
Runtime : 1000000
CE : 0.02557000000
DUE : 0.00000000000
SDC : 0.97443000000

The above answer serves as an example for OECC_OFF_RECC_OFF.S

**Errors can be injected randomly, thus there may be slight discrepancies each time it is executed**

The procedure involves injecting errors a million times to illustrate the probabilities of CE, DUE, and SDC occurrences

A high CE and a low SDC are desirable

Strive to achieve a CE of 1.000000000 (100% error correction) as exhibited in **OECC_ON_RECC_ON.S**

However, if a CE of 100% is not attainable, the primary objective should be to reduce the SDC

In such cases, employing the CRC code could be a beneficial method

# Hint
- Consider the conditions the H-Matrix must meet for 1-bit error correction and 2-bit error detection **[1]**.
- Shortened code
- Ex) (255, 239) BCH DEC (Double Error Correcting) code -> (144, 128) BCH DEC code -> (80,64) BCH DEC code
  
# Additional Information
- NE: no error
- CE: detected and corrected error
- DUE: detected but uncorrected error
- SDC: Silent Data Corruption
- Only single chip correction is possible
>> Only SEC (Single Error Correction) within the chip is possible
>> 
>> There are 4 bits per chip
>> 
>> There are no errors if all are 0
>> 
>> Some erroneous values like 2, F, A are deliberately placed in some values
>> 
>> If it's 2 (0010), it's a 1 bit error and correction is possible
>> 
>> If it's A (1010), it's a 2 bit error and correction is not possible

- The index is from the right end, 0, 1, 2 ... (same as Verilog)
- If you output the burst, it's 7, 6, ... 0 from the top, a total of 8 (burst length)


# References
- **[1]** Hamming, Richard W. "Error detecting and error correcting codes." The Bell system technical journal 29.2 (1950): 147-160.
- **[2]** M. JEDEC. 2022. DDR5 SDRAM standard, JESD79-5B𝑣 1.20.
- **[3]** Song, Yuseok, et al. "SEC-BADAEC: An Efficient ECC With No Vacancy for Strong Memory Protection." IEEE Access 10 (2022): 89769-89780.
- **[4]** Kwon, Kiheon, et al. "EPA ECC: Error-Pattern-Aligned ECC for HBM2E." 2023 38th International Technical Conference on Circuits/Systems, Computers and Communications (ITC-CSCC). IEEE, 2023.
- **[5]** Kim, Dongwhee, et al. "Unity ECC: Unified Memory Protection for Bit and Chip Errors." Proceedings of the International Conference for High Performance Computing, Networking, Storage and Analysis. 2023.

