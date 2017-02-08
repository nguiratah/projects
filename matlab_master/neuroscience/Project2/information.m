%exercise 1
function [I] = information(P)
P1 = sum(P);
P2 = sum(P')';
I = 0;
for  i=1 : length(P2)
    for j=1 :length(P1)
        if and(P1(j)*P2(i) ~=0, P(i, j)~=0)
        I = I+P(i, j)*log2((P(i, j)/((P1(j)*P2(i)))));
        end
    end
end
%end
