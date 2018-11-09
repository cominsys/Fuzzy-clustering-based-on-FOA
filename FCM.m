function [z,U,f]=FCM(Data,c,z)


e=1e-5;
Jm=zeros(1,100);
N=size(Data,1);
if(nargin<3)
    U=rand(N,c);
end
for i=1:100
    
    
    U=CalculateU(z);
    Jm(i)=CalculateJm(U,z);
    z=CalculateZ(U);
%     if(i>1 && abs(Jm(i)-Jm(i-1))<e)
%         break;
%     end
    
end

f=Jm(1,end);
end