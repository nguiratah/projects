function[V]= optimize(G,Z,vectors, Cw, a, b, c)
a = 900;
b= 600;
c= 3;
G = 0.5;
Cw= 50;
Z= 200;
vectors=Prob_vect(0.25);
g = size(vectors);
Dis = zeros(1, g(1));
for l=1:g(1)
    Dis(l)=RandomSlottedAlohav3Distortion(G,vectors(l,:),Z, Cw, a ,b, c);
    100*l/g(1)
end
[~,f] = min(Dis);
V= vectors(f,:);
end