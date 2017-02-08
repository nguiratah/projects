%new version project frossard
%image comm project
function [DecTot] = RandomSlottedAlohav3(G,P,Z, Cw, k)
%N : users number
%P : Degree Distribution %a0+ a1*x .... aN*xN
DecTot=0;
% Z = 1;
% G=0.5;
% P=[0 0 0.5 0.28 0 0 0 0 0.22];
% %P = [0 0 1];
% Cw =10;
N = round(G*Cw);
PC= cumsum(P);
parfor d=1:Z
    [k d]
    X = [];
    Essays = zeros(1,N);
    for j=1:N
        x = rand();
        z = PC-x;
        a = z;
        a(a<0)=[];
        if ~isempty(a)
            Essays(j)=find(z==a(1), 1 )-1;
        else
            Essays(j)=0;
        end
   end
    Timer1 = zeros(N, max(Essays))-100;
    for j=1:N
       if Essays(j)~=0
            for l=1:Essays(j)
                Timer1(j, l)=1+round(rand()*(Cw-1));
                if l~=1
                    a = numel(find(Timer1(j, :)==Timer1(j,l)));
                    while a>1
                           Timer1(j, l)=1+round(rand()*(Cw-1));
                           a = numel(find(Timer1(j, :)==Timer1(j,l)));
                    end
                end                 
            end
        end
    end
    A= unique(Timer1(:));%find the used slots
    A(A<0)=[];
    for j=1:length(A)   %try to see for each slot which packets have been transmitted
        [a, ~] = find(Timer1==A(j));
        X(a, j)=1;
    end
Dec = rrefsergeTahar(X);
Dec = Dec/N;
DecTot = DecTot+Dec/Z;
end