function U=CalculateU(z)

    global Data;
    global c;

    N=size(Data,1);
    U=zeros(N,c);
    global m;

    p=2/(m-1);

    distance=dist(Data,z);
    tmp = distance.^(-2/(m-1));
    U_new = tmp./(ones(c, 1)*sum(tmp));
    U=U_new';

    % for i=1:N
    %     for j=1:c
    %         su=0;
    %         l=norm(Data(i,:)-z(j,:));
    %         for k=1:c
    %            su=su+(l/norm(Data(i,:)-z(k,:)))^p;        
    %         end
    %         
    % %         sum((norm(Data(i,:)-z(j,:))/norm(Data(i,:)-z))^(2/(m-1)));
    % 
    %         U(i,j)=1/su;
    %      end
    %     
    % end

end