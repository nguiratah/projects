for n = 1:128
    x(n)  = cos(2*pi*n*21/127)
end
figure (2);
Fe = 100;
N = length (x);
df = Fe/N;
f = -50: df :50 - df;
X = fftshift ( abs ( fft (x )));
plot (f,X);
