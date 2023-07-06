# Error Scenario & On-Die ECC & Rank-Level ECC of DDR5

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

# Code flows (Fault_sim.cpp)
- 1. Reading OD-ECC, RL-ECC H-Matrix.txt: It's fine not to use RL-ECC H-Matrix.txt.
- 2. Setting output function name: output.S file.
- 3. **(Start loop)** DDR5 ECC-DIMM setup
- 4. Initialize all data in 10 chips to 0: Each chip has 136 bits of data + redundancy.
- 5. Error injection: Errors occur based on the following probabilities:
>> SE: 40%, DE: 30%, SCE: 14%, SE+SE: 16%
- 6. **(Fill in the code)** Apply OD-ECC: Implementation
>> Apply the Hamming SEC code of (136, 128) to each chip.

>> After running OD-ECC, the redundancy of OD-ECC does not come out of the chip (128bit data).
- 7. **(Fill in the code)** Apply RL-ECC
>> Run (80, 64) RL-ECC by bundling two beats.
>> Please feel free to use any ECC code.
>> 16 Burst Length (BL) creates one memory transfer block (64B cacheline + 16B redundancy).
>> In DDR5 x4 DRAM, because of internal prefetching, only 64bit of data from each chip's 128bit data is actually transferred to the cache.
>> For this, create two memory transfer blocks for 128-bit data and compare them.
- 8. Report CE/DUE/SDC results.
- 9. **(End loop)** Derive final results.

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
>> Ex) CRC (Cyclic Redundancy Check) code, BCH (Bose–Chaudhuri–Hocquenghem) code, RS (Reed-Solomon) code, Unity ECC (SC'23) **[5]** 

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
- Fill in the **error_correction_oecc, error_correction_recc** function
- You just need to fill in 2 parts labeled "Fill your code here!!"
- Function input: codeword (136bit for OD-ECC, 80bit for RL-ECC)
- Function content: Execute ECC on the codeword to implement error detection or correction of the codeword
- Function output: Return error information (NE/CE/DUE)

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
- Consider the conditions the H-Matrix must meet for 1-bit error correction and 2-bit error detection **[1]**
- The codeword is in the default all-zero state (No-error state). In other words, the original message is all-zero
- Thus, **you only need to create a decoding function**; there's no need to encode
- Reason: Because it's a Linear code, the same syndrome appears regardless of 1->0 or 0->1 error at the same location.
- Shortened code
- Ex) (255, 253) RS SSC (Single Symbol Correcting) code over GF(256) -> (10,8) RS SSC code over GF(256)
  
# Additional Information
- NE: no error
- CE: detected and corrected error
- DUE: detected but uncorrected error
- SDC: Silent Data Corruption
- You are free to modify the H_Matrix_OECC.txt and H_Matrix_RECC.txt files
- Solution file: Chipkill-correct ECC (using RS code)
- Unity ECC **[5]** can correct all the error scenarios mentioned in this exercise using only RL-ECC, without the need for OD-ECC

# References
- **[1]** Hamming, Richard W. "Error detecting and error correcting codes." The Bell system technical journal 29.2 (1950): 147-160.
- **[2]** M. JEDEC. 2022. DDR5 SDRAM standard, JESD79-5B𝑣 1.20.
- **[3]** Song, Yuseok, et al. "SEC-BADAEC: An Efficient ECC With No Vacancy for Strong Memory Protection." IEEE Access 10 (2022): 89769-89780.
- **[4]** Kwon, Kiheon, et al. "EPA ECC: Error-Pattern-Aligned ECC for HBM2E." 2023 38th International Technical Conference on Circuits/Systems, Computers and Communications (ITC-CSCC). IEEE, 2023.
- **[5]** Kim, Dongwhee, et al. "Unity ECC: Unified Memory Protection Against Bit and Chip Errors." Proceedings of the International Conference for High Performance Computing, Networking, Storage and Analysis. 2023.

