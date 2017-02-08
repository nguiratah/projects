function[] = nb_packsPlot_block_not_expired_encoded(lambda, TD, D, N, n_samples, G)
%function[] = nb_packsPlot_block_not_expired_encoded(lambda, TD, D, N, n_samples, G, P)
%Pe = 0.5;
L1 =5;
L2 =29;
G = 500;
n_samples = 50;
N  = 100;
TD2 = 200;
TD1 = 150;
lambda = 6;
D =5;
for i =1 : n_samples
   Pe(i) = i/n_samples;
  % L(i) = i;
    z(i) = not_expired_encoded_block(lambda, TD2, D, N, Pe(i), G, L1)
    j(i) = not_expired_encoded_block(lambda, TD2, D, N, Pe(i), G, L2);
   % h(i) = not_expired_block(lambda, TD1, D, N, Pe(i), G, L1)
   %r(i) = not_expired_block(lambda, TD2, D, N, Pe(i), G, L2);
end

%plot(L, z, L, j)
plot(Pe, z, Pe, j)
%plot(Pe, z)
%plot(L, z);
end