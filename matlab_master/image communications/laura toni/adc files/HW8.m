%%HW 8
clear all;
clc;
close all;
gammadb =0:0.01:15;
gamma = 10.^(gammadb/10);
PeRayleigh = 1/2*(1-sqrt(gamma./(2+gamma)));
PeFix= qfunc(gamma);
semilogy(gammadb, PeRayleigh,'b', gammadb, PeFix,'r');

