function[] = plott_expectation_theory_given_decoded%%TD, nb_packs, nb_samples%%)
%%Pe : vector of non-innovative probability
TD = 100;
nb_packs=1000;
nb_samples=100;
for i = 1 : nb_samples
    Pe(i) = i/nb_samples;
    y(i) = 0;
    for k = nb_packs : TD
        y(i) = y(i) + k*nchoosek(k-1, nb_packs-1)*Pe(i)^(k-nb_packs)*(1-Pe(i))^(nb_packs);
    end;
end;
plot(Pe, y);