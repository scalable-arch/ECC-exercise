import sys
import os
import time

runNum=10000 # 실행 횟수

os.system("./test.out 0 {0:d} 0 S &".format(runNum)) # 0 : SEC-DED 사용, 10000 : 실행 횟수, 0 : module 설정 (DDR4, channel 크기 등등....)