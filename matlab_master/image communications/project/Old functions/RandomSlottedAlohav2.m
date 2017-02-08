%new version project frossard
%image comm project
%function [DecTot] = RandomSlottedAlohav3(G,P,Z)
%N : users number
%P : Degree Distribution %a0+ a1*x .... aN*xN
DecTot=0; 
 Z = 100;
 G=1;
P=[0 0 0.5 0.28 0 0 0 0 0.22];
Cw = 100;
 X=[];
for d=1:Z
    d
%P=0.1+zeros(1, 10);
N = floor(G*Cw);
PC= cumsum(P);
Essays = zeros(1,N);
for j=1:N
    x = rand();
    z = PC-x;
    a = z;
    a(a<0)=[];
    Essays(j)=min(find(z==a(1)))-1;
end
Timer1 = zeros(N, max(Essays))-100;
for j=1:N
    if Essays(j)~=0
    for l=1:Essays(j)
    Timer1(j, l)=1+floor(rand()*Cw);
    end
    end
end
% Timer1= 1+floor(rand(N, Essays)*Cw);%associate random values to each component
A= unique(Timer1(:));%find the used slots
A(A<0)=[];
for j=1:length(A)   %try to see for each slot which packets have been transmitted
    [a, ~] = find(Timer1==A(j));
    X(j, a)=1;
end
B = rref(X);%row echelon form
B = B(any(B, 2),:);%remove zero rows
Dec =0;
for k = 1:size(B, 1)
    b= find(B(k,:)==1);
    if (numel(b)==1)
        Dec=Dec+1;
    end
end
Dec = Dec/N;
DecTot = DecTot+Dec/Z;
end
