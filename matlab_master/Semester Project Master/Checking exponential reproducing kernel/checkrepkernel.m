clear all;
clc;
close all;
alpha=[0, pi/2, pi, 3*pi/2];
n=0:5:20;
w=2*pi*(0:0.05:0.95);
t=0:1:19;
samplingkernelfft=beta(alpha);
samplingkernelnfft=[];
for k=1:length(n)
    samplingkernelnfft=[samplingkernelnfft,(exp(-1i*w*n(k)).*samplingkernelfft)'];
end
samplingkerneln=ifft(samplingkernelnfft);
c1=1/samplingkernelfft(1);
c=c1*exp(-1i*alpha(1)*n);
%plot(abs(c*samplingkerneln'));
z = c*samplingkernelnfft'