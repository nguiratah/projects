close all;
clc;
clear all;
load 'heart_5.dat';
a = heart_5(1:508,1)-mean(heart_5(1:508,1));
b = heart_5(509:1016,1)-mean(heart_5(509:1016,1));
c = heart_5(1017:1524,1)-mean(heart_5(1017:1524,1));
d = heart_5(1525:2032,1)-mean(heart_5(1525:2032,1));
e = heart_5(2033:2540,1)-mean(heart_5(2033:2540,1));

[x1, y1] = aryule(a,5);
[x2, y2] = aryule(b,5);
[x3, y3] = aryule(c,5);
[x4, y4] = aryule(d,5);
[x5, y5] = aryule(e,5);

z = corrcoef(x1, x5);
figure();
plot(x1, 'r');
hold on;
plot(x5, 'b');

figure();
plot(x2, 'r');
hold on;
plot(x4, 'b');

