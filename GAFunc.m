function BestSol=GAFunc()

    global minx;
    global maxx;
    global c;
    global s;

    CostFunction=@(x) FitnessFunction(x);        % Cost Function

    VarMin= minx;         % Lower Bound of Variables
    VarMax= maxx;         % Upper Bound of Variables

    VarSize=[1 c*s];    

    %% GA Parameters

    MaxIt=150;      % Maximum Number of Iterations

    nPop=50;        % Population Size

    pc=0.85;                 % Crossover Percentage
    nc=2*round(pc*nPop/2);  % Number of Offsprings (Parnets)

    pm=0.008;                 % Mutation Percentage
    nm=round(pm*nPop);      % Number of Mutants

    gamma=0.05;

    mu=0.02;                % Mutation Rate

%     ANSWER=questdlg('Choose selection method:','Genetic Algorith',...
%         'Roulette Wheel','Tournament','Random','Roulette Wheel');
% 
%     UseRouletteWheelSelection=strcmp(ANSWER,'Roulette Wheel');
%     UseTournamentSelection=strcmp(ANSWER,'Tournament');
%     UseRandomSelection=strcmp(ANSWER,'Random');
% 
%     if UseRouletteWheelSelection
%         beta=8;         % Selection Pressure
%     end
% 
%     if UseTournamentSelection
%         TournamentSize=3;   % Tournamnet Size
%     end

    beta=1;
    TournamentSize=3;
    
    pause(0.1);

    %% Initialization

    empty_individual.Position=[];
    empty_individual.Cost=[];

    pop=repmat(empty_individual,nPop,1);

    for i=1:nPop

        % Initialize Position
        pop(i).Position=unifrnd(VarMin,VarMax,VarSize);

        % Evaluation
        pop(i).Cost=CostFunction(pop(i).Position);

    end

    % Sort Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);

    % Store Best Solution
    BestSol=pop(1);

    % Array to Hold Best Cost Values
    BestCost=zeros(MaxIt,1);

    % Store Cost
    WorstCost=pop(end).Cost;
    
    %% Main Loop

    for it=1:MaxIt

        
        
        % Calculate Selection Probabilities
        P=exp(-beta*Costs/WorstCost);
        P=P/sum(P);

        % Crossover
        popc=repmat(empty_individual,nc/2,2);
        for k=1:nc/2

            % Select Parents Indices
            i1=TournamentSelection(pop,TournamentSize);
            i2=TournamentSelection(pop,TournamentSize);
            
            
%             if UseRouletteWheelSelection
%                 i1=RouletteWheelSelection(P);
%                 i2=RouletteWheelSelection(P);
%             end
%             if UseTournamentSelection
%                 i1=TournamentSelection(pop,TournamentSize);
%                 i2=TournamentSelection(pop,TournamentSize);
%             end
%             if UseRandomSelection
%                 i1=randi([1 nPop]);
%                 i2=randi([1 nPop]);
%             end

            % Select Parents
            p1=pop(i1);
            p2=pop(i2);

            % Apply Crossover
            [popc(k,1).Position, popc(k,2).Position]=...
                Crossover(p1.Position,p2.Position,gamma,VarMin,VarMax);

            % Evaluate Offsprings
            popc(k,1).Cost=CostFunction(popc(k,1).Position);
            popc(k,2).Cost=CostFunction(popc(k,2).Position);

        end
        popc=popc(:);


        % Mutation
        popm=repmat(empty_individual,nm,1);
        for k=1:nm

            % Select Parent
            i=randi([1 nPop]);
            p=pop(i);

            % Apply Mutation
            popm(k).Position=Mutate(p.Position,mu,VarMin,VarMax);

            % Evaluate Mutant
            popm(k).Cost=CostFunction(popm(k).Position);

        end

        % Create Merged Population
        pop=[pop
             popc
             popm];

        % Sort Population
        Costs=[pop.Cost];
        [Costs, SortOrder]=sort(Costs);
        pop=pop(SortOrder);

        % Update Worst Cost
        WorstCost=max(WorstCost,pop(end).Cost);

        % Truncation
        pop=pop(1:nPop);
        Costs=Costs(1:nPop);

        % Store Best Solution Ever Found
        BestSol=pop(1);

        % Store Best Cost Ever Found
        BestCost(it)=BestSol.Cost;

        % Show Iteration Information
        disp(['Iteration ' num2str(it) ', Best Cost = ' num2str(BestCost(it))]);

    end

end