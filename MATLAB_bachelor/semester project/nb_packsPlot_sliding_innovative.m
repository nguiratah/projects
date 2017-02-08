function[] = nb_packsPlot_sliding_innovative(lambda, TD, D, N, n_samples, G)
G = 1;
TD = 50;
lambda = 6;
N = 50;
D =5;
n_samples = 100;
for i =1 : n_samples
    Pe(i) = i/n_samples;
    z(i) = not_expired_sliding_innovative(lambda, TD, D, N, Pe(i), G);
    %h(i) = not_expired(lambda, TD, D, N, Pe(i), G);
end
%plot(Pe, z, Pe, h)
plot(Pe, z)
end