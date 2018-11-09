function [PC,PE,XB]=ClusterValidity(u,z)

c=size(u,2);
N=size(u,1);

temp1=0;
temp2=0;

% for i=1:c
%     
%    temp1=temp1+sum(u(:,i).^2);
%    temp2=temp2+sum(u(:,i).*log(u(:,i)));
%     
% end

diff=zeros(c,c);
for i=1:c
    for j=i+1:c
        diff(i,j)=norm(z(i,:)-z(j,:))^2;
    end
end

s1=CalculateJm(u,z);
s2=N*min(diff(diff~=0));

PC=1/N*sum(sum(u.^2));
PE=-1/N*sum(sum(u.*log(u)));
XB=s1/s2;

end