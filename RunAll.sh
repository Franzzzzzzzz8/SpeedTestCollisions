#!/bin/bash

nrun=50
rm Timing.log

echo -en "\n====== PYTHON version ===="
echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do python Distance-nonumpy.py >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "PYTHON nonumpy", s1/NR, s2/NR}' Temp 

exit


echo -en "\n===== Cpp version ===="
g++ -o Distance -O0 Distance.cpp ; echo ""
rm Temp
for ((i=0 ; i<nrun ; i++))
do ./Distance >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "Cpp -O0", s1/NR, s2/NR}' Temp >> Timing.log

g++ -o Distance -O1 Distance.cpp ; echo ""
rm Temp
for ((i=0 ; i<nrun ; i++))
do ./Distance >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "Cpp -O1", s1/NR, s2/NR}' Temp >> Timing.log

g++ -o Distance -O2 Distance.cpp ; echo ""
rm Temp
for ((i=0 ; i<nrun ; i++))
do ./Distance >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "Cpp -O2", s1/NR, s2/NR}' Temp >> Timing.log

g++ -o Distance -O3 Distance.cpp ; echo ""
rm Temp
for ((i=0 ; i<nrun ; i++))
do ./Distance >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "Cpp -O3", s1/NR, s2/NR}' Temp >> Timing.log

g++ -o Distance -Os Distance.cpp ; echo ""
rm Temp
for ((i=0 ; i<nrun ; i++))
do ./Distance >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "Cpp -Os", s1/NR, s2/NR}' Temp >> Timing.log



echo -en "\n====== C version ===="
gcc -o Distance -O0 Distance.c ; echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do ./Distance >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "C -O0", s1/NR, s2/NR}' Temp >> Timing.log

gcc -o Distance -O3 Distance.c ; echo ""
rm Temp
for ((i=0 ; i<nrun ; i++))
do ./Distance >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "C -O3", s1/NR, s2/NR}' Temp >> Timing.log



echo -en "\n====== FORTRAN version ===="
gfortran -o Distance -O0 Distance.f90 ; echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do ./Distance >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "FORTRAN -O0", s1/NR, s2/NR}' Temp >> Timing.log

gfortran -o Distance -O3 Distance.f90 ; echo ""
rm Temp
for ((i=0 ; i<nrun ; i++))
do ./Distance >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "FORTRAN -O3", s1/NR, s2/NR}' Temp >> Timing.log



echo -e "\n====== JAVA version ===="
rm Temp
for ((i=0 ; i<nrun ; i++))
do java Distance.java >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "JAVA", s1/NR, s2/NR}' Temp >> Timing.log



echo -en "\n====== JAVASCRIPT version ===="
echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do nodejs Distance.js | egrep -o '[.0-9]+' | tr '\n' ' ' >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "JS", s1/NR/1000., s2/NR}' Temp >> Timing.log



echo -en "\n====== MATLAB version ===="
echo ""
rm Temp 
$HOME/Matlab2014a/bin/matlab -nodisplay -nosplash -nodesktop -r "RunMat($nrun);exit;" | tail -n +11 > Temp
awk 'NF==2{print $0}' Temp | awk 'BEGIN{OFS = ","; names[0]="MATLAB14a raw"; names[1]="MATLAB14a matrix"; names[2]="MATLAB14a raw+par"; names[3]="MATLAB14a matrix+par";} {s1[int((NR-1)/'"$nrun"')] += $1; s2[int((NR-1)/'"$nrun"')] += $2} END{for (i=0; i<4 ; i++) {print names[i], s1[i]/'"$nrun"', s2[i]/'"$nrun"'}}' >> Timing.log

echo ""
rm Temp 
$HOME/Matlab2014b/bin/matlab -nodisplay -nosplash -nodesktop -r "RunMat($nrun);exit;" | tail -n +11 > Temp
awk 'NF==2{print $0}' Temp | awk 'BEGIN{OFS = ","; names[0]="MATLAB14b raw"; names[1]="MATLAB14b matrix"; names[2]="MATLAB14b raw+par"; names[3]="MATLAB14b matrix+par";} {s1[int((NR-1)/'"$nrun"')] += $1; s2[int((NR-1)/'"$nrun"')] += $2} END{for (i=0; i<4 ; i++) {print names[i], s1[i]/'"$nrun"', s2[i]/'"$nrun"'}}' >> Timing.log

echo ""
rm Temp 
$HOME/Matlab2015a/bin/matlab -nodisplay -nosplash -nodesktop -r "RunMat($nrun);exit;" | tail -n +14 > Temp
awk 'NF==2{print $0}' Temp | awk 'BEGIN{OFS = ","; names[0]="MATLAB15a raw"; names[1]="MATLAB15a matrix"; names[2]="MATLAB15a raw+par"; names[3]="MATLAB15a matrix+par";} {s1[int((NR-1)/'"$nrun"')] += $1; s2[int((NR-1)/'"$nrun"')] += $2} END{for (i=0; i<4 ; i++) {print names[i], s1[i]/'"$nrun"', s2[i]/'"$nrun"'}}' >> Timing.log

