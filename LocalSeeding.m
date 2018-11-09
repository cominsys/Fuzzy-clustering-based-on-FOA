function Forest=LocalSeeding(Forest, Eval)

newtrees=[];
for q=1:size(Forest.T,1)
    if Forest.T(q,Forest.P.Dimension+2)==0 %Dimension+2 shows the Age of each tree        
        % choosing LSC variables randomly
        move=randperm(Forest.P.Dimension,Forest.P.LSC);
        childs=[];
        for i=move
            temp=Forest.T(q,:);        
            temp(1,i)=temp(1,i)+random('unif',-Forest.P.dx(i) ,Forest.P.dx(i) ,1,1);            
            temp(1,i)=min(Forest.P.Ulimit(i),max(Forest.P.Llimit(i),temp(1,i)));            
            temp(1,Forest.P.Dimension+1)=Eval(temp(1:Forest.P.Dimension));
            temp(1,Forest.P.Dimension+2)=0;
            childs=[childs;temp];
        end
        
        newtrees=[newtrees;childs];
        childs=[];   
    end   
end
% Increasing the Age of all trees except for new trees
Forest.T(:,Forest.P.Dimension+2)=Forest.T(:,Forest.P.Dimension+2)+1;
% adding the new trees with Age 0 to the Forest
Forest.T=[Forest.T; newtrees];
end