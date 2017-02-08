%%Exp4
load('EEG_stim.dat')
Repos = EEG_stim(:,1);
Stim1 = EEG_stim(:,2);
Stim100 = EEG_stim(:,3);
figure();
[f,P,s] = pisarenko(Repos,5,512);
figure();
[f1,P1,s1] = pisarenko(Stim1,5,512);
figure();
[f2,P2,s2] = pisarenko(Stim100,5,512);