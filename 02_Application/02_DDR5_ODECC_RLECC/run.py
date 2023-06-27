from multiprocessing import Pool
import sys
import os
import time

oecc = [0, 1] # NO_OECC=0, OECC=1
recc = [0, 1] # NO_RECC=0, RECC=1

# SE: per-chip Single bit Error
# DE: per-chip Double bit Error
# CHIPKILL: Single Chip Error (Random Error for all 136 bit)

for oecc_param in oecc:
    for recc_param in recc:
        os.system("./Fault_sim_start {0:d} {1:d} &".format(oecc_param, recc_param))