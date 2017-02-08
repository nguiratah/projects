clear all;
close all;
x = AR2(100);
r= xcorr(x);
figure;
stem(-99:99,r);
[a, e] = aryule(r, 2);
A = arcov(x, 2);
%%%%%% prof: 
R = [r(100), (r101); r(101), r(100)];
b = [r(101),r(102) ];
a2=-inv(R)*b;


aryule(x, 2);
Xe
X = [x(2:99) x(1:98)];
c = x(3:100); 
X = [0 0 X];
% ce = x;
% ce = [ce; [0; 0]];
load right_foot;
