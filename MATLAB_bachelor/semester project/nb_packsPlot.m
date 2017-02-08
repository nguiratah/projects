function[] = nb_packsPlot(lambda, TD, D, N, n_samples, G)
lambda = 6;
TD = 200;
D=3;
N = 100;
n_samples= 100;
G = 100;
for i =1 : n_samples
    Pe(i) = i/n_samples;
    z(i) = not_expired(lambda, TD, D, N, Pe(i), G)   
    h(i) = not_expired_encoded(lambda, TD, D, N, Pe(i), G);
    x(i) = not_expired_innovative(lambda, TD, D, N, Pe(i), G);
end
plot(Pe, z, Pe, h, Pe, x)
end