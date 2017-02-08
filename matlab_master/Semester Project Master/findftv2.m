%function[ft]= findftv2(Ts, K, x, w)
%data 
t0=0;
Alpha=0.01;
shift1=1.26;
shift2=2.12;
x=[];
y = [];
Ts = 0.01;
K=400;
w=[-0.5,0.5,-0.25,0.25]';
x = [zeros(1, 19000)';conv(ones(1, 100)', ones(1, 100)');zeros(1, shift1/Ts)';zeros(1, 300)'];
y = [zeros(1, 19000)';zeros(1, shift1/Ts)'; conv(ones(1, 100)', ones(1, 100)');zeros(1, 300)'];
x = [x;zeros(1, 300)';conv(ones(1, 100)', ones(1, 100)'); zeros(1, round(shift2/Ts))';zeros(1, 100)'];
y = [y;zeros(1, 300+round(shift2/Ts))'; conv(ones(1, 100)', ones(1, 100)'); zeros(1, 100)'];
x = x/max(x);
y=y/max(y);
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
[c_m_n1, phi2] = c_m_nconstruction(Alpha, t0, Ts, w, K);
% x = [x; zeros(1, length(t1))'];
% x(length(t1)+1:end)=[];
% x=[x;zeros(1,length(Phikmatrix(:,1))-length(x))'].';
% xn=[];
% for l=1:K
%     h=Phikmatrix(:,l);
%     xn=[xn, Ts*x*h];
% end
% fouriercoefxn1 = c_m_n1*xn';
% ft1 = fouriercoefxn1;
%end
