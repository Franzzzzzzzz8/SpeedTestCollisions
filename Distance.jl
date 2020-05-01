function dst(N,Dsqr,particles)
count=0 
for i = 1:N
    for j=i+1:N
        sum=0 
        for k=1:3
            sum = sum + (particles[i,k]-particles[j,k])*(particles[i,k]-particles[j,k])
        end 
        if sum < Dsqr
            count = count + 1
        end 
    end
end
return (count) 
end 

