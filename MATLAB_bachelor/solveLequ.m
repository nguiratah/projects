function[x]= solveLequ[L, b]
x(1) = b(1)/L(1,1);
for i=2 : n
    for j =1 :i-1
        s(j) = s(j)+ L(i, j).*x(j);
    end
    x(i) = (b(i) - s(i-1))/L(i,i);
end
