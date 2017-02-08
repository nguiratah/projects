function[Dis2]= Dis2(R, sigma)
sigma=sigma^(1/2);
Dis2 = sigma^2*(2^-(2*R*10^6/(224*400*15)));
end