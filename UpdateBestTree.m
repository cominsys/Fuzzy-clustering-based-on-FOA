function [Forest, bestTree]=UpdateBestTree(Forest, bestTree)

    global check;
    global tolerance;
    
    % [value,index]=sort(Forest.T(:,Forest.P.Dimension+1));
    % Forest.T(index);
    % if(value<bestTree(Forest.P.Dimension+1))
    %     bestTree=Forest.T(1,:);
    % else
    %     Forest.T(1,:)=bestTree;
    % end
    % Forest.T(1,Forest.P.Dimension+2)=0;


    TempBest=bestTree;
    Index_of_best=1;
    for u=1:size(Forest.T,1)
        if Forest.T(u,Forest.P.Dimension+1)<TempBest(1,Forest.P.Dimension+1)% Dimension+1 is the fitness value
            TempBest=Forest.T(u,:);
            Index_of_best=u;
        end
    end
     if  Forest.T(Index_of_best,Forest.P.Dimension+1)<bestTree(1,Forest.P.Dimension+1)
         bestTree=Forest.T(Index_of_best,:);
         bestTree(1,Forest.P.Dimension+2)=0; % Dimension+2 shows the Age of each tree
         Forest.T(Index_of_best,:)=[];
         Forest.T=[bestTree;Forest.T];
     else
         updated_best=Forest.T(Index_of_best,:);
         updated_best(1,Forest.P.Dimension+2)=0;
         Forest.T(Index_of_best,:)=[];
         Forest.T=[updated_best;Forest.T];
     end

    [value,index]=sort(Forest.T(:,Forest.P.Dimension+1));
    fgbest=Forest.T(index(1),end-1);
    pgbest=Forest.T(index(1),1:end-2);
    % GM

    % Initialization
    %global IGM;
    IGM=3;
    %DecodeParticle(xgm,s,c);

    % GM Loop
    global s;
    global c;
    zgm=DecodeParticle(pgbest,s);

    for i=1:IGM

        Ugm=CalculateU(zgm);
        zgm=CalculateZ(Ugm);

    end

    fgm=CalculateJm(Ugm,zgm);
    xgm=reshape(zgm',[1,c*s]);



    % CLS
    % global minx;
    % global maxx;
    % 
    % % Initialization
    % ICLS=0;
    % beta=rand;
    % a=2;
    % xcls=minx+(maxx-minx).*rand(1,c*s);
    % fcls=FitnessFunction(xcls);
    % 
    % cx=-1+(1+1)*rand(1,c*s);
    % % fcls=fgbest;
    % % xcls=pgbest;
    % % CLS Loop
    % for lambda=0:ICLS
    %     
    %     cx=sin(a./cx);
    %     X=beta*(cx-.5).*(maxx-minx)+xcls;
    %     
    %     for i=1:c*s
    %         X(i)=min(maxx(i),max(minx(i),X(i)));
    %     end
    %      
    %     tempf=FitnessFunction(X);
    %     
    %     if(tempf<fcls)
    %         
    %         fcls=tempf;
    %         xcls=X;
    %     end
    %     
    % end


    % if(fcls<fgm && fcls<fgbest)
    %    Forest.T(index(1),end-1)=fcls;
    %     Forest.T(index(1),1:end-2)=xcls;
    %     disp('CLS');
    if(fgm<fgbest)
        Forest.T(index(1),end-1)=fgm;
        Forest.T(index(1),1:end-2)=xgm;
        disp('GM');
    else
%         tolerance=tolerance+1;
%         if(tolerance>30)
        check=true;
%         end
    end

    %Forest.T=[bestTree;Forest.T];


    %% Step3 Chaotic Local Search and Gradient Method Search

    %     global minx;
    %     global maxx;
    % 
    %     % CLS
    %     
    %     % Initialization
    %     ICLS=1000;
    %     beta=rand;
    %     a=2;
    %     xcls=minx+(maxx-minx).*rand(1,c*s);
    %     fcls=FitnessFunction(xcls);
    %     
    %     cx=-1+(1+1)*rand(1,c*s);
    %     
    %     % CLS Loop
    %     for lambda=0:ICLS
    %         
    %         cx=sin(a./cx);
    %         X=beta*(cx-.5).*(maxx-minx)+xcls;
    %         for i=1:c*s
    %             X(i)=min(maxx(i),max(minx(i),X(i)));
    %         end
    %         
    %         tempf=FitnessFunction(X);
    %         if(tempf<fcls)
    %             
    %             fcls=tempf;
    %             xcls=X;
    %         end
    %         
    %     end
    %     
    %     % GM
    %     
    %     % Initialization
    %     
    %     IGM=3;
    %     %DecodeParticle(xgm,s,c);
    %     
    %     % GM Loop
    %     
    %     pgbest=Forest.T(1,1:Forest.P.Dimension);
    %     fgbest=Forest.T(1,Forest.P.Dimension+1);
    %     
    %     zgm=DecodeParticle(pgbest,s);
    %     
    %     for i=1:IGM
    %         
    %         Ugm=CalculateU(zgm);
    %         zgm=CalculateZ(Ugm);
    %         
    %     end
    %     
    %     fgm=CalculateJm(Ugm,zgm);
    %     xgm=reshape(zgm',[1,c*s]);
    %     
    %     % Compare Fcls and Fgm
    %     
    %     if(fcls<fgm && fcls<fgbest)
    %         fgbest=fcls;
    %         pgbest=xcls;
    %         disp('CLS');
    %     elseif(fgm<fcls && fgm<fgbest)
    %         fgbest=fgm;
    %         pgbest=xgm;
    %         disp('GM');
    %     end
    %     
    %     Forest.T(1,1:Forest.P.Dimension)=pgbest;
    %     Forest.T(1,Forest.P.Dimension+1)=fgbest;

    % %     % GM
    % %
    % %     % Initialization
    % %
    % fgbest=Forest.T(1,end-1);
    % pgbest=Forest.T(1,1:end-2);
    % IGM=30;
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
    % if(fgm<fgbest)
    %     fgbest=fgm;
    %     pgbest=xgm;
    %     disp('GM');
    % end
    % %
    % Forest.T(1,end-1)=fgbest;
    % Forest.T(1,1:end-2)=pgbest;

    % TempBest=bestTree;
    % Index_of_best=1;
    % changed=0;
    %
    % for u=1:size(Forest.T,1)
    %     if Forest.T(u,Forest.P.Dimension+1)<TempBest(1,Forest.P.Dimension+1)% Dimension+1 is the fitness value
    %         TempBest=Forest.T(u,:);
    %         Index_of_best=u;
    %         changed=1;
    %     end
    % end
    %  if  Forest.T(Index_of_best,Forest.P.Dimension+1)<bestTree(1,Forest.P.Dimension+1)
    %      bestTree=Forest.T(Index_of_best,:);
    %      bestTree(1,Forest.P.Dimension+2)=0; % Dimension+2 shows the Age of each tree
    %      Forest.T(Index_of_best,:)=[];
    %      Forest.T=[bestTree;Forest.T];
    %  else
    %      updated_best=Forest.T(Index_of_best,:);
    %      updated_best(1,Forest.P.Dimension+2)=0;
    %      Forest.T(Index_of_best,:)=[];
    %      Forest.T=[updated_best;Forest.T];
    %  end

end