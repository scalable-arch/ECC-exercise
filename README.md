# ECC-ExerSim (Error-Correcting Code Exercise and Simulator)

# This project is licensed under the terms of the CERN-OHL-S-2.0

# Copyright (c) 2023
# SungKyunKwan University Research & Business Foundation
# All rights reserved.

## Author

**Dongwhee Kim** 
- [```Google Scholar```](https://scholar.google.com/citations?user=8xzqA8YAAAAJ&hl=ko&oi=ao)
- [```ORCiD```](https://orcid.org/0009-0007-1673-1931?fbclid=PAAabkpwNHesKweJ6F2eGZDnFa2sch2211hf6ZY825YKuli5V7lcN7VIfT0CA)
- [```LinkedIn```](https://www.linkedin.com/in/dongwhee-kim-5753a8290)

I would like to express my gratitude to the people at SAL (Scalable Architecture Lab)

This will greatly aid your studies on ECC (Error Correcting Code)

The methods were applied in the following papers **[1-7]** (the code can be found in the SAL repo), so I encourage you to read through the issues, study the papers, examine the experimental code, and consider constructing experimental methodologies based on them.

If you use 02_Application codes in your work, please use the following citation:
- MRSim

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div class="code-container">
        <pre><code id="codeToCopy">@inproceedings{kim2015bamboo,
  title={Bamboo ECC: Strong, safe, and flexible codes for reliable computer memory},
  author={Kim, Jungrae and Sullivan, Michael and Erez, Mattan},
  booktitle={2015 IEEE 21st International Symposium on High Performance Computer Architecture (HPCA)},
  pages={101--112},
  year={2015},
  organization={IEEE}
}
        </code></pre>
    </div>
</body>
</html>

- DDR5_ODECC_RLECC

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div class="code-container">
        <pre><code id="codeToCopy">@inproceedings{kim2023unity,
          title={Unity ECC: Unified Memory Protection Against Bit and Chip Errors},
          author={Kim, Dongwhee and Lee, Jaeyoon and Jung, Wonyeong and Sullivan, Michael B and Kim, Jungrae},
          booktitle={SC23: International Conference for High Performance Computing, Networking, Storage and Analysis},
          pages={1--16},
          year={2023},
          organization={IEEE}
          }
        </code></pre>
    </div>
</body>
</html>

# 01_Basic
- Basic ECC (Error Correcting Codes)
- Contents: Hamming code, Hsiao code, CRC (Cyclic Redundancy Check) code, RS (Reed-Solomon) code, etc

# 02_Application
- Application for DRAM & sub-systems
- ECC types: On-Die ECC & Rank-Level ECC
- Target DRAM: DDR4, DDR5

# 03_Synthesis (Verilog)
- 01_136_128_SEC: (136, 128) SEC code **[4]**
- 02_104_06_SEC_DED: (104, 96) SEC-DED code **[6]**
- 03_136_128_SEC_BADAEC: (136, 128) SEC-BADAEC code **[4]**
- 04_10_8_RS_SSC: (10, 8) RS SSC (Single Symbol Correcting) code over GF(256) **[7]**
- 05_39_36_RS_SSC_DSD: (39, 36) RS SSC-DSD (Singl Symbol Correcting Double Symbol Detecting) code over GF(256) **[6]**
- 06_15_7_BCH_DEC: (15, 7) BCH DEC (Double Error Correcting) code
- 07_542_512_BCH_TEC: (542, 512) BCH TEC (Triple Error Correcting) code

# [AMD'13] DRAM Fault.pdf **[8]**
- Background of DRAM Fault handling
- Architecture & micro-architectural approaches to reliability
- Focuses on fault modeling in DRAM

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
- **[8]** SRIDHARAN, VILAS. "DRAM Faults: Data from the Field." (2013).
