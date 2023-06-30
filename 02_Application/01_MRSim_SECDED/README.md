# Fault model & Rank-Level ECC of DDR4

# Author

**Prof. Jungrae Kim** 
- Email: dale40@gmail.com
- Google Scholar: https://scholar.google.com/citations?user=Jbpv5q0AAAAJ&hl=ko&oi=ao

# Objectives
- Implement **Rank-Level ECC (RL-ECC)** of DDR4 ECC-DIMM
- Understand the method of constructing fault model simulation **[2]**
- The above method has been used for several papers **[3-5]**

# Prerequisite
- You need to read the Fault-sim (TACO'15) paper **[2]**
- This exercise applied the **Fault-masking** method from this paper, and the code is written in a simpler manner

# Overview
![An Overview of the exercise](https://github.com/xyz123479/ECC-exercise/blob/main/02_Application/01_MRSim_SECDED/MRSim-Fault%20model.png)

# Code flows (main.cc, Tester.cc)
- 1. **(Start loop)** Calculate the future time point when the fault is expected to occur by inputting the FIT value [6] into the Poisson function. (Tester.cc -> TesterSystem::advance)
- 2. If the expected time point is after the interval used for reliability measurement, we bypass the fault-masking and return to step '1'.
- 3. For instance, in this exercise, the reliability measurement period is 5 years. If the fault occurs 10 years later, we skip the fault-masking process.
- 4. Scrub the soft error.
- 5. If the time point falls within the reliability measurement interval, we apply fault-masking and record that time. (Tester.cc -> hr += advance(dg->getFaultRate());)
- 6. Generate a fault.
- 7. **(Fill in the code)** Based on the fault, generate an error and proceed with decoding using **Rank-Level ECC**.
- 8. **(End loop)** Record the results of Retire, DUE, and SDC, and go back to step 1 to repeat a certain number of times.
- 9. This exercise is repeated 10,000 times. For actual experiments, it is recommended to do it more than 1,000,000 times to ensure reliability.

# DIMM configuration (main.cc, Config.hh)
- DDR4 ECC-DIMM
- Num of rank: 2
- Beat length: 72 bit
- Burst length: 8
- Num of data chips: 16
- Num of parity chips: 2
- Chip capacity: 8Gb
- Num of DQ: 4 (x4 chip)

# ECC configuration
- RL-ECC: (72,64) Hsiao SEC-DED code **[1]**

# Fault model configuration (FaultRateInfo.hh)
- **[6]** DDR2 Jaguar system

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

# Answer (010.4x18.SECDED.0.S)
After 100 runs

Retire

0.00000000000

0.00000000000

0.00000000000

0.00000000000

0.00000000000

DUE

0.01000000000

0.02000000000

0.02000000000

0.04000000000

0.05000000000

SDC

0.00000000000

0.00000000000

0.00000000000

0.00000000000

0.00000000000

After 10000 runs

Retire

0.00000000000

0.00000000000

0.00000000000

0.00000000000

0.00000000000

DUE

0.01230000000

0.02430000000

0.03520000000

0.04880000000

0.06110000000

SDC

0.00010000000

0.00020000000

0.00030000000

0.00050000000

0.00060000000

If the results differ from the above, your code might be wrong.

- Retire, DUE and SDC are the probabilities of Retire, DUE, and SDC occurring when run 100 times and 10000 times, respectively. (0~1)
- The Retire, DUE, SDC probability occurring each year -> **cumulative**.
- Ex)

0.01230000000 -> After 1 year
  
0.02430000000 -> After 2 years

0.03520000000 -> After 3 years

0.04880000000 -> After 4 years

0.06110000000 -> After 5 years

# Hint
- Consider the conditions the H-Matrix must meet for 1-bit error correction and 2-bit error detection **[1]**.

# Additional Information
- NE: no error
- CE: detected and corrected error
- DUE: detected but uncorrected error
- ME: detected but miscorrected error
- UE: undetected error
- SDC (Silent Data Corruption): ME + UE
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
- **[1]** Hsiao, Mu-Yue. "A class of optimal minimum odd-weight-column SEC-DED codes." IBM Journal of Research and Development 14.4 (1970): 395-401.
- **[2]** Nair, Prashant J., David A. Roberts, and Moinuddin K. Qureshi. "Faultsim: A fast, configurable memory-reliability simulator for conventional and 3d-stacked systems." ACM Transactions on Architecture and Code Optimization (TACO) 12.4 (2015): 1-24.
- **[3]** Kim, Jungrae, Michael Sullivan, and Mattan Erez. "Bamboo ECC: Strong, safe, and flexible codes for reliable computer memory." 2015 IEEE 21st International Symposium on High Performance Computer Architecture (HPCA). IEEE, 2015.
- **[4]** Gong, Seong-Lyong, et al. "Duo: Exposing on-chip redundancy to rank-level ecc for high reliability." 2018 IEEE International Symposium on High Performance Computer Architecture (HPCA). IEEE, 2018.
- **[5]** Park, Sangjae, and Jungrae Kim. "On-Die Dynamic Remapping Cache: Strong and Independent Protection Against Intermittent Faults." IEEE Access 10 (2022): 78970-78982.
- **[6]** Sridharan, Vilas, and Dean Liberty. "A study of DRAM failures in the field." SC'12: Proceedings of the International Conference on High Performance Computing, Networking, Storage and Analysis. IEEE, 2012.
