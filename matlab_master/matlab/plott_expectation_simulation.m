function[]= plott_expectation_simulation(N,TD, nb_packs, n_samples)
for i= 1 : n_samples
    P(i) = i/n_samples; 
    y(i) = simulation_expectation_given_decoded(N,TD, P(i), nb_packs)*simulation(N,TD, P(i), nb_packs) + 10*TD*(1-simulation(N,TD, P(i), nb_packs));
end;
plot(P, y);