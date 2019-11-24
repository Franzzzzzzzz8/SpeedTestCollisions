clear sum ;

N=5000 ;
particles=rand(N,3) ;
Dsqr=0.05 ;


tic
count = 0 ;
for i = [1:N-1]
    count = count + sum(sum((particles(i+1:end,:) - ones(N-i,1)*particles(i,:)).^2,2)<Dsqr) ;
end
res=toc ; 

disp([num2str(res) ' ',num2str(count)]) ;
