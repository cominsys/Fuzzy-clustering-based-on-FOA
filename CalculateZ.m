function z=CalculateZ(U)

global Data;
global c;

s=size(Data,2);
N=size(Data,1);
z=zeros(c,s);
global m;


% for i=1:c
% 
%     z(i)=sum(U(:,i)'.^m.*Data)./sum(U(:,i)'.^m);
% end

for i=1:c
    s1=0;
    s2=0;
    for j=1:N
        
        s1=s1+U(j,i)^m*Data(j,:);
        s2=s2+U(j,i)^m;
        
    end
    z(i,:)=s1/s2;
    
end