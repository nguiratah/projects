function [y,g] = eigenfilter(x,M,fs);

% [y,g] = eigenfilter(x,M,fs);
% Computation of eigenfilter of length M for signal x sampled at fs Hz
% outputs:  y filter output, g filter

x = x(:);
N = length(x);
N4 = round(N/4);

X = [];
for k=1:M,
   X = [X x(M-k+1:N-k+1)];
end

[U,S,V]=svd(X);
g = V(:,1);
h = freqz(g,1,5000);
g = g/max(abs(h));
y = filtfilt(g,1,x);

figure(1)
subplot(211)
plot(x)
title('original signal')
subplot(212)
plot(y)
title('output signal')
subplot(111)

figure(2)
subplot(311)
P=psd(x,N4,fs,hamming(N4));
plot(linspace(0,fs/2,length(P)),P);
title('psd original signal')
subplot(312)
P=freqz(g,1,1000);
plot(linspace(0,fs/2,1000),abs(P));
title('filter frequency response')
subplot(313)
P=psd(y,N4,fs,hamming(N4));
plot(linspace(0,fs/2,length(P)),P);
title('psd output signal')
