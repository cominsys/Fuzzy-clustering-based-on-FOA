function Jm=CalculateJm(U,z)

    global Data;
    global c;

    Jm=0;
    N=size(Data,1);
    global m;


    mf = U.^m;       % MF matrix after exponential modification
    %center = mfc*data./((ones(size(data, 2), 1)*sum(mf'))'); % new center
    distance = dist(Data,z);       % fill the distance matrix
    obj_fcn = sum(sum((distance.^2).*mf'));  % objective function
    Jm=obj_fcn;


    % for i=1:c
    %     for j=1:N
    %         %Jm=Jm+U(j,i)^m*...
    %          %   ((Data(i,:)-z(j,:))'*MDist(Data,U,z)*(Data(i,:)-z(j,:)));
    %         Jm=Jm+U(j,i)^m*(norm(Data(j,:)-z(i,:))^2);        
    %     end
    %     
    % end

end