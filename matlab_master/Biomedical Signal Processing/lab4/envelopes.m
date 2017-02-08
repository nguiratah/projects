function [es,ei,amp,xmd] = envelopes(x,M);

% [es,ei,amp,xmd] = envelopes(x,M);
% upper and lower envelope estimation
% x signal  
% M window length, must be odd
% es upper envelope, ei lower envelope 
% amp half of the envelope difference, i.e. instantaneous envelope
% xmd signal minus half envelope sum, i.e. signal without drift

L = round((M-1)/2);

x = x(:);
z = [flipud(x(1:M)) ; x ; flipud(x(end-M+1:end))];
ws = zeros(size(z));
wi = zeros(size(z));

K = length(z);
for k=1:K,
    ws(k) = max(z(max(1,k-L):min(K,k+L)));
    wi(k) = min(z(max(1,k-L):min(K,k+L)));
end

g = fir1(M,0.1);
ws = filtfilt(g,1,ws);
wi = filtfilt(g,1,wi);

es = ws(M+1:end-M);
ei = wi(M+1:end-M);
amp = (es-ei)/2;
xmd = x - (es+ei)/2;

t=1:length(x);
plot(t,x,t,es,'r',t,ei,'g')
title('bleu: signal, rouge,vert: enveloppes')
    
