function[y]=checkrepkernelfuntimev2(p, sigma, Ts, K, shift)
% shift=1.2;
% shift2=3;
 x=[];
 y = [];
% Ts = 0.01;
% x = [zeros(1, 200)';conv(ones(1, 40)', ones(1, 40)');zeros(1, shift1/Ts)';zeros(1, 100)'];
% z = [zeros(1, 200)';zeros(1, shift1/Ts)'; conv(ones(1, 40)', ones(1, 40)');zeros(1, 100)'];  
% %x = [x;zeros(1, 300)';conv(ones(1, 40)', ones(1, 40)'); zeros(1, round(shift2/Ts))';zeros(1, 10)'];
% %z = [z;zeros(1, 300+round(shift2/Ts))'; conv(ones(1, 40)', ones(1, 40)'); zeros(1, 10)'];
%trials = 1;
% K=140;
 w=[-0.5,0.5]';
% sigma=0;
% w=[-0.5,0.5]';
% p=1440;
alpha =1i*w';
M = length(alpha)/(2*Ts);
N = K*M;
[Phi, t]=generate_e_spline(alpha, Ts);
Phi = real(Phi);
Phikmatrix = zeros(N, K);
for l=1:K
    Phikmatrix(1+(l-1)/Ts:(l-1)/Ts+2*M+1,l)=Phi/max(Phi);
end
Phi=Phikmatrix(:,1);
t1=0:Ts:Ts*(length(Phi)-1);
c_m_n = get_c_m_n_exp(alpha, 1:K, Phi, 0:Ts:2);
result = c_m_n*Phikmatrix.'; 
%shift = rand();
%tfunc=find(abs(Yt-result(1,:))<1e-2);
% x=[zeros(1, 2000)';exp(-(0.1*t1(1:3000)))';zeros(1, length(t1)-2200)'];
 %z=[zeros(1, 2000)';zeros(1, round(shift/Ts))';exp(-(0.1*t1(1:3000)))';zeros(1, length(t1)-22000)'];
  x = zeros(1, 200)';
  z = zeros(1, 200+round(shift/Ts))';
 for J=1:8
      x = [x; zeros(1,999)';1/Ts];
      z = [z; zeros(1,999)';1/Ts];
  end
x = [x; zeros(1, length(t1))'];
z = [z; zeros(1, length(t1))'];
x(length(t1)+1:end)=[];
z(length(x)+1:end)=[];
x=[x;zeros(1,length(Phikmatrix(:,1))-length(x))'].';
z=[z;zeros(1,length(Phikmatrix(:,1))-length(z))'].';
%x=[zeros(1,3000),x,zeros(1,5000)];
%z=[zeros(1,3000),z,zeros(1,5000)];
xn=[];
zn=[];
for l=1:K
    h=Phikmatrix(:,l);
    %h = [zeros(1,5000)'; Phikmatrix(:,l); zeros(1,5000)'];
    xn=[xn, Ts*x*h];
    zn=[zn, Ts*z*h];
end
xn=xn+sigma*std(xn)*randn(1, length(xn));
zn=zn+sigma*std(xn)*randn(1, length(xn));
filter = [(ones(1, p))';zeros(1,length(xn)-p)']';
filtertr = zeros(1, length(xn));
filtertr(1+round(shift):p+round(shift))=1;
filtertr(length(zn)+1:end)=[];
filter(length(xn)+1:end)=[];
zn=zn.*filtertr;
xn = xn.*filter;
fouriercoefxn = c_m_n*xn.';
fouriercoefzn = c_m_n*zn.';
poly = inv(w'*w)*w'*angle(fouriercoefzn.*conj(fouriercoefxn));
y=[y, poly(1)];
TTs=0:length(xn)-1;
y=mean(y);
%figure();
% plot(xn);hold on; plot(zn);
% figure();
% tmp1 = conv(x, Phi, 'same');
% tmp2 = conv(z, Phi, 'same');
% plot(tmp1(1:1/Ts:end));hold on; plot(tmp2(1:1/Ts:end));
end