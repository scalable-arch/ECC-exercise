debImport "-f" "/home/song/SMARTECC/BCH/DEC_15_7/RTL/sim/..//sim/tb/filelist.f" \
          "-f" "/home/song/SMARTECC/BCH/DEC_15_7/RTL/sim/..//rtl/filelist.f" \
          "-i" "simv"
srcTBInvokeSim
srcHBSelect "decoder_tb.decoder" -win $_nTrace1
srcSetScope "decoder_tb.decoder" -delim "." -win $_nTrace1
srcHBSelect "decoder_tb.decoder" -win $_nTrace1
srcHBSelect "decoder_tb.decoder.corrector" -win $_nTrace1
srcHBSelect "decoder_tb" -win $_nTrace1
schCreateWindow -delim "." -win $_nSchema1 -scope "decoder_tb.decoder"
schSelect -win $_nSchema3 -inst "detector"
schSelect -win $_nSchema3 -inst "corrector"
schSelect -win $_nSchema3 -inst "detector"
schPushViewIn -win $_nSchema3
schSelect -win $_nSchema3 -inst "syndromes"
schPushViewIn -win $_nSchema3
schSetOptions -win $_nSchema3 -detailRTL on
schSetOptions -win $_nSchema3 -localNetName on
schSetOptions -win $_nSchema3 -pinName on
verdiDockWidgetMaximize -dock windowDock_nSchema_3
schPopViewUp -win $_nSchema3
schZoomOut -win $_nSchema3 -pos 7256 3689
schZoomOut -win $_nSchema3 -pos 7247 3681
schZoomOut -win $_nSchema3 -pos 15065 5663
schZoomOut -win $_nSchema3 -pos 15064 5662
schZoomOut -win $_nSchema3 -pos 12429 4057
schZoomOut -win $_nSchema3 -pos 12409 4056
schZoomOut -win $_nSchema3 -pos 12408 4056
schZoomIn -win $_nSchema3 -pos 24730 2374
schZoomIn -win $_nSchema3 -pos 24730 2374
schZoomIn -win $_nSchema3 -pos 24730 2373
schPushViewIn -win $_nSchema3
schPopViewUp -win $_nSchema3
schPopViewUp -win $_nSchema3
schSelect -win $_nSchema3 -inst "corrector"
schSelect -win $_nSchema3 -inst "corrector"
schPushViewIn -win $_nSchema3
schZoomOut -win $_nSchema3 -pos 5163 2360
schZoomOut -win $_nSchema3 -pos 5163 2359
schZoomIn -win $_nSchema3 -pos 5287 2359
schSelect -win $_nSchema3 -inst "ibm"
schPushViewIn -win $_nSchema3
schZoomOut -win $_nSchema3 -pos 19520 31643
schZoomIn -win $_nSchema3 -pos 23607 31128
schZoomIn -win $_nSchema3 -pos 23703 31080
schPopViewUp -win $_nSchema3
schSelect -win $_nSchema3 -inst "ibm"
schPushViewIn -win $_nSchema3
schZoomOut -win $_nSchema3 -pos 9210 45793
schZoomIn -win $_nSchema3 -pos 455 48314
schZoomIn -win $_nSchema3 -pos 455 48315
schSelect -win $_nSchema3 -port "syndrome3\[3:0\]"
schSetOptions -win $_nSchema3 -completeName on
schDeselectAll -win $_nSchema3
schZoomOut -win $_nSchema3 -pos 3095 48016
schZoomIn -win $_nSchema3 -pos 3507 47760
schSelect -win $_nSchema3 -signal "syndrome2\[3:0\]"
schSelect -win $_nSchema3 -signal "nu2_1_x_syndrome2\[3:0\]"
schZoomOut -win $_nSchema3 -pos 44768 40190
schZoomOut -win $_nSchema3 -pos 44917 39921
schSelect -win $_nSchema3 -signal "syndrome2\[3:0\]"
schDeselectAll -win $_nSchema3
schSelect -win $_nSchema3 -signal "nu2_1_x_syndrome2\[3:0\]"
schSelect -win $_nSchema3 -signal "d2\[3:0\]"
schZoomIn -win $_nSchema3 -pos 79869 38036
schZoomIn -win $_nSchema3 -pos 79841 38036
schZoomIn -win $_nSchema3 -pos 79695 38120
schZoomIn -win $_nSchema3 -pos 79695 38120
schZoomOut -win $_nSchema3 -pos 78483 37788
schZoomOut -win $_nSchema3 -pos 78233 37685
schZoomOut -win $_nSchema3 -pos 76670 35649
schZoomOut -win $_nSchema3 -pos 76670 35649
schSelect -win $_nSchema3 -signal "d2_x_kappa2_0\[3:0\]"
schDeselectAll -win $_nSchema3
schSelect -win $_nSchema3 -signal "d2_x_kappa2_1\[3:0\]"
schZoomOut -win $_nSchema3 -pos 20041 37575
schZoomOut -win $_nSchema3 -pos 20041 37575
schZoomIn -win $_nSchema3 -pos 4917 38297
schZoomIn -win $_nSchema3 -pos 4816 38263
schZoomIn -win $_nSchema3 -pos 4715 38263
schZoomIn -win $_nSchema3 -pos 4714 38263
schZoomOut -win $_nSchema3 -pos 5679 38534
schZoomOut -win $_nSchema3 -pos 5680 38534
schZoomOut -win $_nSchema3 -pos 5680 38533
schZoomOut -win $_nSchema3 -pos 23413 38951
schZoomOut -win $_nSchema3 -pos 23343 38881
schZoomIn -win $_nSchema3 -pos 4624 40320
schZoomIn -win $_nSchema3 -pos 4233 40615
schDeselectAll -win $_nSchema3
schSelect -win $_nSchema3 -signal "syndrome3\[3:0\]"
schZoomOut -win $_nSchema3 -pos 17778 47328
schZoomOut -win $_nSchema3 -pos 17779 47297
schZoomIn -win $_nSchema3 -pos 28187 47450
schZoomIn -win $_nSchema3 -pos 28187 47450
schZoomIn -win $_nSchema3 -pos 28187 47449
schZoomIn -win $_nSchema3 -pos 28186 47449
schZoomOut -win $_nSchema3 -pos 28186 47448
schZoomOut -win $_nSchema3 -pos 28186 47447
schZoomOut -win $_nSchema3 -pos 28185 47448
schZoomOut -win $_nSchema3 -pos 23765 44699
schZoomIn -win $_nSchema3 -pos 27458 45380
schSelect -win $_nSchema3 -signal "syndrome1\[3:0\]"
schSelect -win $_nSchema3 -signal "syndrome1\[3:0\]"
schSelect -win $_nSchema3 -signal "nu0_0_x_syndrome1\[3:0\]"
schZoomOut -win $_nSchema3 -pos 10000 45224
schZoomIn -win $_nSchema3 -pos 9531 45389
schZoomIn -win $_nSchema3 -pos 9531 45410
schZoomOut -win $_nSchema3 -pos 9562 45425
schZoomOut -win $_nSchema3 -pos 9678 48319
schZoomIn -win $_nSchema3 -pos 9605 48002
schZoomIn -win $_nSchema3 -pos 9605 48056
schZoomOut -win $_nSchema3 -pos 9251 48234
schZoomOut -win $_nSchema3 -pos 9251 48234
schDeselectAll -win $_nSchema3
schSelect -win $_nSchema3 -signal "nu0_0_x_syndrome1\[3:0\]"
schSelect -win $_nSchema3 -signal "nu0_1\[3:0\]"
schSelect -win $_nSchema3 -signal "nu0_0_x_syndrome1\[3:0\]"
schSelect -win $_nSchema3 -signal "d0\[3:0\]"
schSelect -win $_nSchema3 -signal "d2_x_kappa2_0\[3:0\]"
schZoomIn -win $_nSchema3 -pos 76896 39452
schZoomIn -win $_nSchema3 -pos 76896 39452
schZoomOut -win $_nSchema3 -pos 76883 39427
schZoomOut -win $_nSchema3 -pos 67263 36726
schZoomOut -win $_nSchema3 -pos 67019 36556
schZoomOut -win $_nSchema3 -pos 66621 36437
schZoomOut -win $_nSchema3 -pos 66562 36496
schDeselectAll -win $_nSchema3
schSelect -win $_nSchema3 -port "locator0\[3:0\]"
schSelect -win $_nSchema3 -signal "delta0\[3:0\]"
schZoomOut -win $_nSchema3 -pos 38807 41202
schZoomOut -win $_nSchema3 -pos 38807 40741
schZoomOut -win $_nSchema3 -pos 39093 39591
schZoomOut -win $_nSchema3 -pos 39093 39447
schZoomIn -win $_nSchema3 -pos -8668 32526
schZoomIn -win $_nSchema3 -pos -8803 32526
schZoomIn -win $_nSchema3 -pos -9054 32424
schZoomIn -win $_nSchema3 -pos -9054 32424
schZoomIn -win $_nSchema3 -pos -9055 32424
schZoomOut -win $_nSchema3 -pos 37342 36010
schZoomOut -win $_nSchema3 -pos 37342 36010
schZoomOut -win $_nSchema3 -pos 37342 35610
schZoomOut -win $_nSchema3 -pos 37342 35485
debExit
