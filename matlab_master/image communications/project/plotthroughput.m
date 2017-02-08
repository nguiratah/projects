clear all;
clc;
close all;
Z=5000;
%P=0.1+zeros(1, 10);
G = 0.1:0.01:2;
P=[0 0 0.5 0.28 0 0 0 0 0.22];
Cw =20;
%P =[0 1];
Th=zeros(1, length(G));
tic;
w = 0;
parfor k=1 :length(G)
Th(k)=RandomSlottedAlohav3(G(k),P,Z, Cw, k);
k
end
Th=Th.*G;
Toc=toc;
figure();
plot(G, Th, '*');
%title('throughput as a function of G');
title('Error probability as a function of G');
xlabel('G');
ylabel('Error Probability');