function w=AIWF(f)

fave=mean(f);
fmin=min(f);
wmin=.4;
wmax=.9;
n=numel(f);

w=zeros(1,n);

for i=1:n
    
    if(f(i)<=fave)

        w(i)=wmin+((wmax-wmin)*(f(i)-fmin))/(fave-fmin);
    else

        w(i)=wmax;    
    end

end

end