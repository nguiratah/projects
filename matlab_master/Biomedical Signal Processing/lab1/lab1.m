%% Experiment 1 :

close all;
clear all;
clc;
load('ecg.dat');
g =fir1(100, 0.16);
[H1, W1] = freqz(g,1, 2000);
%We need 101 filter coefficients because we want to have a symmetric plot,
%we use a normalized cutoff frequency of 0.08 (0.16 with matlab convention)
%for the frequency response, we have a denominator = 1 and to plot 2000
%points we tape : freqz(g, 1, 2000);

[N, Wn]= buttord(0.14, 0.18, 0.5, 20);
[b, a] = butter(N, Wn);
[H2, W2] = freqz(b, a, 2000);
%in this part we find the needed order of the butterworth filter in order
%to achieve our specifications (N) and the natural Butterworth frequency 
%(Wn)
%We need a passband edge frequency = 0.14, stopband edge frequency = 0.18, 
%a passband ripple = 0.5 and a stopband attenuation of at least 20dB
%The second command constructs a butterworth filter with order N and natural
%frequency Wn and gives us two vectors : the numerator and denominator.

fr  = linspace(0, 0.5, 2000);
figure();
plot(fr,abs(H1), 'r');
hold on;
plot(fr, abs(H2), 'g');
hold off;
%we can check that they have similar amplitude.

n=150;
f=0.05;
x = sin(2*pi*f*(1:n));
y1 = filter(g, 1, x);
y2= filter(b, a, x);
figure();
plot((1:n),y1, 'r'); 
hold on
plot((1:n),y2, 'g');
hold off
%we can see that the butterworth filter has the shortest transition.

ecg1=filter(g,1, ecg);
ecg2=filter(b, a,ecg);
ecg3=filtfilt(b, a, ecg);

figure();
subplot(4, 1, 1);
plot(ecg);
subplot(4, 1, 2);
plot(ecg1);
subplot(4, 1, 3);
plot(ecg2);
subplot(4, 1, 4);
plot(ecg3);

%we can see that the 50 hz interference has been cancelled by all the
%filters.

