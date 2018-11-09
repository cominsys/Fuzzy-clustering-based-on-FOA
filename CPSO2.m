function [z,u,f]=CPSO2

%% Step1   Initialization

k=20;                    % number of iteration
pNo=20;
global Data;
global c;
global s;
s=size(Data,2);         % size of data dimension

global minx;
global maxx;
minx=repmat(min(Data),1,c);
maxx=repmat(max(Data),1,c);

Iterations=500;    % Maximum number of iterations
area_limit=pNo;      % The limitation of the forest
Life_time=15;       % The maximum allowed Age of a tree 
Transfer_rate=10;

Forest=InitializeForest(c*s,Iterations, area_limit, Life_time, Transfer_rate);
Forest=main(Forest,1,0);
p=Forest.T(:,1:c*s);
f=Forest.T(:,end-1);    
pgbest=p(1,:);
fgbest=f(1);



    
%% Step3 Chaotic Local Search and Gradient Method Search
    
    % CLS
    % Initialization
    ICLS=1000;
    beta=rand;
    a=2;
    xcls=minx+(maxx-minx).*rand;
    fcls=FitnessFunction(xcls);
    
    cx=-1+(1+1)*rand(1,c*s);
    
    % CLS Loop
    for lambda=0:ICLS
        
       cx=sin(a./cx);
       X=beta*(cx-.5).*(maxx-minx)+xcls;
       tempf=FitnessFunction(X);
       if(tempf<fcls)
          
           fcls=tempf;
           xcls=X;
       end
        
    end
        
    % GM
    
    % Initialization
    
    IGM=3;
    %DecodeParticle(xgm,s,c);
    
    % GM Loop
    
    zgm=DecodeParticle(pgbest,s);
        
    for i=1:IGM
        
       Ugm=CalculateU(zgm);
       zgm=CalculateZ(Ugm);
       
    end
    
    Jm=CalculateJm(Ugm,zgm);
    fgm=Jm;
    xgm=reshape(zgm',[1,c*s]);
    
    % Compare Fcls and Fgm
    
    if(fcls<fgm && fcls<fgbest)
        fgbest=fcls;
        pgbest=xcls;
    elseif(fgm<fcls && fgm<fgbest)
        fgbest=fgm;
        pgbest=xgm;
    end
    
%     p(index,:)=pgbest;
%     f(index)=fgbest;
    
%     vbest=v(index,:);
% 
%     toc;
%     %% Step4   Reserve the top N/5 particles
%     
%     n5=round(pNo/5);
%     
%     [~,sortedIndex]=sort(f);
%     p1=p(sortedIndex(1:n5),:);
%     v1=v(sortedIndex(1:n5),:);
%     f1=f(sortedIndex(1:n5));
%     
%     %% Step5   Decrease the search scale, eta in (0,1)
%     
%     eta=rand;
%     
%     minx=max(minx,pgbest-eta*(maxx-minx));
%     maxx=min(maxx,pgbest+eta*(maxx-minx));
%     
%     %% Step6   Randomly generate 4N/5 new particles with the new search scale
%     
%     rest=pNo-n5-1;
%     [p2,f2]=Initialize(rest,c*s);    
%     v2=zeros(rest,c*s);
%     for i=1:rest
% 
%         v2(i,:)=minv+(maxv-minv).*rand(1,c*s);
% 
%     end
% 
%     
%     %% Step7   Construct a new generation with 4N/5 new particles and N/5 reserved ones
%     
%     % Merge Step4 and Step6
%     
%     p=[pgbest;p1;p2];
%     v=[vbest;v1;v2];
%     f=[fgbest;f1;f2'];
%     %Forest.T=[p f'];
%     %Forest.T(:,end+1)=0;
%     % Update Local Best Particle
%     
% %     for i=1:pNo
% %        
% %         if(f(i)>fbest(i))
% %            
% %             fbest(i)=f(i);
% %             plbest(i,:)=p(i,:);
% %         end
% %     end
%     j(i)=min(f);
%     disp(num2str(iter));
%     disp(j(i));
%     
%     if(i>1 && abs(j(i)-j(i-1)<1e-5))
%         break;
%     end
%     
% end

% [fgbest,index]=max(f);
% pgbest=x(index,:);
    
z=DecodeParticle(pgbest,s);
U=CalculateU(z);
[z,u,f]=FCM(Data,U,c);
% f=fgbest;
% u=U;
end