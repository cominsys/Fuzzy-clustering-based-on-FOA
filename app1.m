clc;
clear;
close all;

global m;
m=2;
global c;
c=6;
global Data;
rep=50;


Data1=load('wine.data');
Data=Data1(:,1:end-1);

PC=zeros(1,50);
PE=zeros(1,50);
XB=zeros(1,50);
f=zeros(1,50);


for i=1:50
    [z,u,ftemp]=fcm(Data,3);
    f(i)=ftemp(end);
    [PC(i),PE(i),XB(i)]=ClusterValidity(u',z);
end

PCMean=mean(PC);
PCstd=std(PC);
PEMean=mean(PE);
PEstd=std(PE);
XBMean=mean(XB);
XBstd=std(XB);
fmean=mean(f);
fstd=std(f);