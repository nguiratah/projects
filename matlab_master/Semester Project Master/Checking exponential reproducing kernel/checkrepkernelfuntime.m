%function[y]=checkrepkernelfuntime(p, shift)
Ts=0.001;
alpha =[-2, -1.8, -1.5, -1, -0.8, -0.45, -0.05, 0.05, 0.45, 0.8, 1, 1.5, 1.8, 2];
%alpha =1i*[0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5];
%alpha =0.5;
[Phi, t]=generate_e_spline(alpha, Ts);N = 20/Ts;M = 7/Ts;
Phikmatrix = zeros(N, 13);
for l=1:13
    Phikmatrix((l-1)*(M)+1:(l-1)*M+(2*M+1),l)=Phi; 
end
Phi=Phikmatrix(:,1);
Tss= 1:length(Phikmatrix(:,1));
c_m_n = get_c_m_n_exp(alpha, 0:12, Phi, t);
result= c_m_n*Phikmatrix';
plot(real(result(1,:)));
% tfunc = 0:Ts:10;
% t=0:Ts:12;
% x=[sin(0.25*(tfunc))';zeros(1, length(t)-length(tfunc))'];
% z=[zeros(1, shift/Ts)';sin(0.25*(tfunc))';zeros(1, length(t)-length(tfunc)-shift/Ts)'];
% %plot(t,x,t,z)
% xn= x(1:1/Ts:end);%+0.01*randn(length(x(1:1/Ts:end)),1);
% zn= z(1:1/Ts:end);%+0.01*randn(length(z(1:1/Ts:end)),1);
% filter = [(ones(1, p))';zeros(1,length(xn)-p)'];
% filtertr=[(ones(1, p+round(shift)))';zeros(1,length(xn)-p-round(shift))'];
% xn = xn.*filter;
% zn=  zn.*filtertr;
% ts =0:length(xn)-1;
% %figure();
% %plot(ts, xn, ts, zn);
% fouriercoefxn = c_m_n*xn;
% fouriercoefzn = c_m_n*zn;
% poly=polyfit(alpha/1i,angle(fouriercoefzn.*conj(fouriercoefxn))',1);%least squares
% y=poly(1);
% figure();
% %plot(ts,angle(fft(zn)./fft(xn))./ts')
% plot(ts, xn, ts, zn)
% end