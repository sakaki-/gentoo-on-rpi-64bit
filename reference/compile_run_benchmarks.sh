#!/bin/bash
#
# Compile and run various benchmarks for RPi3/ARMv8
#
# Download http://www.roylongbottom.org.uk/Raspberry_Pi_Benchmarks.zip
# unzip, and enter the "Source Code" directory
#
# Can be run as regular, non-root user
# You should probably run this on a text console, and ensure that
# there is no desktop running (sudo service xdm stop), and that you
# have the CPU frequency scaling governor set to "performance"
# (sudo echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
#
# Benchmark results are saved to to text files (Dhry.txt etc.)
#
# Copyright (c) 2017 sakaki <sakaki@deciban.com>
# License: GPL 3.0+
# NO WARRANTY

set -e
set -u

echo "Deleting old binaries and result files..."
rm -f Dhry.txt whets.txt LLloops.txt LinpackDP.txt LinpackNEONSP.txt \
      LinpackSP.txt Linpack.txt
rm -f dhrystonePiA8 whetstonePiA8 liverloopsPiA8 linpackPiA8 \
      linpackPiA8SP linpackPiA8FSSP

echo "Compiling tests..."
gcc -lm -lrt -march=armv8-a+crc -mtune=cortex-a53 -O3 -pipe \
    -o whetstonePiA8 whets.c cpuidc.c
gcc -lm -lrt -march=armv8-a+crc -mtune=cortex-a53 -O3 -pipe \
    -o dhrystonePiA8 dhry_1.c dhry_2.c cpuidc.c
gcc -lm -lrt -march=armv8-a+crc -mtune=cortex-a53 -O3 -pipe \
    -o liverloopsPiA8 lloops2.c cpuidc.c
gcc -lm -lrt -march=armv8-a+crc -mtune=cortex-a53 -O3 -pipe \
    -o linpackPiA8 linpack.c cpuidc.c
gcc -lm -lrt -march=armv8-a+crc -mtune=cortex-a53 -O3 -pipe \
    -o linpackPiA8SP linpacksp.c cpuidc.c
gcc -lm -lrt -march=armv8-a+crc -mtune=cortex-a53 -O3 -pipe \
    -funsafe-math-optimizations -o linpackPiA8FSSP linpacksp.c cpuidc.c

echo "Compiled - running tests - press <Enter> at end of each"
echo "to move to next"

./whetstonePiA8
./dhrystonePiA8
./liverloopsPiA8
./linpackPiA8
mv -v Linpack.txt LinpackDP.txt
./linpackPiA8FSSP
mv -v Linpack.txt LinpackNEONSP.txt
./linpackPiA8SP
mv -v Linpack.txt LinpackSP.txt

echo ""
echo "CPU governor was" $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
echo "(should be 'performance')"
echo ""
echo "All done!"
