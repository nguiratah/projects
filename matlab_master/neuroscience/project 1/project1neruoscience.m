clc
close all;
%Project 1 part 1
%Statistical neuroscience
%part a : conspecific
% spikes1 = dlmread('matlabSTRF/data/l2a_good/conspecific/spike1');
% A1 = spikes1(1,:);
% stem(A1, ones(length(A1)));
% xlabel('spike times (ms)');
% title('Spike times');
%step2
[stimulus, FS]= audioread('7ADA8D187793063A4E5DC447755047D9.wav');
figure();
plot(stimulus);
xlabel('sample');
ylabel('amplitude');
figure();
%plot(fftshift(abs(fft(stimulus,FS))));
Fe = 32000;
N = length(stimulus);
df = Fe /N ;
f = -16000: df :16000-df ;
X = fftshift(abs(fft(stimulus)));
plot(f , X );
xlabel('Frequency [Hz]');
ylabel('Amplitude');
axis([ -16000 16000 0 100]);
set(gcf, 'color', [1 1 1]);
sound(stimulus, Fe)

