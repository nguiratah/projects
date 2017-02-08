function[] = nofeedbackgenerationplot(lambda, TD, D, N,  G, n_samples, K)
G =30;
n_samples =100;
N  = 100;
%L2 = 29;
lambda =25;
D =4;
TD =100;
g = 5;
H  =1;
% for i = 1 : n_samples
%     a1(i) = 0;
%     b1(i) = 0;
%     c1(i) = 0;
% end
% for l =1 :H
% for i = 1 : n_samples
%   s(i) = i;
%   for r = 1 : g*s(i)
%   K(r) =r;
%   a(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.25, G, s(i), K(r))/(H*floor(K(r)/s(i)));
%   b(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.5, G, s(i), K(r))/(H*floor(K(r)/s(i)));
%   c(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.75, G, s(i), K(r))/(H*floor(K(r)/s(i)));
%   %z(r, i)=nofeedbackgenerations(lambda, TD, D, N, 1, 0.9, s(i), K(r));
%   end
%  [x22(i), kx(i)] = max(a(1 :size(a) ,i));
%  % a1(i) =a1(i) +  x22(i)/H;
%   a1(i) = a1(i) +  kx(i)/(H*s(i));
%  [y22(i), ky(i)] = max(b(1 :size(b) ,i));
%  %b1(i)= b1(i) + y22(i)/H;
%  b1(i) =b1(i) +  ky(i)/(H*s(i));
%  [j22(i), kj(i)] = max(c(1:size(c) ,i));
%  c1(i) =c1(i)+ kj(i)/(H*s(i))
%  %c1(i)=c1(i) +  j22(i)/H;
% end
% l
% end
% plot(s,a1,s,b1, s,c1);
% legend('Pe =0.25, lambda = 25', 'Pe =0.5, lambda = 25','Pe =0.75, lambda=25')%,'Pe =0.25, lambda = 100', 'Pe =0.5, lambda = 100','Pe = 0.75, lambda =100')  
% title(['K*/coding window size) = f(coding window size) for TD =infinite'])% int2str(TD)]);
% xlabel('coding window size');
% ylabel('K*/coding window size');
%% second loop :
s =  10;
for  i = floor(s/2) : n_samples
   K(i) = 2*i;
  %t(i) = nofeedbackgenerations(lambda, TD, D, N, 0.25, G, s, K(i));
   x(i) = nofeedbackgenerations(1, 30, D, N, 0.25, G, s, K(i))%/(K(i)*10)
   y(i) = nofeedbackgenerations(100, 30, D, N, 0.75, G, s, K(i))%/(K(i)*10);
   %j(i) = nofeedbackgenerations(lambda, 150, D, N, 0.25, G, s, K(i))%/(K(i)*10);
   x1(i) = nofeedbackgenerations(1, 100, D, N, 0.25, G, s, K(i))%/(K(i)*10);
   y1(i) = nofeedbackgenerations(100, 100, D, N, 0.75, G, s, K(i))%/(K(i)*10);
   %j1(i) = nofeedbackgenerations(100, 150, D, N, 0.75, G, s, K(i))%/(K(i)*10))
end
plot(K,x,K,y, K, x1, K, y1);
%legend('Pe =0.25, lambda = 1', 'Pe =0.5, lambda = 1','Pe =0.75, lambda=1','Pe =0.25, lambda = 100', 'Pe =0.5, lambda = 100','Pe = 0.75, lambda =100')  
legend('Pe =0.25, TD= 30,lambda = 1','Pe =0.75, TD= 30, lambda =100','Pe =0.25, TD=100, lambda = 1','Pe =0.75, TD=100, lambda =100') 
title('not expired packets = f(K) for TD = 30, 100 and 150')% int2str(TD)]);
xlabel('K');
ylabel('Not expired packets');
end