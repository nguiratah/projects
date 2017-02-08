function[] = plot_expectation_given_decoded(N,TD,  nb_packs,nb_samples)
%%Here the expectation of the decoding time in the simulation is considered
%%as E[decTime]= E[decTime|decoded]*P[decoded] + E[decTime|not decoded]*P[not decoded]

%%TD : deadline
%%Pe : vector of non-innovative probability
%%N : number of simulations
for i = 1 : nb_samples
    Pe(i) = i/nb_samples;
    y(i) = 0;
    for k = nb_packs : TD
        y(i) = y(i) + k*nchoosek(k-1, nb_packs-1)*Pe(i)^(k-nb_packs)*(1-Pe(i))^(nb_packs);
    end;
    z(i) = simulation_expectation_given_decoded(N,TD, Pe(i), nb_packs)
end;
plot(Pe, y, '--', Pe, z);