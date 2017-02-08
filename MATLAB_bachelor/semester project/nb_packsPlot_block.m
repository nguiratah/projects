function[] = nb_packsPlot_block(lambda, TD, D, N,  G, n_samples)
%function[] = nb_packsPlot_block(lambda, TD, D, N, n_samples, G, P)
L =5;
G = 5;
n_samples = 200;
N  = 100;
%L2 = 29;
lambda = 6;
D =5;
%TD1= 200;
TD = 200;
%Pe = 0.9;
for i = 1 : n_samples;
  Pe(i) = i/n_samples;
  % TD(i) = i;
   z(i) = not_expired_block(lambda, TD, D, N, Pe(i), G, 1)
   t(i) = not_expired_block(lambda, TD, D, N, Pe(i), G, 29);
   x(i) = not_expired_block(lambda, TD, D, N, Pe(i), G, 100);
   % h(i) = not_expired_block(lambda, TD(i), D, N, Pe, G,L2);
end
%plot(TD, z, TD, h)
%plot(TD, z,TD, h)
plot(Pe, z, Pe, t, Pe, x)
%plot(TD, z, TD, h, TD, t, TD, x);
end