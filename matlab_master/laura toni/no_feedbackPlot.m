function[] = no_feedbackPlot(lambda, TD, D, N, n_samples, G, K)
lambda = 6;
TD = 700000;
D=5;
N = 100;
n_samples= 100;
G = 40;
%K1 = 100;
%K2 = 200;
%K3 = 400;
%K4 = 1000;
for i =1 : n_samples
   %Pe(i) = (i-1)/n_samples;
   K(i) = 10*(i-1)+N;
   x(i) = no_feedback(lambda, TD, D, N, 0.1, G, K(i))
   w(i) = no_feedback(lambda, TD, D, N, 0.5, G, K(i));
   h(i) = no_feedback(lambda, TD, D, N, 0.75, G, K(i))
   %z(i) = no_feedback(lambda, TD, D, N, Pe(i), G, K4);
end
%plot(K, x, K, w, K, h)
plot(K, h)
end