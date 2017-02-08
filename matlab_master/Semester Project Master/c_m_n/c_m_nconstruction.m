function[c_m, Phi2]= c_m_nconstruction(Alpha, t0,Ts,w, K)
% Ts = 0.01;
% K=200;
% w=[-0.5,0.5, -0.5, 0.5]';
% t0=0;
% Alpha=0.01;
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
t1=0:Ts:Ts*(length(Phi)-1)';
[Phi2, t2]= generate_e_spline(alpha,Ts*Alpha);
t2=[t2; (t2(end)+Ts:Ts:t2(end)+t0/Ts)'];
Phi2 = real(Phi2);
Phi2= Phi2/max(Phi2);
Phi2= [zeros(1, t0/Ts)';Phi2];
if length(Phi2)>length(Phi)
    Phi(length(Phi)+1:length(Phi2))=zeros(1, length(Phi2)-length(Phi))';
    t1=0:Ts:Ts*(length(Phi2)-1);
    t2=t1;
else
    Phi2(length(Phi2)+1:length(Phi))=zeros(1, length(Phi)-length(Phi2))';
    t1=0:Ts:Ts*(length(Phi)-1);
    t2=t1;
end
Phi2(max(length(t1), length(t2))+1+t0/Ts:end)=[];
A = (Phikmatrix);
disp('------------------------------------------------------')
for k=1:length(alpha)
    k
result{k} = (Phi2.*(exp(-alpha(k)*t1'))).';
result{k} = [result{k}, zeros(1, length(Phikmatrix(:,1))-length(result{k}))];
result{k}=result{k}';
z = result{k};
z(size(A, 1)+1:end)=[];
c{k}=A\z;
ERR{k}=mean((z-A*c{k}).^2);
c_m(k, :)=c{k};
end
end