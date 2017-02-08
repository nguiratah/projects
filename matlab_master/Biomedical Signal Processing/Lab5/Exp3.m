%%Exp3
close all;
clear all;
clc;
load('heart_1.dat');
load('heart_2.dat');
load('heart_4.dat');
RR1= heart_1(:,1)-mean(heart_1(:,1));
RR2= heart_2(:,1)-mean(heart_2(:,1));
RR4= heart_4(:,1);
Pr1=heart_1(:,2)-mean(heart_1(:,2));
Pr2=heart_2(:,2)-mean(heart_2(:,2));
Pr4=heart_4(:,2);
Resp1=heart_1(:,3)-mean(heart_1(:,3));
Resp2=heart_2(:,3)-mean(heart_2(:,3));
Resp4=heart_4(:,3);
RR1= downsample(RR1,4);
RR2= downsample(RR2,4);
RR4= downsample(RR4,4);
RR4= envelopes(RR4,31);
Pr1= downsample(Pr1,4);
Pr2= downsample(Pr2,4);
Pr4= downsample(Pr4,4);
Pr4= envelopes(Pr4, 31);
Resp1=downsample(Resp1, 4);
Resp2=downsample(Resp2, 4);
Resp4=downsample(Resp4, 4);
Resp4=envelopes(Resp4, 31);
RR4 = RR4-mean(RR4);
Pr4 = Pr4-mean(Pr4);
Resp4 =Resp4-mean(Resp4);
figure();
AR_psd(RR1, 15,1,10, 0);
figure();
AR_psd(RR2, 15,1,10, 0);
figure();
AR_psd(RR4, 25, 1, 10, 0);
figure();
AR_psd(Pr1, 15,1,10, 0);
figure();
AR_psd(Pr2, 15,1,10, 0);
figure();
AR_psd(Pr4, 25, 1, 10, 0);
figure();
AR_psd(Resp1, 15,1,10, 0);
figure();
AR_psd(Resp4, 25, 1, 10, 0);
figure();
AR_psd(Resp2, 15,1,10, 0);
PSDRR1 = fft(xcorr(RR1, RR1));
PSDRR2 = fft(xcorr(RR2, RR2));
PSDRR4 = fft(xcorr(RR4, RR4));
PSDPr1 = fft(xcorr(Pr1, Pr1));
PSDPr2 = fft(xcorr(Pr2,Pr2));
PSDPr4 = fft(xcorr(Pr4, Pr4));
PSDResp1 = fft(xcorr(Resp1, Resp1));
PSDResp2 = fft(xcorr(Resp2, Resp2));
PSDResp4 = fft(xcorr(Resp4, Resp4));
figure();
plot(abs(fftshift(PSDRR1)));
title('PSD RR1');
xlabel('frequency HZ')
ylabel('PSD RR1')
figure();
plot(abs(fftshift(PSDRR2)));
title('PSD RR2');
xlabel('frequency HZ')
ylabel('PSD RR2')
figure();
plot(abs(fftshift(PSDRR4)));
title('PSD RR4');
xlabel('frequency HZ')
ylabel('PSD RR4')
figure();
plot(abs(fftshift(PSDPr1)));
title('PSD Pression1');
xlabel('frequency HZ')
ylabel('PSD Pression1')
figure();
plot(abs(fftshift(PSDPr2)));
title('PSD Pr2');
xlabel('frequency HZ')
ylabel('PSD Pr2')
figure();
plot(abs(fftshift(PSDPr4)));
title('PSD Pr4');
xlabel('frequency HZ')
ylabel('PSD Pr4')
figure();
plot(abs(fftshift(PSDResp1)));
title('PSD Resp1');
xlabel('frequency HZ')
ylabel('PSD Resp1')
figure();
plot(abs(fftshift(PSDResp2)));
title('PSD Resp2');
xlabel('frequency HZ')
ylabel('PSD Resp2')
figure();
plot(abs(fftshift(PSDResp4)));
title('PSD Resp4');
xlabel('frequency HZ')
ylabel('PSD Resp4')