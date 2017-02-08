%%Lab 2 : 
close all;
clear all;
clc;
%%Experiment 1 : 
file1 = load('ecg.dat');
figure();
pwelch(file1,500,[], [], 500);%%(we can see that we have a pic at 50 hz : 50 hz interference. ) :It's the best signal representation (500 it's enough to have a good representation)
%%Experiment 2 : 
load heart_1.dat;
RR=heart_1(:,1);
BP=heart_1(:,2);
Resp=heart_1(:,3);
figure();
subplot(3, 1, 1);
plot(RR);
subplot(3, 1, 2);
plot(BP);
subplot(3, 1, 3);
plot(Resp);
[P, f] = pwelch(RR-mean(RR), 500, [], [], 4);
Ind = find(f<=0.4);
figure();
subplot(311)
plot(f(Ind), P(Ind));
[P, f] = pwelch(BP-mean(BP), 500, [], [], 4);
Ind = find(f<=0.4);
subplot(312)
plot(f(Ind), P(Ind));
[P, f] = pwelch(Resp-mean(Resp), 500, [], [], 4);
Ind = find(f<=0.4);
subplot(313)
plot(f(Ind), P(Ind));
%%heart 2

load heart_2.dat
RR2=heart_2(:,1);
BP2=heart_2(:,2);
Resp2=heart_2(:,3);
figure();
subplot(3, 1, 1);
plot(RR2);
subplot(3, 1, 2);
plot(BP2);
subplot(3, 1, 3);
plot(Resp2);
[P, f] = pwelch(RR2-mean(RR2), 500, [], [],4);
Ind = find(f<=0.4);
figure();
subplot(311)
plot(f(Ind), P(Ind));
[P, f] = pwelch(BP2-mean(BP), 500, [], [], 4);
Ind = find(f<=0.4);
subplot(312)
plot(f(Ind), P(Ind));
[P, f] = pwelch(Resp-mean(Resp), 500, [], [], 4);
Ind = find(f<=0.4);
subplot(313)
plot(f(Ind), P(Ind));

%%Exp2 : 2.2 : 
fe = 4;
[P, f] = pwelch(RR-mean(RR), 500, [], [], 4);
Puis = (fe/length(P))*sum(P(find((f>=0.04)&(f<0.15))));
[P, f] = pwelch(RR2-mean(RR2), 500, [], [], 4);
Puis2 = (fe/length(P))*sum(P(find((f>=0.04)&(f<0.15))));
diff = (Puis2-Puis);

%%The difference between these two RR-interval signal power is very
%%important. Then, we can see that drinking alcohols slowed the heart beats
%% and the difference betwwen the rr-intervals at these frequencies is equal to -1.904848638230817e+03 (rr_after alcohols -rr_before alcohols)

%%Exp 2.3 : 
RR_resamp =  resample(RR-mean(RR), 2, 4);
[N,wn]=cheb1ord(0.04,0.05,0.5,20);
[b1,a1] = cheby1(N,0.5,wn);
Y1= filtfilt(b1, a1, RR_resamp);
[N,wn]=cheb1ord([0.05 0.14],[0.03 0.16],0.5,20);
[b2,a2] = cheby1(N,0.5,wn);
Y2= filtfilt(b2, a2, RR_resamp);
[N,wn]=cheb1ord([0.16 0.39],[0.14 0.41],0.5,20);
[b3,a3] = cheby1(N,0.5,wn);
Y3= filtfilt(b3, a3, RR_resamp);
figure();
hold on;
subplot(411);
plot(RR_resamp);
subplot(412);
plot(Y1);
subplot(413);
plot(Y2);
subplot(414);
plot(Y3);

%%Exp 2.4 :
BP_resamp =  resample(BP-mean(BP), 2, 4);
[N,wn]=cheb1ord(0.04,0.05,0.5,20);
[b1,a1] = cheby1(N,0.5,wn);
Y1= filtfilt(b1, a1, BP_resamp);
[N,wn]=cheb1ord([0.05 0.14],[0.03 0.16],0.5,20);
[b2,a2] = cheby1(N,0.5,wn);
Y2= filtfilt(b2, a2, BP_resamp);
[N,wn]=cheb1ord([0.16 0.39],[0.14 0.41],0.5,20);
[b3,a3] = cheby1(N,0.5,wn);
Y3= filtfilt(b3, a3, BP_resamp);
BP2_resamp =  resample(BP2-mean(BP2), 2, 4);
[N,wn]=cheb1ord(0.04,0.05,0.5,20);
[b1,a1] = cheby1(N,0.5,wn);
Y1= filtfilt(b1, a1, BP2_resamp);
[N,wn]=cheb1ord([0.05 0.14],[0.03 0.16],0.5,20);
[b2,a2] = cheby1(N,0.5,wn);
Y2= filtfilt(b2, a2, BP2_resamp);
[N,wn]=cheb1ord([0.16 0.39],[0.14 0.41],0.5,20);
[b3,a3] = cheby1(N,0.5,wn);
Y3= filtfilt(b3, a3, BP2_resamp);
[P1, f1] = pwelch( BP_resamp, 500, [], [], 2);
[P2, f2] = pwelch( BP2_resamp, 500, [], [], 2);
figure();
plot([0.4/103:0.4/103:0.4], xcorr(P1(find(f<=0.4)), P2(find(f<=0.4))));