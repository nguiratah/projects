B = 1024;
x =0:B;
h = zeros(B);
h([1 2 4 7 11 16]) = (-1).^([0 1 3 6 10 15])./sqrt(([1 2 4 7 11 16]));
h = h(1:B,1);
W = dftmtx(B)
W*h
plot(abs(W*h))