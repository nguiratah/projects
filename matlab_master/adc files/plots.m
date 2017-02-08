function[] =plots(x)
x = 100.
for i =1 : x
    z(i) = var(brownian(i, 0, 100, 1));
    i
end
figure();
plot(z);