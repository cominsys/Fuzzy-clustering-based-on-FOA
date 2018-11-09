function [Jm,f]=FitnessFunction(particle)
    
global Data,

s=size(Data,2);

%% Calculate Z

z=DecodeParticle(particle,s);

%% Calculate U

U=CalculateU(z);

%% Calculate Jm

Jm=CalculateJm(U,z);
%% Calculate f

f=1/(1+Jm);

end