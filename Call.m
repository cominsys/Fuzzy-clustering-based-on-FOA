clc;
clear;
close all;

global Data;
global c;
rep=1;

dataset= questdlg('Choose Dataset Name: ','Choose Dataset','wine',...
    'vowel','LiverDisorder','wine');

TempData=load(dataset);
Data=TempData.data(:,1:end-1);


%[z,U,f]=FCM(Data,c);
%Data=[-1.2;.5;.6;.7;1.5;1.6;1.7;1.8];
%[center,up,obj]=fcm(Data,c);


PC1=zeros(1,rep);
PE1=zeros(1,rep);
XB1=zeros(1,rep);
f1=zeros(1,rep);

%[z,u,f]=FWFCM(Data,c);

% global best;
% best=reshape(z',[1,c*4]);
choice= questdlg('Choose Algorithm: ','Menu','FOA','Ga','PSO','FOA');

c=2;

for i=1:rep
    disp(['Iter ' num2str(i) ':']);
    
    [z,u,f1(i)]=CPSO(choice);
    
    %[z,u,f1(i)]=FCM(Data,c,z);
        
    %[z,u,f]=fcm(Data,c,[2,100,-inf]);
    %f1(i)=f(end);
    
    [PC1(i),PE1(i),XB1(i)]=ClusterValidity(u,z);
    
end

PCMean=mean(PC1);
PCstd=std(PC1);
PEMean=mean(PE1);
PEstd=std(PE1);
XBMean=mean(XB1);
XBstd=std(XB1);
fmean=mean(f1);
fstd=std(f1);

% [zp,up,fp]=FWFCM(Data,3);
%
% global show;
% global fwfcmrst;
% figure;
% plot(show,'LineWidth',2);
%
% hold on;
% plot(fwfcmrst','-.');
% legend('FOFWFCM','FWFCM');

%% Add Feature Weighting
% [zp,up,fp]=BCGFWFCM(Data,c,u);
%
% [PC2,PE2]=ClusterValidity(up);
% PCMean2=mean(PC2);
% PEMean2=mean(PE2);

