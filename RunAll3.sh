#!/bin/bash

nrun=50
rm Timing3.log

echo -en "\n===== Cpp version ===="
g++ -o Distance_loop1 -O2 Distance_loop1.cpp ; echo ""
rm Temp
for ((i=0 ; i<nrun ; i++))
do ./Distance_loop1 >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "Cpp -O2 loop1", s1/NR, s2/NR}' Temp >> Timing3.log

g++ -o Distance_loop2 -O2 Distance_loop2.cpp ; echo ""
rm Temp
for ((i=0 ; i<nrun ; i++))
do ./Distance_loop2 >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "Cpp -O2 loop2", s1/NR, s2/NR}' Temp >> Timing3.log

g++ -o Distance_loop3 -O2 Distance_loop3.cpp ; echo ""
rm Temp
for ((i=0 ; i<nrun ; i++))
do ./Distance_loop3 >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "Cpp -O2 loop3", s1/NR, s2/NR}' Temp >> Timing3.log


echo ""
cat Timing3.log
