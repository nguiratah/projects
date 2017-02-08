%function[V]= optimize(G,P,Z, Cw, a, b, c)
close all;
clear all;
clc;
PlotsRD;
Load =0.7;
Cw= 20;
Z=80;
vectors = Prob_vect(1);
L = L_vect3(Cw*Load);
g = size(vectors);
g1= size(L);
tic;
for w=1:g(1)
for h=1:g(1)
    for l=1:g(1)
    parfor x = 1:g1(1)
        Dis(w,h,l,x)=RandomSlottedAlohav3Distortion3classes(Load,vectors(w, :),vectors(h,:),vectors(l,:),Z, Cw, RD1, RD2, RD3, L(x,1), L(x, 2));
        [w*100/g(1) 100*h/g(1) l*100/g(1)] 
    end
    end
end
end
Toc = toc;
Results=Dis;
Y=min(Dis(:));
[W,J,K,X]=ind2sub(size(Dis), find(Dis==Y));
P0= vectors(W,:);
P1= vectors(J,:);
P2= vectors(K,:);
RateAlloc = L(X,:);