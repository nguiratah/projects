function [y]= sinapp(w, N)
x = 0;
for k=1:N
    x =x+((w^(2*k+1))/(factorial(2*k-1)))*(-1)^(k-1);
end
y = sin(w)-x;
y = x;
end
