%%Lab3 Biomedical signal processing
%a = load('solides.mat')
load('solides.mat');
load('gazeux.mat');
load('artefacts.mat');
% figure()
% tfrstft(hilbert(gazeux(:,1)));
% figure();
% tfrstft(hilbert(solides(:,1)));
% figure();
% tfrstft(hilbert(artefacts(:,1)));
%  figure();
% tfrspwv(hilbert(gazeux(:,1)));
% figure();
% tfrzam(hilbert(gazeux(:,1)));
% figure();
% tfrwv(hilbert(gazeux(:,1)));
% figure();
% tfrcw(hilbert(gazeux(:,1)));
% figure();
% tfrspwv(hilbert(solides(:,1)));
% figure();
% tfrzam(hilbert(solides(:,1)));
% figure();
% tfrwv(hilbert(solides(:,1)));
% figure();
% tfrcw(hilbert(solides(:,1)));
% figure();
% tfrspwv(hilbert(artefacts(:,1)));
% figure();
% tfrzam(hilbert(artefacts(:,1)));
% figure();
% tfrwv(hilbert(artefacts(:,1)));
% figure();
% tfrcw(hilbert(artefacts(:,1)));
% plot(abs(mean(tfrstft(gazeux(:,1)))));
% figure();
% tfrstft(gazeux(:,1));
% figure();
% tfrzam(hilbert(solides(:,1)));
% figure();
% tfrzam(solides(:,1));%%(try also hilbert)
%%%experiment 2: 
% load('accel.dat');
% x = accel - mean(accel);
% close all,
% plot(x)
% tfrspwv(hilbert(x));
% [es, ei, amp, xmd] = envelopes(x, 21);
% [es, ei, amp, xmd] = envelopes(x, 41);
% %plot(xmd);
% figure();
%plot(hilbert(xmd));
% tfrspwv(hilbert(xmd)); %%logarithmic scale quand il lave ses ma
% %%%%experiment 3 :
load('emg1.dat');
load('emg2.dat');
figure();
tfrstft(emg1(:,1)-mean(emg1(:,1)));
figure();
tfrstft(emg1(:,2)-mean(emg1(:,2)));
figure();
tfrstft(emg1(:,3)-mean(emg1(:,3)));
figure();
 [a, b, c, d]=  envelopes(emg1(:,1)-mean(emg1(:,1)), 45);
 Ind = find(c>0.1*max(c));
 plot(c(Ind));
figure();
 [a1, b1, c1, d1]= envelopes(emg1(:,2)-mean(emg1(:,2)),45);
  Ind = find(c1>0.1*max(c1));
 plot(c1(Ind));
figure();
 [a2, b2, c2, d2]= envelopes(emg1(:,3)-mean(emg1(:,3)),45);
 Ind = find(c2>0.1*max(c2));
 plot(c2(Ind));
 [W,T,F]    = tfrstft(emg1(:,1));
 mean(F)
 [W1,T1,F1] = tfrstft(emg1(:,2));
 mean(F1)
 [W2,T2,F2] = tfrstft(emg1(:,3));
 mean(F2)
% tfrstft(emg1(:,1));%%%change sampling frequ to 1024
% [W,T, F] = tfrstft(emg1(:,1));
% V = abs(W).^2;
% plot(V(:,500));
% figure();
% plot(fftshift(V(:,500)));
% F(1600);
% F(1:1600)'*V(1:1600,500)/sum(V(1:1600, 500));
% plot(F(1:1600),V(1:1600,500));
% plot(emg1(:,1));
% F(1:1600)'*V(1:1600,800)/sum(V(1:1600, 800));
% [W, T, F] = tfrstft(accel-mean(accel));
% V = abs(W).^2;
% plot(V(:,500));
% figure();
% plot(fftshift(V(:,500)));
% F(1600);
% F(1:1600)'*V(1:1600,500)/sum(V(1:1600, 500));
% plot(F(1:1600),V(1:1600,500));
% plot(emg1(:,1));
% F(1:1000)'*V(1:1000,800)/sum(V(1:1000, 800))
% plot(F(1:1000),V(1:1000,1000));
% F(1:1000)'*(V(1:1000)/sum(V(1:1000),1000));
% [W,T,F] = tfrstft(emg2(:,1));
% V = abs(W).^2;
% plot(V(:,500));
% figure();
% plot(fftshift(V(:,500)));
% F(1600);
% F(1:1600)'*V(1:1600,500)/sum(V(1:1600, 500));
% plot(F(1:1600),V(1:1600,500));
% plot(emg1(:,1));
% F(1:1600)'*V(1:1600,800)/sum(V(1:1600, 800));
% [W, T, F] = tfrstft(accel-mean(accel));
% V = abs(W).^2;
% plot(V(:,500));
% figure();
% plot(fftshift(V(:,500)));
% F(1600);
% F(1:1600)'*V(1:1600,500)/sum(V(1:1600, 500));
% plot(F(1:1600),V(1:1600,500));
% plot(emg2(:,1));
% F(1:1000)'*V(1:1000,800)/sum(V(1:1000, 800))
% plot(F(1:1000),V(1:1000,1000));
% F(1:1000)'*(V(1:1000)/sum(V(1:1000),1000));
% [es, ei, amp, xmd]= envelopes(emg1(:,1),41);
% plot(amp)
% Ind = find(amp>0.1*max(amp));
% plot(1:3200, amp, Ind);