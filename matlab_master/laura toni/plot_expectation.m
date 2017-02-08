function[] = plot_expectation(N, TD, nb_packs,nb_samples)
%%Pe : vector of non-innovative probability
for i = 1 : nb_samples
    Pe(i) = i/nb_samples;
    y(i) = (nb_packs)*(nchoosek(nb_packs-1, nb_packs-1)*(1-Pe(i))^(nb_packs))*theoretical_simulation(TD, Pe(i), nb_packs);
    for k = nb_packs+1 : TD
     y(i) =y(i)+ k*nchoosek(k-1, nb_packs-1)*Pe(i)^(k-nb_packs)*(1-Pe(i))^(nb_packs)*theoretical_simulation(TD, Pe(i), nb_packs);
    end;
    y(i) = y(i)+ 10*TD*(1-theoretical_simulation(TD, Pe(i), nb_packs));
    z(i) = simulation_expectation_given_decoded(N,TD, Pe(i), nb_packs)*simulation(N,TD, Pe(i), nb_packs) + 10*TD*(1-simulation(N,TD, Pe(i), nb_packs));
end;
plot(Pe, y, '--', Pe, z)