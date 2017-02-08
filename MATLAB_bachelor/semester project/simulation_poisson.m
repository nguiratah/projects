function[x] = simulation_poisson(Lambda, N)
z = 0;
for i = 1 : N
    z = z + poissrnd(Lambda);
end
x = z/N;
end