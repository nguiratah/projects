function[] = nofeedbackslidingplot(lambda, TD, D, N,  G, n_samples, K, s)
G =2000;
n_samples =100;
N  = 100;
%L2 = 29;
lambda =1;
D =4;
TD =3000000000;
g = 6;
S =  10;
s = 5;
% for i = 1 : n_samples
%   s(i) = i;  
%   for r = s(i) : min(floor(1.5*n_samples), g*s(i))
%   K(r) =r;
%   x2(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.25, G, s(i), K(r));
%   y2(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.5, G, s(i), K(r));
%   j2(r, i) = nofeedbackgenerations(lambda, TD, D, N, 0.75, G, s(i), K(r));
%   %z(r, i)=nofeedbackgenerations(lambda, TD, D, N, 1, 0.9, s(i), K(r));
%   end
%  [x22(i), kx(i)] = max(x2(1 :size(x2) ,i))
%  [y22(i), ky(i)] = max(y2(1 :size(y2) ,i));
%  [j22(i), kj(i)] = max(j2(1 :size(j2) ,i));
%  %z1(i) = max(z(1 : n_samples ,i))
% end
%plot(s,x22,s,y22, s, j22);
%% second loop :
for  i = floor(s/2) : n_samples
   K(i) = 2*i;
    t(i) = nofeedbacksliding(lambda, TD, D, N, 0.25, G, S, K(i), s)
    x(i) = nofeedbacksliding(lambda, TD, D, N, 0.5, G, S, K(i), s)%/(K(i)*10)
    y(i) = nofeedbacksliding(lambda, TD, D, N, 0.75, G, S, K(i), s)%/(K(i)*10);
   %j(i) = nofeedbackgenerations(lambda, TD, D, N, 0.75, G, s, K(i))%/(K(i)*10);
   %x1(i) = nofeedbacksliding(100, TD, D, N, 0.25, G, S, K(i),s)%/(K(i)*10);
   %y1(i) = nofeedbacksliding(100, TD, D, N, 0.5, G, S, K(i),s)%/(K(i)*10);
   %j1(i) = nofeedbacksliding(100, TD, D, N, 0.75, G, S, K(i),s)%/(K(i)*10)
end
plot(K,t,K,x, K,y)%, K, x1, K, y1, K, j1);
%plot(K, x1);
end