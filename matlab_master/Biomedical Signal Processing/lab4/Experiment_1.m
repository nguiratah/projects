clear all;
close all;
clc;
x=AR2(100);
r=xcorr(x);
figure();
stem(-99:99,r);
[a,e]=aryule(r,2)
[a,e]=arcov(r,2)

% 
% X=[x(2:99) x(1:98)];
% Xe=[[x(1) 0];Xe];
% Xe=[[0 0];Xe];
% Xe=[Xe; [x(100) x(99)];
% Xe=[Xe;[0 x(100)]];
% ce=x;
% ce=[ce;[0;0]];
% aryule(x,2);
% 
% b1=arcov(x,2);

x=AR2(100);

