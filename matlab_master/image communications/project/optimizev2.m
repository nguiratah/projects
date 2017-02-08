%function[V]= optimize(G,P,Z, Cw, a, b, c)
close all;
clear all;
clc;
tic;
% a = 20;
% b= 30;
% c= 50;
PlotsRD;
G = 0.7;
Cw= 40;
Z=1000;
A=RD2;
vectors = Prob_vect(1);
g = size(vectors);
Dis = zeros(1, g(1));
parfor l=1:g(1)
        Dis(l)=RandomSlottedAlohav3Distortion(G,vectors(l,:),Z, Cw, A(1) ,A(2), A(3));
        [l*100/g(1)]
end
Results=Dis;
Y =min(Dis(:));
[~,J]=find(Dis==Y);
V= vectors(J,:);
Toc =toc;