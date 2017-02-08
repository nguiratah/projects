function[] = nb_Not_expired_encodedPlot(lambda, TD, D, N, n_samples, G)
G = 10;
n_samples = 100;
N = 100;
D = 5;
TD = 200;
lambda = 6;
for i =1 : n_samples
    Pe(i) = i/n_samples;
    z(i) = not_expired_encoded(lambda, TD, D, N, Pe(i), G)
end
plot(Pe, z);