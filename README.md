# ECC-exercise

## Author

**Dongwhee Kim** 

- Email: xyz12347976@gmail.com
- Google Scholar: https://scholar.google.com/citations?user=8xzqA8YAAAAJ&hl=ko&oi=ao

I would like to express my gratitude to the people at SAL (Scalable Architecture Lab)

This will greatly aid your studies on ECC (Error Correcting Code)

The methods were applied in the following papers **[1-7]** (the code can be found in the SAL repo), so I encourage you to read through the issues, study the papers, examine the experimental code, and consider constructing experimental methodologies based on them.

# 01_Basic
- Basic ECC (Error Correcting Codes)
- Contents: Hamming code, Hsiao code, CRC (Cyclic Redundancy Check) code, RS (Reed-Solomon) code, etc

# 02_Application
- Application for DRAM & sub-systems
- ECC types: On-Die ECC & Rank-Level ECC
- Target DRAM: DDR4, DDR5

# Synthesis (Verilog)
- 01_136_128_SEC: (136, 128) SEC code **[4]**
- 02_104_06_SEC_DED: (104, 96) SEC-DED code **[6]**
- 03_136_128_SEC_BADAEC: (136, 128) SEC-BADAEC code **[4]**
- 04_10_8_RS_SSC: (10, 8) RS SSC (Single Symbol Correcting) code over GF(256) **[7]**
- 05_39_36_RS_SSC_DSD: (39, 36) RS SSC-DSD (Singl Symbol Correcting Double Symbol Detecting) code over GF(256) **[6]**
- SQUID: Reed-Solomon code (Double Symbol Correction using Berlekamp–Massey algorithm)

# Other useful sites
- https://en.lntwww.de/Category:Channel_Coding:_Exercises

# Reference
- **[1]** Kim, Jungrae, et al. "Frugal ecc: Efficient and versatile memory error protection through fine-grained compression." Proceedings of the International Conference for High Performance Computing, Networking, Storage and Analysis. 2015.
- **[2]** Kim, Jungrae, Michael Sullivan, and Mattan Erez. "Bamboo ECC: Strong, safe, and flexible codes for reliable computer memory." 2015 IEEE 21st International Symposium on High Performance Computer Architecture (HPCA). IEEE, 2015.
- **[3]** Gong, Seong-Lyong, et al. "Duo: Exposing on-chip redundancy to rank-level ecc for high reliability." 2018 IEEE International Symposium on High Performance Computer Architecture (HPCA). IEEE, 2018.
- **[4]** Song, Yuseok, et al. "SEC-BADAEC: An Efficient ECC With No Vacancy for Strong Memory Protection." IEEE Access 10 (2022): 89769-89780.
- **[5]** Park, Sangjae, and Jungrae Kim. "On-Die Dynamic Remapping Cache: Strong and Independent Protection Against Intermittent Faults." IEEE Access 10 (2022): 78970-78982.
- **[6]** Kwon, Kiheon, et al. "EPA ECC: Error-Pattern-Aligned ECC for HBM2E." 2023 38th International Technical Conference on Circuits/Systems, Computers and Communications (ITC-CSCC). IEEE, 2023.
- **[7]** Kim, Dongwhee, et al. "Unity ECC: Unified Memory Protection Against Bit and Chip Errors." Proceedings of the International Conference for High Performance Computing, Networking, Storage and Analysis. 2023.

