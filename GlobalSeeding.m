function Forest=GlobalSeeding(candidate, Forest, Eval)

New_Trees=[];
% choosing GSC variables randomly
index=randperm(Forest.P.Dimension,Forest.P.GSC);
% choose a percentage of candidate population
RevoSize=floor(((size(candidate,1))*Forest.P.Transfer_rate)/100);

% [value,sidx]=sort(candidate(:,end-1));
% candidate=candidate(sidx,:);

SelectedTrees=candidate(1:RevoSize, :);
for i=1:size(SelectedTrees,1)
    
    tempTree=SelectedTrees(i,:);
%     for j=index
%         tempTree(1,j)=random('unif',Forest.P.Llimit(j),Forest.P.Ulimit(j),1,1);
%     end
    
    tempTree(index)=random('unif',Forest.P.Llimit(index),Forest.P.Ulimit(index),size(index));
    tempTree(1,Forest.P.Dimension+1)=Eval(tempTree(1:Forest.P.Dimension));
    tempTree(1,Forest.P.Dimension+2)=0;
    New_Trees=[New_Trees; tempTree];
end
Forest.T=[Forest.T; New_Trees];
end