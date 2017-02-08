%exercise2
clear all;
clc;
N = 10000;
load('ProbRespGivenStimulus');
P = [ProbRespGivenStim1;ProbRespGivenStim2;ProbRespGivenStim3];
alpha = 0:1/N: 1;
beta = 0:1/N: 1;
I = zeros(N, N);
for i = 1:N+1
    for j = 1:N+2-i
        Pdis =[alpha(i)*P(1,:);beta(j)*P(2,:);(1-alpha(i)-beta(j))*P(3,:)];
        I(i, j) = Information(Pdis);
    end
end
M = max(max(I));
for i =1: N+1
    for j = 1 : N+1
       if I(i, j)==M
           a = (i-1)/N;
           b = (j-1)/N;
           c = 1 - a -b;
       end
    end
end
