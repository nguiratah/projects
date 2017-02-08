x = linspace(0, 2*pi, 10000)
plot(x, (abs((1-exp(1i*2*pi*20*x)/(1-exp(1i*2*pi*x))))));
plot(x, sin(x))
