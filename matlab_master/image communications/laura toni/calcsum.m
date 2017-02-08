function[j] = calcsum(n, y)
for l = 1 : 500
    X(l) = l;
    h(l) = l/100;
    j(l) = 0;
    for i = 0: n 
    j(l) = j(l)+ (cos(h(l)*2^i)/(2^(i*y)));
    end
end
X
j
plot(X, j);