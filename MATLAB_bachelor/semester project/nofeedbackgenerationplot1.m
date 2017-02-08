function[] = nofeedbackgenerationplot1(lambda, TD, D, N,  G, n_samples, K)
G =1;
n_samples =25;
N  = 25;
%L2 = 29;
lambda =1;
D =4;
TD =20000000;
g = 6;
H =1000;
for i = 1 : n_samples
  s(i) = i;
  for r = s(i) : min(floor(1.5*n_samples), g*s(i))
  K(r) =r;
  a(r ,i) = 0;
  b(r, i) = 0;
  c(r, i) = 0;
  for l =1 :H
  a(r, i) =a(r, i) + nofeedbackgenerations(lambda, TD, D, N, 0.25, G, s(i), K(r))/(H*floor(K(r)*N/s(i)));
  b(r, i) =b(r, i)+ nofeedbackgenerations(lambda, TD, D, N, 0.5, G, s(i), K(r))/(H*floor(K(r)*N/s(i)));
  c(r, i) =c(r, i)+ nofeedbackgenerations(lambda, TD, D, N, 0.75, G, s(i), K(r))/(H*floor(K(r)*N/s(i)));
  %z(r, i)=nofeedbackgenerations(lambda, TD, D, N, 1, 0.9, s(i), K(r));
  end
  end
 [x22(i), kx(i)] = max(a(1 :size(a) ,i));
 a1(i) =x22(i);
 [y22(i), ky(i)] = max(b(1 :size(b) ,i));
 b1(i) =y22(i);
 [j22(i), kj(i)] = max(c(1 :size(c) ,i));
 c1(i)=j22(i)
end
plot(s,a1,s,b1, s,c1);
legend('Pe =0.25, lambda = 1', 'Pe =0.5, lambda = 1','Pe =0.75, lambda=1')%,'Pe =0.25, lambda = 100', 'Pe =0.5, lambda = 100','Pe = 0.75, lambda =100')  
title(['normalized maximum of number of not expired packets for lambda =1) = f(coding window size) for TD =' int2str(TD)]);
xlabel('coding window size');
ylabel('normalized maximum of number of not expired packets');
%% second loop :
% s =  10;
% for  i = floor(s/2) : n_samples
%    K(i) = 2*i;
%   %t(i) = nofeedbackgenerations(lambda, TD, D, N, 0.25, G, s, K(i));
%    x(i) = nofeedbackgenerations(lambda, 30, D, N, 0.25, G, s, K(i))%/(K(i)*10)
%    y(i) = nofeedbackgenerations(lambda, 100, D, N, 0.25, G, s, K(i))%/(K(i)*10);
%    j(i) = nofeedbackgenerations(lambda, 150, D, N, 0.25, G, s, K(i))%/(K(i)*10);
%    x1(i) = nofeedbackgenerations(100, 30, D, N, 0.75, G, s, K(i))%/(K(i)*10);
%    y1(i) = nofeedbackgenerations(100, 100, D, N, 0.75, G, s, K(i))%/(K(i)*10);
%    j1(i) = nofeedbackgenerations(100, 150, D, N, 0.75, G, s, K(i))%/(K(i)*10))
% end
% plot(K,x,K,y, K, j, K, x1, K, y1, K, j1);
% %legend('Pe =0.25, lambda = 1', 'Pe =0.5, lambda = 1','Pe =0.75, lambda=1','Pe =0.25, lambda = 100', 'Pe =0.5, lambda = 100','Pe = 0.75, lambda =100')  
% legend('Pe =0.25,lambda = 1, TD= 30','Pe =0.25, TD= 100, lambda =1','Pe =0.25, TD=150, lambda = 1','Pe =0.75, TD=30, lambda =100', 'Pe =0.75, TD=100, lambda = 100','Pe = 0.75, TD = 150, lambda =100') 
% title('not expired packets = f(K) for TD = 30, 100 and 150')% int2str(TD)]);
% xlabel('K');
% ylabel('Not expired packets');
end