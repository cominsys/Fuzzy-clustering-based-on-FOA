% This program is implemented by Manizheh Ghaemi (Author of article "Forest Optimization Algorithm")
% This program is distributed in the hope that it will be 
% useful, but WITHOUT ANY WARRANTY; EXPRESS OR IMPLIED.
% Questions/Comments: Please email Manizheh Ghaemi at:
% Manizheh.Ghaemi@yahoo.com.
% Proper Acknowledgements and authorship should be assured
% © Copyright Ghaemi
% 8/3/2014 University of Tabriz, Tabriz, Iran

function Forest=main(Forest) 

    Eval = @FitnessFunction;
    
    global check;
    check=false;
    global tolerance;
    tolerance=0;
        
    Forest=FOA(Forest,Eval);
end
