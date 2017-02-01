#!/bin/bash
#
# Compile and run various benchmarks for RPi3, in either 32-bit or 64-bit mode
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

if grep -q "aarch64" <(uname -a); then
	echo "Will build tests for 64-bit ARMv8"
	# as used on image
	CFLAGS="-lm -lrt -march=armv8-a+crc -mtune=cortex-a53 -O3 -pipe"
	V="8"
else
	echo "Compiling tests for 32-bit ARMv7a"
	# per https://wiki.gentoo.org/wiki/Raspberry_Pi#Stage_3
	CFLAGS="-lm -lrt -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard"
	CFLAGS="${CFLAGS} -O3 -pipe"
	V="7"
fi

echo "Deleting old binaries and result files..."
# A7 = 32-bit A8 = 64-bit
# FS = unsafe math optimizations (NEON) used
# SP = single precision
rm -f Dhry.txt whets.txt Linpack.txt LLloops.txt memSpeed.txt busSpeed.txt 
rm -f DhryA${V}.txt whetsA${V}.txt \
	LinpackA${V}.txt LinpackA${V}SP.txt LinpackA${V}FSSP.txt \
	LLloopsA${V}.txt memSpeedA${V}.txt memSpeedA${V}FS.txt \
	busSpeedA${V}.txt
rm -f dhrystonePiA${V} whetstonePiA${V} \
	linpackPiA${V} linpackPiA${V}SP linpackPiA${V}FSSP \
	liverloopsPiA${V} memspeedPiA${V} memspeedPiA${V}FS \
	busspeedPiA${V}

echo "Compiling tests..."
gcc ${CFLAGS} -o whetstonePiA${V} whets.c cpuidc.c
gcc ${CFLAGS} -o dhrystonePiA${V} dhry_1.c dhry_2.c cpuidc.c
gcc ${CFLAGS} -o linpackPiA${V} linpack.c cpuidc.c
gcc ${CFLAGS} -o linpackPiA${V}SP linpacksp.c cpuidc.c
gcc ${CFLAGS} -funsafe-math-optimizations \
	-o linpackPiA${V}FSSP linpacksp.c cpuidc.c
gcc ${CFLAGS} -o liverloopsPiA${V} lloops2.c cpuidc.c
gcc ${CFLAGS} -o memspeedPiA${V} memspeed.c cpuidc.c
gcc ${CFLAGS} -funsafe-math-optimizations \
	-o memspeedPiA${V}FS memspeed.c cpuidc.c
gcc ${CFLAGS} -o busspeedPiA${V} busspeed.c cpuidc.c


echo "Compiled - running tests - press <Enter> at end of each"
echo "to move to next"
./whetstonePiA${V}
mv -v whets.txt whetsA${V}.txt
./dhrystonePiA${V}
mv -v Dhry.txt DhryA${V}.txt
./linpackPiA${V}
mv -v Linpack.txt LinpackA${V}.txt
./linpackPiA${V}SP
mv -v Linpack.txt LinpackA${V}SP.txt
./linpackPiA${V}FSSP
mv -v Linpack.txt LinpackA${V}FSSP.txt
./liverloopsPiA${V}
mv -v LLloops.txt LLloopsA${V}.txt
./memspeedPiA${V} || true
mv -v memSpeed.txt memSpeedA${V}.txt
./memspeedPiA${V}FS || true
mv -v memSpeed.txt memSpeedA${V}FS.txt
./busspeedPiA${V} || true # these tests end with return(1) for some reason
mv -v busSpeed.txt busSpeedA${V}.txt

echo ""
echo "CPU governor was" \
	$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
echo "(should be 'performance')"
echo ""
echo "All done!"
