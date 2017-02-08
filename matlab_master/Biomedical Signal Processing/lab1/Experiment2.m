%%Experiment 2:

close all;
clear all;
clc;

fe = 1000;
M = load('mesurepoutre.dat');
M = resample(M, 1, 100);
[N, Wn]= cheb1ord(0.06, 0.1, 0.5, 20);
[b, a] =cheby1(N, 0.5, Wn);
H = filtfilt(b,a, M);
figure();
plot((1:length(M)),M,(1:length(M)), H, 'r')

%%Part 3

xa= hilbert(H);
figure();
plot((1:length(M)), H, (1:length(M)), abs(xa), 'r');

%%part 4

phi = unwrap(angle(xa));
g =diffe(11, fe/100);
figure();
stem(g);
f = filter(g, 1, phi)/(2*pi);
figure();
plot(abs(f))
