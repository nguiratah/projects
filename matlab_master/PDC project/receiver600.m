clear all;
t=0.1;
Fs = 32000;
t1=Fs*t;
% T1=30;
clear x;
T=1/Fs;
L = t1;
NFFT = 2^nextpow2(Fs);
numUniq = ceil((NFFT+1)/2);
t3=0.05;

recObj = audiorecorder(Fs,24,1);
record(recObj);
recObj2 = audiorecorder(Fs,24,1);


bool=true;
while(bool)
    recordblocking(recObj2, t3);

    sig = getaudiodata(recObj2);
    fftMag = 20*log10( abs(fft(sig,NFFT)) );
    [M, Indices] = max(fftMag(1:numUniq));
    disp(Indices)
    if Indices > 3000
        [M, Indices] = max(fftMag(1:numUniq));
        disp('End')
        bool = false;
    end
end

stop(recObj)

sig = getaudiodata(recObj);

maxiA=max(abs(sig));
notbegin = true;
i=1;
while(notbegin)
    if abs(sig(i,1))> maxiA/10
        notbegin=false;
        sig(i,1);
    end
    iBegin=i;
    i=i+1;
end


bContinue = true;
x=[];
n=iBegin+t1;
j=1;
M=5.2;
k=1;
one = true;
while(bContinue)
%     disp(k);

    s1 = sig(n+t1*4/8:n+t1*6/8,1);
    s2 = sig(t1+n+t1*4/8:t1+n+t1*6/8,1);
    Y1 =  20*log10(abs(fft(s1,NFFT)));
    Y2 =  20*log10(abs(fft(s2,NFFT)));
    [M1, Indices1] = max(Y1(1:numUniq));
    [M2, Indices2] = max(Y2(1:numUniq));
    
    if(Indices1 < 3500 && Indices2 < 3500)
        maxi1= mean(abs(sig(n+t1*5/8:n+t1*6/8,1)));
        maxi2= mean(abs(sig(t1+n+t1*5/8:t1+n+t1*6/8,1)));
        
        if (maxi1 < maxiA/100 && maxi2 < maxiA/100)
            bContinue = false;
            disp('c')
        elseif(maxi1 < maxi2)
            x(k,1) = 0;
            disp('->0')
            one = false;
        elseif(maxi1> maxi2)
            x(k,1) = 1;
            disp('->1')
            one = true;
%         elseif(n>32000*T1)
%             bContinue = false;
%             disp('e')
        else
            disp('error---------------------------')
        end
    end
    
    if one
        s=s1;
    else
        s=s2;
    end
    
    Y =  20*log10( abs(fft(s,NFFT)) );
    [M, Indices1] = max(Y(1:numUniq));
    disp(Indices1)
    if(maxi1 > maxiA/50 || maxi2 > maxiA/50)
        if Indices1 > 300 && Indices1 < 500
            x(k+1,1) = 1;
            x(k+2,1) = 1;
            
        elseif Indices1 > 500 && Indices1 < 700
            x(k+1,1) = 0;
            x(k+2,1) = 1;
        elseif Indices1 > 700 && Indices1 < 900
            x(k+1,1) = 1;
            x(k+2,1) = 0;
        elseif Indices1 > 900 && Indices1 < 1100
            x(k+1,1) = 0;
            x(k+2,1) = 0;
        elseif Indices1 > 1100 && Indices1 < 1300
            x(k+1,1) = 1;
            disp(Indices1)
        elseif Indices1 > 1300 && Indices1 < 1500
            x(k+1,1) = 0;
        elseif Indices1 > 1500 && Indices1 < 1900
            disp('........................')
        elseif Indices1 > 3000
            bContinue = false;
            disp('end')
        else disp('------------------------------')
            
        end
    end
    
    n=n+2*t1;
    j=j+1;
    k=k+3;
end
plot(sig)

text=bits2text(x);
