function Forest = FOA(Forest, Eval)

    global check;
    
    bestTree=Forest.T(randi([1 size(Forest.T,1)]),:);
    count=0;
    global show;
    show=zeros(Forest.P.MaxIterations,1);
    
    for i=1:Forest.P.MaxIterations

        Forest=LocalSeeding(Forest,Eval);

        [Forest,candidate]=PopulationLimiting(Forest);

        Forest=GlobalSeeding(candidate,Forest,Eval);

        Forest=PopulationLimiting(Forest);

        [Forest,bestTree]=UpdateBestTree(Forest,bestTree);

        disp(['iter ' num2str(i) ': ' num2str(bestTree(end-1))]);
        show(i,1)=bestTree(end-1);
%         if check
%             break;
%         end
        %     if(changed==1)
        % %         count=count+1;
        % %         if(count==5)
        % %             break;
        % %         end
        %         break;
        %     end
    end


end


