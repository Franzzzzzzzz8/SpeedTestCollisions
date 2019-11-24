#!/bin/bash
nrun=50
rm Timing2.log

echo ""
rm Temp
octave --no-gui Distance.m >> Temp
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "OCTAVE raw*", s1/NR, s2/NR}' Temp >> Timing2.log

echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do octave --no-gui Distancev2.m >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "OCTAVE matrix", s1/NR, s2/NR}' Temp >> Timing2.log

echo ""
rm Temp
pypy3 Distance.py >> Temp
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "PYPY raw*", s1/NR, s2/NR}' Temp >> Timing2.log


echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do pypy3 Distance-v2.py >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "PYPY numpy", s1/NR, s2/NR}' Temp >> Timing2.log

echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do pypy3 Distance-nonumpy.py >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "PYPY nonumpy", s1/NR, s2/NR}' Temp >> Timing2.log

