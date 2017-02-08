%function[V]= optimize(G,P,Z, Cw, a, b, c)
close all;
clear all;
clc;
PlotsRD;
Load = 0.7;
Cw= 40;
Z= 500;
vectors = Prob_vect(1);
g = size(vectors);
L1 = round(Load*Cw/3);
L2 = round(Load*Cw/3);
tic;
for w=1:g(1)
for h=1:g(1)
    parfor l=1:g(1)
        Dis(w,h,l)=RandomSlottedAlohav3Distortion3classes(Load,vectors(w, :),vectors(h,:),vectors(l,:),Z, Cw, RD1, RD2, RD3, L1, L2);
        [w*100/g(1) 100*h/g(1) l*100/g(1)] 
    end
end
end
Toc = toc;
Results=Dis;
[Y,idx]=min(Dis(:));
[W,J,K]=ind2sub(size(Dis),idx);
P0= vectors(W,:);
P1= vectors(J,:);
P2= vectors(K,:);