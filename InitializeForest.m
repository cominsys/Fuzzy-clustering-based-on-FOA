function Forest=InitializeForest(dim, Iterations, area_limit, Life_time, Transfer_rate)

    global minx;
    global maxx;
    global best;
    % Forest.P: Parameters
    % Forest.T: Trees
     Forest.P.area_limit=area_limit;         % The limitation of the forest
     Forest.P.Life_time=Life_time;           % The maximum allowed age of a tree 
     Forest.P.Transfer_rate=Transfer_rate;   % The percentage of candidate population 
     Forest.P.Dimension=dim;                 % The dimension of the problem domain
     Forest.P.Llimit=minx;            % The lower limit of the variables
     Forest.P.Ulimit=maxx;           % The upper limit of the variables
     Forest.P.MaxIterations=Iterations;      % Maximum number of iterations
     Forest.P.dx=(abs(Forest.P.Ulimit)/5);   % dx is a small value used in local seeding. This value is not used in binary problems and in discrete problem, this value should be rounded.
     if dim<5
         Forest.P.LSC=1; % Local seeding changes (1/5 of the dimension)
         Forest.P.GSC=1; % Global seeding changes
     else
         Forest.P.LSC=floor((3*Forest.P.Dimension)/3); % 20 percent (not optimal) of the dimension used in local seeding
         Forest.P.GSC=floor((1*Forest.P.Dimension)/3); % 10 percent (not optimal) of the dimension used in global seeding   
     end
     % Forming the Forest with randomly generated trees
    %  BestSol=BBOFunc;
    %  x=BestSol.Position;
    %  Jm=BestSol.Cost;
    [x,Jm]=Initialize(Forest.P.area_limit,Forest.P.Dimension);
    Forest.T=x;
    % [~,x]=kmeans(Data,c);
    %  Forest.T(:,:)=repmat(reshape(x',[1,Forest.P.Dimension]),Forest.P.area_limit,1);
    % Forest.T(:,:)=random('unif',Forest.P.Llimit,Forest.P.Ulimit,Forest.P.area_limit,Forest.P.Dimension); 
     clm=size(Forest.T(:,:),2);
     for q=1:size(Forest.T,1)
         Forest.T(q,clm+1)=Jm(q);
         %Forest.T(q,clm+1)=FitnessFunction(Forest.T(q,1:clm));
         Forest.T(q,clm+2)=0;
     end

end
