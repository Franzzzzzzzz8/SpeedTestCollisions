PROGRAM Distances
DOUBLE PRECISION, DIMENSION(0:5000,0:2) :: particles
DOUBLE PRECISION sum
DOUBLE PRECISION dsqr
INTEGER count
real :: start, finish

DO i = 0, 5000
  DO j = 0, 2
    CALL RANDOM_NUMBER(particles(i,j))
  END DO
END DO

dsqr = 0.05
CALL CPU_TIME(start)
count = 0 
DO i = 0, 5000
  DO j = i+1, 5000
    sum = 0 
    DO k=0,2
      sum = sum + (particles(i,k) - particles(j,k))*(particles(i,k) - particles(j,k))
    END DO
    IF (sum .LT. dsqr) THEN
        count = count +1
    END IF
  END DO
END DO
CALL CPU_TIME(finish)

print *, finish-start, " ", count

END
