clear all;
Fs = 32000;
T1 = 0.5;
t=0.02;
t1=t*Fs;
T=0;
nfft = 2^nextpow2(Fs);
numUniq = ceil((nfft+1)/2);
recObj = audiorecorder(Fs,24,1);
notbegin = true;
i=1;
bool = true;
while(bool)
    recordblocking(recObj, T1);
    %# get data and compute FFT
    sig = getaudiodata(recObj);
    fftMag = 20*log10( abs(fft(sig,nfft)) );
    disp(max(sig))
    if max(sig)> 0.001;
        [M, Indices] = max(fftMag(1:numUniq));
        disp(M)
        disp(Indices)
        bool = false;
        if abs(Indices-1000)<50
            T=5;
            disp(Indices)
        elseif abs(Indices-1200)<50
            T=10;
            disp(Indices)
        elseif abs(Indices-1400)<50
            T=15;
            disp(Indices)
        elseif abs(Indices-1600)<50
            T=20;
            disp(Indices)
        else
            T=30;
            disp(Indices)
        end
    end
end
recObj = audiorecorder(Fs,24,1);
recordblocking(recObj, T);
sig = getaudiodata(recObj);
maxiA=max(abs(sig))
while(notbegin)
    if sig(i,1)>maxiA/8
        notbegin=false;
        sig(i,1);
    end
    iBegin=i;
    i=i+1;
    disp('aaa')
end
beginTime = i/32000;
notStop = true;

n=iBegin;
bContinue = true;
x=[];
while(bContinue)
    maxi2= max(sig(n+t1/4:n+t1*3/4,1));
    %         aMean=mean(abs(sig(n+80:n+240,1)));
    if(maxi2 < maxiA/8.9)
        bContinue = false;
    elseif(maxi2 > maxiA/1.35)
        x=[x,0];
    else
        x=[x,1];
    end
    if mod(n,20)==19
        n=n+t1
    end
    n=n+t1;
    disp('bbb')
    end
q=[];
l=length(x);
m=mod(length(x), 7);
for k = 1:length(x)-m
    q(k)=int2str(x(k));
end
s=char(q);
s=char(bin2dec(reshape(s,7,[]).')).'
