clear all;
t=0.1;
Fs = 32000;
t1=Fs*t;
T=55;
clear x;

recObj = audiorecorder(Fs,24,1);
recordblocking(recObj, T);
sig = getaudiodata(recObj);


maxiA=max(abs(sig));
notbegin = true;
i=1;
while(notbegin)
    if abs(sig(i,1))> maxiA/4
        notbegin=false;
        sig(i,1);
    end
    iBegin=i;
    i=i+1;
end

% notEnd = true;
% while(notEnd)
%     if abs(sig(i,1))> 3* maxiA/4
%         notEnd=false;
%         sig(i,1);
%     end
%     iBegin=i;
%     i=i+1;
%
% end

bContinue = true;
x=[];
n=iBegin+t1;
j=1
M=7.5
while(bContinue)
    disp(n);
    disp(j);
        maxi1= mean(abs(sig(n+t1*5/8:n+t1*6/8,1)));
        maxi2= mean(abs(sig(t1+n+t1*5/8:t1+n+t1*6/8,1)));
        
    if(maxi1 < maxiA/M && maxi2 > maxiA/M)
        x=[x,0];
        disp('->0')
    elseif(maxi1 > maxiA/M && maxi2 < maxiA/M)
        x=[x,1];
        disp('->1')
    elseif(maxi1 < maxiA/15 && maxi2 < maxiA/15)
        bContinue = false;
        disp('c')
    elseif(maxi1 > maxiA/M && maxi2 > maxiA/M)
        disp('d')
%         x=[x,1];
    elseif(n>32000*T)
        bContinue = false;
        disp('e')
    else
        disp('error')
    end
    
%         if mod(n,8)==7
%             n=n+2*t1
%         end

    n=n+2*t1;
    j=j+1;
end
plot(sig)

q=[];
l=length(x);
m=mod(length(x), 7);

for k = 1:length(x)-m
    q(k)=int2str(x(k));
end

s=char(q);
s=char(bin2dec(reshape(s,7,[]).')).'