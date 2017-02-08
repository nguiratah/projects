% initialisation
A=[1 -1 -2 -1 1 0 0; 2 0 1 -4 0 1 0 ; -2 1 0 1 0 0 1];
b=[4;2;1];
c=[-1;2;3;4;0;0;0];
Jo=[5 6 7];
jo=[1 2 3 4] ;
% initialisation des indices des variables en base

U=0;
k=0;
% step1 : la matrice B

while U==0
B= A(:,Jo) ;
p=1 ;

% step 2
cbar = zeros(1, 7);
for j = 1 : 4
    cbar(jo(j)) = c(jo(j)) - c(Jo)'*inv(B)*A(:,jo(j)) ;
end;
while  and(cbar(jo(j))>0,j<5)
   cbar
   j = j+1;
end
if j==4 
    U=1;
end
%step 4
x= zeros(7,1);
x(Jo)=inv(B)*b;

%step 5
d=zeros(7,1);
d(Jo)= -inv(B)*A(:,jo(j));
d(jo(j))=1 ;

% step 6 + 7
lambda=zeros(7,1) ;

for p=1:7 
    lambda(p)=1000000000000000000000;
end;
for i=1:7
    if (d(i) < 0)
        lambda(i) =-x(i)/d(i);
    end
end
[lambdal ,I]=min(lambda);
l = min(I);


% step 8
if lambdal==1000000000000000000000 ;
U=1;
end
% step 9 
h =1;
while h<=3
    if Jo(h)==l;
        w = Jo(h);
        Jo(h)=jo(j);
        jo(j)=w;
        h=5;
    end
    h = h+1;
end
   Jo = sort(Jo);
   jo = sort(jo);
   k=k+1;
   if k ==100
       U = 1;
   end
end




