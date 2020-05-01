function dst(N,Dsqr,particles)
count=0 
for i = 1:N-1
    count = count + sum(sum((particles[i+1:end,:] - ones(N-i,1).*transpose(particles[i,:])).^2 ,dims=2).<Dsqr) ;
end
return (count) 
end 

