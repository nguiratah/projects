function[] = nofeedbackgenerationplottest(lambda, TD, D, N,  G, n_samples, K)
G = 1;
n_samples =100;
N  = 100;
%L2 = 29;
lambda =1;
D =4;
TD =100;
g = 6;
% for i = 1 : n_samples/5
%   s(i) = 5*i;  
%   for r = s(i) : min(floor(1.5*n_samples), g*s(i))
%   K(r) =r;
%   x2(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.25, G, s(i), K(r))/(floor(K(r)*(N/s(i))));
%   y2(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.5, G, s(i), K(r))/(floor(K(r)*(N/s(i))));
%   j2(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.75, G, s(i), K(r))/(floor(K(r)*(N/s(i))));
%   %z(r, i)=nofeedbackgenerations(lambda, TD, D, N, 1, 0.9, s(i), K(r))/(floor(K(r)*(N/s(i))));;
%   end
%   s(i)
%  [x22(i), kx(i)] = max(x2(s(i) :size(x2) ,i));
%  A= x2(s(i) :size(x2), i);
%  size(A)
%  [y22(i), ky(i)] = max(y2(s(i) :size(y2) ,i));
%  B= y2(s(i) :size(y2), i);
%   size(B)
%  [j22(i), kj(i)] = max(j2(s(i) :size(j2) ,i));
%  C=j2(s(i) :size(j2), i);
%   size(C)
% end
% plot(s,kx,s,ky, s, kj);
% legend('Pe =0.25, lambda = 1', 'Pe =0.5, lambda = 1','Pe =0.75, lambda=1')%,'Pe =0.25, lambda = 100', 'Pe =0.5, lambda = 100','Pe = 0.75, lambda =100')  
% title(['K* = f(coding window size) for TD =' int2str(TD)]);
% xlabel('coding window size');
% ylabel('K*');
%% second loop :
s =  10;
for  i = floor(s/2) : n_samples
   K(i) = 2*i;
  %t(i) = nofeedbackgenerations(lambda, TD, D, N, 0.25, G, s, K(i));
   x(i) = nofeedbackgenerations(1, TD, D, N, 0.75, G, 60, K(i))%/(K(i)*10)
   y(i) = nofeedbackgenerations(1, TD, D, N, 0.75, G, 61, K(i))%/(K(i)*10);
   j(i) = nofeedbackgenerations(1, TD, D, N, 0.75, G, 62, K(i))%/(K(i)*10);
   x1(i) = nofeedbackgenerations(1, TD, D, N, 0.75, G, 80, K(i))%/(K(i)*10);
   y1(i) = nofeedbackgenerations(1, TD, D, N, 0.75, G, 84, K(i))%/(K(i)*10);
   j1(i) = nofeedbackgenerations(1, TD, D, N, 0.75, G, 88, K(i))%/(K(i)*10))
end
 plot(K,x,K, y, K, j, K, x1, K, y1, K, j1)%, K, x1, K, j1);
% legend('Pe =0.25, lambda = 1','Pe =0.75, lambda=1','Pe =0.25, lambda = 100','Pe = 0.75, lambda =100')  
% title(['not expired packets = f(K) for TD =' int2str(TD)]);
% xlabel('K');
% ylabel('Not expired packets');
end