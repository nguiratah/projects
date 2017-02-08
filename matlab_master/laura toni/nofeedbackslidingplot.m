function[] = nofeedbackslidingplot(lambda, TD, D, N,  G, n_samples, K, s)
G =10;
n_samples =50;
N  = 25;
%L2 = 29;
lambda =25;
D =4;
TD =60;
g = 5;
m=1;
H = 100;
 for i = 1 : n_samples
     a1(i) = 0;
     b1(i) = 0;
     c1(i) = 0;
 end
 b = zeros(125, 25);
 for l =1 :H
 for i = 1 : n_samples
    s(i) = i;
   for r = 1 : g*s(i)
   K(r) =r;
  a(r, i) = nofeedbacksliding(lambda, TD, D, N, 0.25, G, s(i), K(r), m);%/(H*floor(K(r)*N/s(i)));
   b(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.75, G, s(i), K(r));
   c(r, i) = nofeedbacksliding(lambda, TD, D, N, 0.75, G, s(i), K(r), m);%/(H*floor(K(r)*N/s(i)));
  %z(r, i)=nofeedbackgenerations(lambda, TD, D, N, 1, 0.9, s(i), K(r));
   end
  [x22(i), kx(i)] = max(a(1 :size(a) ,i));
   a1(i) =a1(i) +  x22(i)/H;
   %a1(i) = a1(i) +  kx(i)/(H*s(i));
  [y22(i), ky(i)] = max(b(1 :g*s(i) ,i));
   b1(i)= b1(i) + y22(i)/H;
   %b1(i) =b1(i) +  ky(i)/(H*s(i));
  [j22(i), kj(i)] = max(c(1 :g*s(i) ,i));
  c1(i) =c1(i)+ kj(i)/(H*s(i));
  %c1(i)=c1(i) +  j22(i)/H;
 end
 l
 end
 figure();
plot(s,b1, s,c1);
legend('Pe =0.5, lambda = 25 generation based', 'Pe =0.5, lambda = 25, sliding window')  
xlabel('coding window size');
ylabel('max of number of not expired packets');
%% second loop :
% s =  10;
% m=5;
% for  i = floor(s/2) : n_samples
%   K(i) = 2*i;
%    x(i) = nofeedbacksliding(1, 30, D, 100, 0.25, G, s, K(i), m)%/(K(i)*10)
%  %  y(i) = nofeedbacksliding(lambda, TD, D, N, 0.5, G, s, K(i),m)%/(K(i)*10);
%    j(i) = nofeedbacksliding(100, 30, D,100, 0.75, G, s, K(i), m)%/(K(i)*10);
%   x1(i) = nofeedbacksliding(1, 100, D, 100, 0.25, G, s, K(i), m)%/(K(i)*10);
% %  y1(i) = nofeedbacksliding(25, TD, D, N, 0.5, G, s, K(i), m)%/(K(i)*10);
%   j1(i) = nofeedbacksliding(100, 100, D, 100, 0.75, G, s, K(i), m)%/(K(i)*10))
% end
% %plot(K, y);
% plot(K,x,K, j, K, x1, K, j1);
% legend('Pe =0.25, lambda = 1 TD= 30', 'Pe =0.75, lambda = 100, TD=30','Pe =0.25, lambda =1, TD=100','Pe = 0.75, lambda =100, TD= 100')   
% title('not expired packets = f(K)')% int2str(TD)]);
% xlabel('K');
% ylabel('Not expired packets');
% end