echo ""
rm Temp 
$HOME/Matlab2015b/bin/matlab -nodisplay -nosplash -nodesktop -r "RunMat($nrun);exit;" | tail -n +14 > Temp
awk 'NF==2{print $0}' Temp | awk 'BEGIN{OFS = ","; names[0]="MATLAB15b raw"; names[1]="MATLAB15b matrix"; names[2]="MATLAB15b raw+par"; names[3]="MATLAB15b matrix+par";} {s1[int((NR-1)/'"$nrun"')] += $1; s2[int((NR-1)/'"$nrun"')] += $2} END{for (i=0; i<4 ; i++) {print names[i], s1[i]/'"$nrun"', s2[i]/'"$nrun"'}}' >> Timing.log

echo ""
rm Temp 
$HOME/Matlab2016a/bin/matlab -nodisplay -nosplash -nodesktop -r "RunMat($nrun);exit;" | tail -n +14 > Temp
awk 'NF==2{print $0}' Temp | awk 'BEGIN{OFS = ","; names[0]="MATLAB16a raw"; names[1]="MATLAB16a matrix"; names[2]="MATLAB16a raw+par"; names[3]="MATLAB16a matrix+par";} {s1[int((NR-1)/'"$nrun"')] += $1; s2[int((NR-1)/'"$nrun"')] += $2} END{for (i=0; i<4 ; i++) {print names[i], s1[i]/'"$nrun"', s2[i]/'"$nrun"'}}' >> Timing.log

echo ""
rm Temp 
$HOME/Matlab2016b/bin/matlab -nodisplay -nosplash -nodesktop -r "RunMat($nrun);exit;" | tail -n +11 > Temp
awk 'NF==2{print $0}' Temp | awk 'BEGIN{OFS = ","; names[0]="MATLAB16b raw"; names[1]="MATLAB16b matrix"; names[2]="MATLAB16b raw+par"; names[3]="MATLAB16b matrix+par";} {s1[int((NR-1)/'"$nrun"')] += $1; s2[int((NR-1)/'"$nrun"')] += $2} END{for (i=0; i<4 ; i++) {print names[i], s1[i]/'"$nrun"', s2[i]/'"$nrun"'}}' >> Timing.log

echo ""
rm Temp 
$HOME/Matlab2017a/bin/matlab -nodisplay -nosplash -nodesktop -r "RunMat($nrun);exit;" | tail -n +11 > Temp
awk 'NF==2{print $0}' Temp | awk 'BEGIN{OFS = ","; names[0]="MATLAB17a raw"; names[1]="MATLAB17a matrix"; names[2]="MATLAB17a raw+par"; names[3]="MATLAB17a matrix+par";} {s1[int((NR-1)/'"$nrun"')] += $1; s2[int((NR-1)/'"$nrun"')] += $2} END{for (i=0; i<4 ; i++) {print names[i], s1[i]/'"$nrun"', s2[i]/'"$nrun"'}}' >> Timing.log

echo ""
rm Temp 
$HOME/Matlab2017b/bin/matlab -nodisplay -nosplash -nodesktop -r "RunMat($nrun);exit;" | tail -n +11 > Temp
awk 'NF==2{print $0}' Temp | awk 'BEGIN{OFS = ","; names[0]="MATLAB17b raw"; names[1]="MATLAB17b matrix"; names[2]="MATLAB17b raw+par"; names[3]="MATLAB17b matrix+par";} {s1[int((NR-1)/'"$nrun"')] += $1; s2[int((NR-1)/'"$nrun"')] += $2} END{for (i=0; i<4 ; i++) {print names[i], s1[i]/'"$nrun"', s2[i]/'"$nrun"'}}' >> Timing.log


echo ""
rm Temp 
$HOME/Matlab/bin/matlab -nodisplay -nosplash -nodesktop -r "RunMat($nrun);exit;" | tail -n +11 > Temp
awk 'NF==2{print $0}' Temp | awk 'BEGIN{OFS = ","; names[0]="MATLAB18a raw"; names[1]="MATLAB18a matrix"; names[2]="MATLAB18a raw+par"; names[3]="MATLAB18a matrix+par";} {s1[int((NR-1)/'"$nrun"')] += $1; s2[int((NR-1)/'"$nrun"')] += $2} END{for (i=0; i<4 ; i++) {print names[i], s1[i]/'"$nrun"', s2[i]/'"$nrun"'}}' >> Timing.log



echo -en "\n====== PYTHON version ===="
echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do python Distance.py >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "PYTHON raw", s1/NR, s2/NR}' Temp >> Timing.log

echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do python Distance-v2.py >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "PYTHON numpy", s1/NR, s2/NR}' Temp >> Timing.log

echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do python Distance-v3.py >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "PYTHON numba", s1/NR, s2/NR}' Temp >> Timing.log

echo ""
rm Temp 
for ((i=0 ; i<nrun ; i++))
do python Distance-v4.py >> Temp ; echo -n "."
done 
awk 'BEGIN{OFS = ","} {s1 += $1 ; s2 +=$2 ;} END{print "PYTHON numba+numpy", s1/NR, s2/NR}' Temp >> Timing.log














echo ""

























