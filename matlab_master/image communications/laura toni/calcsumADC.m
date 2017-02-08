function [Pe]= calcsumADC(L, x);
L=150;
x = 10^100;
R= 0;
for k=0:L
    R =R + 0.5*(-1)^(k)*(nchoosek(L, k)*k/(2*k+x));
end
R = -R
z = -log(R)/log(x)
