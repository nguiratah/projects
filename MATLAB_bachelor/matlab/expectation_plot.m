function [] = expectation_plot(N,TD, nb_packs, samples)
for i = 1 : samples 
    P(i) = i/samples;
    Y(i) = simulation_expectation(N,TD, P(i), nb_packs);
end;
plot(P, Y);