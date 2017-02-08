function[]= plot_prob_dec(TD, nb_packs, nb_samples, N)
for i = 1 : nb_samples
    P(i) = i/(nb_samples)
    y(i) = theoretical_simulation(TD, P(i), nb_packs)  
    z(i) = simulation(N,TD, P(i), nb_packs);
end
plot(P, y,'--', P, z)

