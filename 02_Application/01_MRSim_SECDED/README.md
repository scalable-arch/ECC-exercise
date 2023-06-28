# DDR4 Fault model & Rank-Level ECC

# Author

**Jungrae Kim** 
- Email: dale40@gmail.com
- Google Scholar: https://scholar.google.com/citations?user=Jbpv5q0AAAAJ&hl=ko&oi=ao

# Objectives
- Implement **Rank-Level ECC (RL-ECC)** of DDR4 ECC-DIMM
- 
- Understand the construction of the fault model **[3]**

# Overview
![An Overview of the exercise](https://github.com/xyz123479/ECC-exercise/blob/main/02_Application/01_MRSim_SECDED/MRSim-Fault%20model.png)

# DIMM configuration (Config.hh)
- DDR4 ECC-DIMM
- Num of rank: 2
- Num of data chips: 16
- Num of parity chips: 2
- Chip capacity: 8Gb
- Num of DQ: 4 (x4 chip)

# ECC configuration
- RL-ECC of this exercise: (72,64) Hsiao SEC-DED code **[1]**

# Fault model configuration (FaultRateInfo.hh)
- **[3]** DDR2 Jaguar system

# To do
- Fill in the **hsiao.cc**
- You just need to fill in 2 parts labeled "Fill your code here!!"

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

# Hint
- Consider the conditions the H-Matrix must meet for 1-bit error correction and 2-bit error detection.
- Also, because Hsiao code is hardware friendly, consider ways to minimize the depth of the 'xor' tree.

# Additional Information
- CE: Correctable Error
- DUE: Detectable but Uncorrectable Error
- SDC: Silent-Data Corruption
- In this problem, only 1-bit and 2-bit errors occur (each in 1000 iterations). Hence, 100% error correction/detection must be achieved.
- If UE_cnt>0, something is wrong, so try changing the H-Matrix!

# References
- **[1]** Hsiao, Mu-Yue. "A class of optimal minimum odd-weight-column SEC-DED codes." IBM Journal of Research and Development 14.4 (1970): 395-401.
- **[2]** Nair, Prashant J., David A. Roberts, and Moinuddin K. Qureshi. "Faultsim: A fast, configurable memory-reliability simulator for conventional and 3d-stacked systems." ACM Transactions on Architecture and Code Optimization (TACO) 12.4 (2015): 1-24.
- **[3]** Sridharan, Vilas, and Dean Liberty. "A study of DRAM failures in the field." SC'12: Proceedings of the International Conference on High Performance Computing, Networking, Storage and Analysis. IEEE, 2012.
