function[] = nofeedbackgenerationplot(lambda, TD, D, N,  G, n_samples, K)
G = 3000;
n_samples =100;
N  = 100;
%L2 = 29;
lambda =1;
D =4;
TD =100;
g = 6;
% for i = 1 : n_samples
%   s(i) = i;  
%   for r = s(i) : min(floor(1.5*n_samples), g*s(i))
%   K(r) =r;
%   x2(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.25, G, s(i), K(r));
%   y2(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.5, G, s(i), K(r));
%   j2(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.75, G, s(i), K(r));
%   %z(r, i)=nofeedbackgenerations(lambda, TD, D, N, 1, 0.9, s(i), K(r));
%   end
%  [x22(i), kx(i)] = max(x2(1 :size(x2) ,i));
%  [y22(i), ky(i)] = max(y2(1 :size(y2) ,i));
%  [j22(i), kj(i)] = max(j2(1 :size(j2) ,i))
% end
% plot(s,kx,s,ky, s, kj);
% legend('Pe =0.25, lambda = 100', 'Pe =0.5, lambda = 100','Pe =0.75, lambda=100')%,'Pe =0.25, lambda = 100', 'Pe =0.5, lambda = 100','Pe = 0.75, lambda =100')  
% title(['K* = f(coding window size) pour TD =' int2str(TD)]);
% xlabel('coding window size');
% ylabel('K*');
%% second loop :
s =  10;
for  i = floor(s/2) : n_samples
   K(i) = 2*i;
  %t(i) = nofeedbackgenerations(lambda, TD, D, N, 0.25, G, s, K(i));
   x(i) = nofeedbackgenerations(1, 30, D, N, 0.25, G, s, K(i));
   y(i) = nofeedbackgenerations(100, 30, D, N, 0.75, G, s, K(i));
   j(i) = nofeedbackgenerations(1, 100, D, N, 0.25, G, s, K(i));
   x1(i) = nofeedbackgenerations(100, 100, D, N, 0.75, G, s, K(i))
  % y1(i) = nofeedbackgenerations(lambda, 100, D, N, 0.75, G, s, K(i))%/(K(i)*10);
  % j1(i) = nofeedbackgenerations(lambda, 150, D, N, 0.75, G, s, K(i))%/(K(i)*10))
end
plot(K,x,K,y, K, j, K, x1)%, K, y1, K, j1);
legend('Pe =0.25, TD= 30, lambda= 1','Pe =0.75, TD= 30, lambda =100','Pe =0.25, TD=100, lambda =1','Pe =0.75, TD=100, lambda= 100')%, 'Pe =0.75, TD=100','Pe = 0.75, TD = 150')  
title('number of not expired packets = f(K) for TD = 30, 100')% int2str(TD)]);
xlabel('K');
ylabel('number of not expired packets');
end