for i = 1 :10 
t=0;
for j= 1 : i
    t = t+1;
for k = 1 : i 
         b = rand(1);
         if b<0.5
             H(j, k) = 0;
         else
             H(j, k) = 1;
         end
end
while rank(H)<j
    for k = 1 : i
         b = rand(1);
         if b<0.5
             H(j, k) = 0;
         else
             H(j, k) = 1;
         end
    end
    t = t+1;
end
end
z(i) = t/i
end
plot(i, z)