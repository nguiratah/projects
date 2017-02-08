% ADC Homework 10 Problem 1 "Comparison of MIMO detectors"
% In this exercise, we simulate a 3x4 MIMO system assuming a V-BLAST architecture.
% The modulation is QPSK. We implement the ML detector, the
% Zero-Forcer, and the MMSE detector. 

clear all;
close all;

% SNR range 
SNR_dB = 0 : 12;
SNR = 10.^(SNR_dB/10);

% simulaiton time
T = 1e6;

% Generate Bernoulli(1/2) information symbols
S = (1-sign(rand(6,T)-0.5))/2;

% map the information symbols on the QPSK constellation
X = [(1-2*S(1,:))+ 1i*(1-2*S(2,:)); ...
     (1-2*S(3,:))+ 1i*(1-2*S(4,:)); ...
     (1-2*S(5,:))+ 1i*(1-2*S(6,:))];

% channel matrix 
H = [     1 0.8     1i;
        0.8   1 0.5*1i;
     0.5*1i   1    0.8;
         1i 0.8      1];
 
% To reduce the computation, we multiply the symbols 
% by the channel matrix once for all 
HX = H*X;

BER_ML = zeros(1,length(SNR));
BER_ZF = zeros(1,length(SNR));
BER_MMSE = zeros(1,length(SNR));

% The following are useful for the ML detection
% all possible bit combinations
aS = [zeros(1,32) ones(1,32); ...
      repmat([zeros(1,16) ones(1,16)],1,2); ...
      repmat([zeros(1, 8) ones(1, 8)],1,4); ...
      repmat([zeros(1, 4) ones(1, 4)],1,8); ...
      repmat([zeros(1, 2) ones(1, 2)],1,16); ...
      repmat([zeros(1, 1) ones(1, 1)],1,32)];
% again, map on the constellation
aX = [(1-2*aS(1,:))+ 1i*(1-2*aS(2,:)); ...
      (1-2*aS(3,:))+ 1i*(1-2*aS(4,:)); ...
      (1-2*aS(5,:))+ 1i*(1-2*aS(6,:))];

for p = 1 : length(SNR)
    
% send the signals through the MIMO channel
Y = HX + (randn(4,T)+1i*randn(4,T))/sqrt(2)/sqrt(SNR(p));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ML detector
diff = zeros(64,T);
for n = 1 : 64
    diff(n,:) = sum(abs(Y-diag(H*aX(:,n))*ones(4,T)).^2,1);
end
[dummy index] = min(diff,[],1);
S_ML = aS(:,index);

% Zero-Forcer
Y_ZF = (H'*H)\(H'*Y);
dummy = [real(Y_ZF(1,:)); ...
         imag(Y_ZF(1,:)); ...
         real(Y_ZF(2,:)); ...
         imag(Y_ZF(2,:)); ...
         real(Y_ZF(3,:)); ...
         imag(Y_ZF(3,:))];
S_ZF = (1-sign(dummy))/2;

% MMSE detector
Y_MMSE = H'*((H*H'+eye(4)/SNR(p))\Y);
dummy = [real(Y_MMSE(1,:)); ...
         imag(Y_MMSE(1,:)); ...
         real(Y_MMSE(2,:)); ...
         imag(Y_MMSE(2,:)); ...
         real(Y_MMSE(3,:)); ...
         imag(Y_MMSE(3,:))];
S_MMSE = (1-sign(dummy))/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
count = reshape(S-S_ML,1,6*T);
BER_ML(p) = length(count(count~=0))/(6*T);

count = reshape(S-S_ZF,1,6*T);
BER_ZF(p) = length(count(count~=0))/(6*T);

count = reshape(S-S_MMSE,1,6*T);
BER_MMSE(p) = length(count(count~=0))/(6*T);
end

figure(1);
semilogy(SNR_dB,BER_ZF,'g-o'); hold on;
semilogy(SNR_dB,BER_MMSE,'r-*');
semilogy(SNR_dB,BER_ML,'b-d');

legend1 = legend('Zero-Forcer','MMSE detector','ML detector');
set(legend1,'Interpreter','latex','Location','NorthEast','FontSize',12);
xlabel('${\cal E}/N_0$ (dB)','Interpreter','latex','FontSize',16);
ylabel('Bit error probability','Interpreter','latex','FontSize',16);
xlim([SNR_dB(1)-0.001 SNR_dB(end)+0.001]);
ylim([1e-4 1]);