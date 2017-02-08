%function[V]= optimize(G,P,Z, Cw, a, b, c)
close all;
clear all;
clc;
PlotsRD;
Load = 0.7;
Cw= 40;
Z=300;
vectors = Prob_vect(1);
g = size(vectors);
Dis = zeros(1, g(1));
L1 =round((Load*Cw)/6);
L2 =(Load*Cw)-L1
tic;
for h=1:g(1)
    parfor l=1:g(1)
        Dis(h,l)=RandomSlottedAlohav3Distortion2classes(Load,vectors(h,:),vectors(l,:),Z, Cw, RD1 ,RD2, L1);
        [l*100/g(1) 100*h/g(1)] 
    end
end
Toc = toc;
Results=Dis;
Y=min(Dis(:));
[J, K]=find(Dis==Y);
P1= vectors(J,:);
P2= vectors(K,:);