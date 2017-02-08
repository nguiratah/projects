%initialisation des constantes
clear all;
clc
close all;
tf = [961.9 327.5];
tm = 20;
L =[105, 24.1];
K =[419, 33];
Cp = [0.234, 0.129];
Ro = [9.1, 10.3];
for i = 1 : 2
    a(i) = L(i)/(Cp(i)*(tf(i)-tm));
end
beta = [0 0];
for i = 1 : 2
    beta(i) = 1/(2*a(i));
end
for i = 1 :2
    for j =1:1e3
    f(i)  =a(i)*sqrt(pi)*erfv2(beta(i))*exp(beta(i)^2)-1;
    g(i) = 2*(a(i)+1)*beta(i)^2 + 1;
    beta(i) = beta(i)*(1-f(i)/g(i));
    end
end
neta = [1 1];
t = 1 : 0.00001:21;
for i=1 :2
    x(i,:) = 2*beta(i).*sqrt(t);
    length(x(i,:))
    figure();
    z = t(1:length(t)-1);
    plot(z, d iff(x(i,:)));
end

