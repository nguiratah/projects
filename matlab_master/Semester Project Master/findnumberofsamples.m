w = [];
sigma= 0;
trials =1;
Ts=0.01;
K=  200;
shift = 0.55;
for p =2:K
    p
    [w1]=checkrepkernelfuntimev2(p, trials, sigma, Ts, K, shift);
    w = [w,w1];
end
p =2:K;
figure();
plot(p, (abs(w-shift)))
title('Non sparse signal')
xlabel('Number of samples');
ylabel('absolute shift error');
%title('random shift, SNR=2')
% 
% w = [];
% sigma= 0.5;
% trials =800;
% Ts=0.01;
% K=  50;
% shift = 5.5;
% for p =2:50
%     p
%     [w1]=Copy_of_checkrepkernelfuntimev2(p, trials, sigma, Ts, K, shift);
%     w = [w,w1];
% end
% p =2:50;
% figure();
% plot(p, abs(w))
% title('sparse signal')
% xlabel('Number of samples');
% ylabel('absolute shift error');
% title('random shift, SNR=2')
