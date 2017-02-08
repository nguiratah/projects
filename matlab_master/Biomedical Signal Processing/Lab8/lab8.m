%%lab 8
%%%Exp1
load('EEG_ap.dat');
load('EEG_av.dat');
load('EEG_pe.dat');
EEG_ap = EEG_ap-kron(ones(length(EEG_ap), 1), mean(EEG_ap, 1));
EEG_ap = EEG_ap./kron(ones(length(EEG_ap), 1), std(EEG_ap, 1));
EEG_av = EEG_av-kron(ones(length(EEG_av), 1), mean(EEG_av, 1));
EEG_av = EEG_av./kron(ones(length(EEG_av), 1), std(EEG_av, 1));
EEG_pe = EEG_pe-kron(ones(length(EEG_pe), 1), mean(EEG_pe, 1));
EEG_pe = EEG_pe./kron(ones(length(EEG_pe), 1), std(EEG_pe, 1));
[ap11, ap12, ap13] = svd(EEG_ap,0);
ap12 = ap12/max(max(ap12));
[pe11, pe12, pe13] = svd(EEG_pe,0);
pe12 = pe12/max(max(pe12));
[av11, av12, av13] = svd(EEG_av,0);
av12 = av12/max(max(av12));
%%Exp2 : 
load('P09S03_dist.dat');
signal = (P09S03_dist(:,1:3))
signal(:,1) = (signal(:,1)- mean(signal(:,1)))/std(signal(:,1));
signal(:,2) = (signal(:,2)- mean(signal(:,2)))/std(signal(:,1));
signal(:,3) = (signal(:,3)- mean(signal(:,3)))/std(signal(:,1));
s = svd(signal,0);
s = s.*s;
a = cumsum(s)/sum(s);
signal2(:,1) = (signal2(:,1)- mean(signal2(:,1)))/std(signal2(:,1));
signal2(:,2) = (signal2(:,2)- mean(signal2(:,2)))/std(signal2(:,2));
signal2(:,3) = (signal2(:,3)- mean(signal2(:,3)))/std(signal2(:,1));
s2 = svd(signal2,0);
s2 = s2.*s2;
a2 = cumsum(s2)/sum(s2),
%%Exp3
load('AA_Valve.mat')
a1 = AA(:,1:6);
a2 = AA(:,7:12);
[a11, a12, a13]=svd(a1,0);
[a21, a22, a23]=svd(a2,0);
sa = svd(AA,0);
sa = sa.*sa;
aa =  cumsum(sa)/sum(sa)
