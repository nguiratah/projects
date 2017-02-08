function[]= plott(N,TD, nb_packs, nb_samples)
for i = 1 : nb_samples
    P(i) =  i/(nb_samples);
    y(i) = simulation(N,TD, P(i), nb_packs);
end
plot(P, y)
