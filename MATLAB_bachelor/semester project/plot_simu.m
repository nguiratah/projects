function[] = plot_simu(Lambda, N)
Lambda = 5;
i=0;
for i =1 : 1000
    z(i) = simulation_poisson(Lambda, i);
    h(i) = i;
end
plot(h, z)