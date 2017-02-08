%function[fouriercoefxn1, fouriercoefxn2]= findft(Ts, K, x, w)
%data 
Alpha=0.01;
t0=0;
shift1=1;
shift2=2;
x=[];
y = [];
Ts = 0.01;
K=400;
w=[-0.5,0.5, -0.25, 0.25]';
x1 = [zeros(1, 18000)';conv(ones(1, 1000)', ones(1, 1000)');zeros(1, shift1/Ts)';zeros(1, 300)'];
y = [zeros(1, 5000)';zeros(1, shift1/Ts)'; conv(ones(1, 1000)', ones(1, 1000)');zeros(1, 300)'];
x1 = [x1;zeros(1, 300)';conv(ones(1, 1000)', ones(1, 1000)'); zeros(1, round(shift2/Ts))';zeros(1, 1000)'];
y = [y;zeros(1, 300+round(shift2/Ts))'; conv(ones(1, 1000)', ones(1, 1000)'); zeros(1, 1000)'];
x1 = x1/max(x1);
y=y/max(y);
alpha =1i*w';
M = length(alpha)/(2*Ts);
N = K*M;
[Phi, t]=generate_e_spline(alpha, Ts);
Phi = real(Phi);
Phikmatrix = zeros(N, K);
1
for l=1:K
    Phikmatrix(1+(l-1)/Ts:(l-1)/Ts+2*M+1,l)=Phi/max(Phi);
end
2
[c_m_n2, phi2] = c_m_nconstruction(Alpha, t0, Ts, w, K);
Phi=Phikmatrix(:,1);
t1=0:Ts:Ts*(length(Phi)-1);
c_m_n = get_c_m_n_exp(alpha, 1:K, Phi, 0:Ts:2);
3
result1=c_m_n*Phikmatrix';
result2=c_m_n2*Phikmatrix';
 x1 = [x1; zeros(1, length(t1))'];
 x1(length(t1)+1:end)=[];
 x1=[x1;zeros(1,length(Phikmatrix(:,1))-length(x1))'].';
% x2 =x1.*phi2';
 xn1=[];
 for l=1:K
     h=Phikmatrix(:,l);
     xn1=[xn1, Ts*x1*h];
 end
ft1= c_m_n(1,:)*xn1'; 
ft2= c_m_n2(1,:)*xn1';
% xpos = [find(xn>0)';0;0];
% window1 = [xpos(1)];
% i=1;
% while true
%     i=i+1;
%     window1=[window1, xpos(i)];
%     if not((xpos(i+1)-xpos(i))==1);
%         break;
%     end
% end
% i=i+1;
% window2 = xpos(i);
% while (true) && not(xpos(i+1)==0)
%     i=i+1;
%     window2=[window2, xpos(i)];
%     if not((xpos(i+1)-xpos(i))==1);
%         break;
%     end
% end
% %window2(length(window2))=[];
% xn1 = zeros(1, length(xn))';
% xn2 = zeros(1, length(xn))';
% xn1(window1)=xn(window1)';
% xn2(window2)=xn(window2)';
% fouriercoefxn1 = c_m_n*xn1;
% fouriercoefxn2 = c_m_n*xn2;
% ft = [fouriercoefxn1,fouriercoefxn2];
% end