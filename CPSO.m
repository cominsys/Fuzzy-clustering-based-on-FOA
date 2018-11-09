function [z,u,f]=CPSO(choice)

    %% Step1   Initialization

    global Data;
    global c;
    global s;
    s=size(Data,2);         % size of data dimension
    pNo=50;
    global minx;
    global maxx;

    minx=repmat(min(Data),1,c);
    maxx=repmat(max(Data),1,c);

    switch choice
        case 'FOA'
            Iterations=100;    % Maximum number of iterations
            area_limit=pNo;      % The limitation of the forest
            Life_time=15;       % The maximum allowed Age of a tree
            Transfer_rate=10;
            
            Forest=InitializeForest(c*s,Iterations, area_limit, Life_time, Transfer_rate);
            tic;
            Forest=main(Forest);
            toc;
            p=Forest.T(:,1:c*s);
            f=Forest.T(:,end-1);
            pgbest=p(1,:);
            fgbest=f(1);
        case 'Ga'
            tic;
            BestSol = GAFunc();
            toc;
            pgbest=BestSol.Position;
            fgbest=BestSol.Cost;
        case 'PSO'
            tic;
            GlobalBest = PSOFunc();
            toc;
            pgbest=GlobalBest.Position;
            fgbest=GlobalBest.Cost;
          
    end
    
    %% Output

    z=DecodeParticle(pgbest,s);
    U=CalculateU(z);
    f=fgbest;
    u=U;


    %% Step3 Chaotic Local Search and Gradient Method Search
     
    %% CLS
    % 
    % % Initialization
    ICLS=0;
    beta=rand;
    a=2;
    xcls=minx+(maxx-minx).*rand(1,c*s);
    fcls=FitnessFunction(xcls);
    
    cx=-1+(1+1)*rand(1,c*s);
    % fcls=fgbest;
    % xcls=pgbest;
    % CLS Loop
    for lambda=0:ICLS
        
        cx=sin(a./cx);
        X=beta*(cx-.5).*(maxx-minx)+xcls;
        
        for i=1:c*s
            X(i)=min(maxx(i),max(minx(i),X(i)));
        end
    %     
        tempf=FitnessFunction(X);
        
        if(tempf<fcls)
            
            fcls=tempf;
            xcls=X;
        end
        
    end
    
    %% GM
    % 
    % % Initialization
    % 
    % IGM=3;
    % %DecodeParticle(xgm,s,c);
    % 
    % % GM Loop
    % 
    % zgm=DecodeParticle(pgbest,s);
    % 
    % for i=1:IGM
    %     
    %     Ugm=CalculateU(zgm);
    %     zgm=CalculateZ(Ugm);
    %     
    % end
    % 
    % fgm=CalculateJm(Ugm,zgm);
    % xgm=reshape(zgm',[1,c*s]);
    % 
    % % Compare Fcls and Fgm
    % 
    % if(fcls<fgm && fcls<fgbest)
    %     fgbest=fcls;
    %     pgbest=xcls;
    %     disp('CLS');
    % elseif(fgm<fcls && fgm<fgbest)
    %     fgbest=fgm;
    %     pgbest=xgm;
    %     disp('GM');
    % end

end