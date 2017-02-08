%%exp 2 :
clear all;
clc;
close all;
load 'AF_sync.dat';
a = AF_sync(1:500);
b = AF_sync(2205:2705);
c = AF_sync(4356:4856);

figure();
AR_psd(a, 20, 4, 1, 0);
figure();
AR_psd(b, 20, 4, 1, 0);
figure();
AR_psd(c, 20, 4, 1, 0);