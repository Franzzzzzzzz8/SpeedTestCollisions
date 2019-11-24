clear sum ;

N=5000 ;
particles=rand(N,3) ;
Dsqr=0.05 ;

tic
count = 0 ;
parfor i = [1:N]
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
res=toc;

disp([num2str(res) ' ',num2str(count)]) ;
