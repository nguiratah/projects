%rand
N = 100000000;
x = 0;
for i =1 :N
    x = (1-abs(x))*rand();
    y=x-(1-abs(x))*rand();
end
    