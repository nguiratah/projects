% ADC HW7 Problem 2 "water-filling"
clear all;
close all;
% the length of an OFDM symbol
N=1024;
% total bandwidth
W=1e6;
% power spectral density of AWGN
N0=1e-6;
% channel coefficients in time domain
h = zeros(N,1);
tap = [0 1 3 6 10 15].';
h(tap+1) = (-1).^tap./sqrt(tap+1);
% magnitude-squared channel coefficients in frequency domain
H = fft(h);
H2 = abs(H).^2;
recH2 = 1./H2; % reciprocal
% power 
power = 0:0.01:100;
% capacity
capacity = zeros(1,length(power));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Implement the water-filling algorithm here.
X= W*N0./(N*H2);
X= sort(X)
H2 = -sort(-H2);
G = power;
for n = 1 : length(power)
    Y=X;
    i=1;
    while(G(n)>0 && i<N)
    a =G(n);
    G(n) = G(n)-i*(Y(i+1)-Y(i));
    Y(1:i) = Y(i+1);
    i=i+1;
    end
    if G(n)<0
    for j=1:i-1
        Y(j) = X(i-1);
    end
    Y(1:i) = Y(1:i)+a/i;
    end
    if (i==N &&G(n)>0)
        Y(1:N)=Y(1:N)+G(n)/N;
    end
    P=Y-X;
    for i=1:N    
    capacity(n) = capacity(n)+(W/N)*log2(1+(H2(i)*P(i)*N/(W*N0)));
    end
end
plot(capacity, power);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
plot(power,capacity);
grid on;
title('Capacity of the OFDM system');
xlabel('Power (W)');
ylabel('Capacity (bits/s/Hz)');