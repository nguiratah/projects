% initialisation
A=[1 -1 -2 -1 1 0 0; 2 0 1 -4 0 1 0 ; -2 1 0 1 0 0 1];
b=[4;2;1];
c=[-1;2;3;4;0;0;0];

% initialisation des indices des variables en base
Jo=[5 6 7];
j = [1 2 3 4]
U=1;

% step1 : la matrice B
while U==1,
B= A(:,Jo) ;
 
% step 2
j =



%step 4
x= zeros(7,1);
x(vB)=inv(B)*b ;

%step 5
d=zeros(7,1);
d(vB)= -inv(B)*A(:,k);
d(k)=1 ;
dcheck=ones(7,1);
for i=1:7
    dcheck(i)=min(0,d(i)) ;
end
v=zeros(7,1);
if dcheck==v ;
    U=0;
    break
end

% step 6 + 7
lambdal=11000;
for i=1:3
    q=vB(i);
    lambda(i)=-x(q)/d(q);
    lambdal=min(lambdal, lambda(i));
end
% step 9 + +
vB(1)=k;
B=A(:,vB);
x=x+lambdal*d
end



