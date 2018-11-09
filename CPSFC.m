function [z,u,f]=CPSFC

global Data;

pNo=50;
s=size(Data,2);

[x,f]=Initialize(pNo,s);

p=x;
%% Step2 Repeat until a stopping criterion is satisfied


flbest=f;
plbest=p;
c1=2;
c2=2;

out=zeros(k,1);

% Main Loop
for iter=1:k
   
    findex=find(f>flbest);
    flbest(findex)=f(findex);
    plbest(findex,:)=p(findex,:);
    
    % Update f global best
    
    [fgbest,index]=max(flbest);
    pgbest=p(index,:);
    
    r1=rand(1,c*s);
    r2=rand(1,c*s);
    
    r1=repmat(r1,pNo,1);
    r2=repmat(r2,pNo,1);
    
    iw=AIWF(f);
%     vmax=repmat(maxv,1,c);
%     vmin=repmat(maxv,1,c);
%     xmax=repmat(maxv,1,c);
%     xmin=repmat(maxv,1,c);
%     

    v=ones(pNo,1)*iw*v+c1*r1.*(plbest-p)+c2*r2.*(ones(pNo,1)*pgbest-p);

    v=min(ones(pNo,1)*maxv,max(v,ones(pNo,1)*minv));
    
    p=p+v;
    
    p=min(ones(pNo,1)*maxx,max(p,ones(pNo,1)*minx));
    
    for i=1:pNo
       
%         v(i,:)=w(i)*v(i,:)+c1*r1.*(plbest(i,:)-p(i,:))+c2*r2.*(pgbest-p(i,:));
%                 
%         v(i,:)=min(maxv,max(v(i,:),minv));       
%         
%         p(i,:)=p(i,:)+v(i,:);
%        
%         p(i,:)=min(maxx,max(p(i,:),minx));       

        % Update f

        f(i)=FitnessFunction(p(i,:));
        
       
        % Update f local best
        
%         if(f(i)>flbest(i))          
%             flbest(i)=f(i);
%             plbest(i)=p(i);            
%         end          
%         
%         if(f(i)>fgbest)
%            fgbest=f(i);
%            pgbest=p(i,:);
%         end
%         
    end
    
    
    %% Step3 Chaotic Local Search and Gradient Method Search
    
    % CLS
    
    % Initialization
    ICLS=100;
    beta=rand;
    a=2;
    xcls=minx+(maxx-minx).*rand(1,c*s);
    fcls=FitnessFunction(xcls);    
    cx=-1+(1+1)*rand(1,c*s);            % Chaotic Variable
    
    % CLS Loop
    for lambda=0:ICLS
        
       cx=sin(a./cx);
       X=beta*(cx-.5).*(maxx-minx)+xcls;
       tempf=FitnessFunction(X);
       if(tempf>fcls)
          
           fcls=tempf;
           xcls=X;
       end
        
    end
        
    % GM
    
    % Initialization    
    IGM=3;
        
    % GM Loop    
    zgm=DecodeParticle(pgbest,s);
        
    for i=1:IGM
        
       Ugm=CalculateU(zgm);
       zgm=CalculateZ(Ugm);
       
    end
    
    Jm=CalculateJm(Ugm,zgm);
    fgm=1/(1+Jm);
    xgm=reshape(zgm',[1,c*s]);
    
    % Compare Fcls and Fgm
    
    if(fcls>fgm && fcls>fgbest)
        fgbest=fcls;
        pgbest=xcls;
    elseif(fgm>fcls && fgm>fgbest)
        fgbest=fgm;
        pgbest=xgm;
    end
    
    p(index,:)=pgbest;
    f(index)=fgbest;
    
    vbest=v(index,:);

    %% Step4   Reserve the top N/5 particles
    
    n5=round(pNo/5);
    
    [~,sortedIndex]=sort(f,'descend');
    p1=p(sortedIndex(1:n5),:);
    v1=v(sortedIndex(1:n5),:);
    f1=f(sortedIndex(1:n5));
    
    %% Step5   Decrease the search scale, eta in (0,1)
    
    eta=rand;
    
    minx=max(minx,pgbest-eta*(maxx-minx));
    maxx=min(maxx,pgbest+eta*(maxx-minx));
    
    %% Step6   Randomly generate 4N/5 new particles with the new search scale
    
    rest=pNo-n5-1;
    [p2,v2,f2]=Initialize(rest,s);    
    

    
    %% Step7   Construct a new generation with 4N/5 new particles and N/5 reserved ones
    
    % Merge Step4 and Step6
    
    p=[pgbest;p1;p2];
    v=[vbest;v1;v2];
    f=[fgbest f1 f2];
    
    % Update Local Best Particle
    
%     for i=1:pNo
%        
%         if(f(i)>fbest(i))
%            
%             fbest(i)=f(i);
%             plbest(i,:)=p(i,:);
%         end
%     end
j=max(f);
out(iter,1)=1/j-1;

% if(iter>1 && abs(out(iter)-out(iter-1))<1e-5)
%     break;
% end

disp([num2str(iter) ': ' num2str(out(iter))]);
    
%end

% [fgbest,index]=max(f);
% pgbest=x(index,:);
    
z=DecodeParticle(pgbest,s);
U=CalculateU(z);
f=fgbest;
u=U;
end