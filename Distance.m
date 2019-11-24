particles=rand(5000,3) ;
Dsqr=0.05 ;
N=5000 ;

tic
count = 0 ;
for i = [1:N]
    for j = [i:N]
        sum=0 ;
        for k=1:3
            sum=sum+(particles(i,k)-particles(j,k))*(particles(i,k)-particles(j,k)) ;
        end ;
        if (sum<Dsqr)
            count=count + 1 ;
        end ;
    end;
end;
res = toc ; 

disp([num2str(res) ' ',num2str(count)]) ;