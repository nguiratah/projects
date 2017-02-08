clear all;
close all;
snrdB = -10:10;
snr = 10.^(snrdB/10);
N = [3 9];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plug in the formula of error probability

% soft decision
Psoft = ones(length(N),length(snr))*0.5;

% hard decision
Phard = ones(length(N),length(snr))*0.5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);      
semilogy(snrdB,Phard(1,:),'r-x'); hold on;
semilogy(snrdB,Psoft(1,:),'b-o');

semilogy(snrdB,Phard(2,:),'r-*'); 
semilogy(snrdB,Psoft(2,:),'b-d');

legend1 = legend('$N=3$ (hard)','$N=3$ (soft)','$N=9$ (hard)','$N=9$ (soft)');
set(legend1,'Interpreter','latex','Location','NorthEast','FontSize',12);
xlabel('${\cal E}/N_0$ (dB)','Interpreter','latex','FontSize',16);
ylabel('Bit error probability','Interpreter','latex','FontSize',16);
xlim([snrdB(1)-0.01 snrdB(end)+0.01]);
ylim([1e-6 1]);