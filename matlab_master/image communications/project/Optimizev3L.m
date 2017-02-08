%function[V]= optimize(G,P,Z, Cw, a, b, c)
close all;
clear all;
clc;
PlotsRD;
Load = 0.7;
Cw= 20;
Z=100;
L1 = L_vect(Load*Cw);
w = size(L1);
vectors = Prob_vect(1);
g = size(vectors);
Dis = zeros(1, g(1));
tic;
for h=1:g(1)
    for l=1:g(1)
        parfor x=1:w(1)
            Dis(h,l,x)=RandomSlottedAlohav3Distortion2classes(Load,vectors(h,:),vectors(l,:),Z, Cw, RD1 ,RD2, L1(x,1));
            [l*100/g(1) 100*h/g(1)] 
        end
    end
end
Toc = toc;
Results=Dis;
[Y,idx]=min(Dis(:));
[W,J,K]=ind2sub(size(Dis),idx);
P1= vectors(W,:);
P2= vectors(J,:);
Ralloc = L1(K,:);