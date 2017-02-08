clear all;
t=0.1;
Fs = 32000;
t1=Fs*t;
T=150;
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
j=1;
while(bContinue)
    disp(n);
    disp(j);
        maxi1= max(abs(sig(n+t1/4:n+t1*3/4,1))); %le maximum sur la première partie
        maxi2= max(abs(sig(t1+n+t1/4:t1+n+t1*3/4,1)));%le maximum sur la deuxième partie       
    if(maxi1 < maxiA*3/4 && maxi2 > maxiA*3/4) %silence sinus => 0% 
        x=[x,0];
        disp('a')
    elseif(maxi1 > maxiA*3/4&& maxi2 < maxiA*3/4) %sinus silence => 1 %% aucun 
        x=[x,1];
        disp('b')
    elseif(maxi1 < maxiA/10 && maxi2 < maxiA/10) %=> silence silence 0 => stop
        bContinue = false;
        disp('c')
    elseif(maxi1 > maxiA*3/4 && maxi2 > maxiA*3/4) %? Pourquoi ça marche ? à vérifier
        disp('d')
        x=[x,1]
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