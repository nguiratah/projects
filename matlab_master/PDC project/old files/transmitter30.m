fileID = fopen('phrase.txt');
A = textscan(fileID,'%s');
x=A{1}{1};
l = length(x);
fs = 32000;
t1 = 0:1/fs:1;
z = 0;
t2 =  0:1/fs:0.03;
T = x*0.03;
if T<4
    f=1000;
    z = [z, 10*sin(2.*pi.*f.*t1)];
elseif  T>4 & T<9
        f=1100;
    z = [z, 10*sin(2.*pi.*f.*t1)];
elseif T>9 & T<14
        f=1400;
    z = [z, 10*sin(2.*pi.*f.*t1)];
elseif T>14 & T<20
        f=1600;
    z = [z, 10*sin(2.*pi.*f.*t1)];
else
    f=2000;
    z = [z, sin(2.*pi.*f.*t1)];
end

tspace=0.5;
xspace=zeros(size(tspace));
z = [z, xspace];
    
    

for i=1:l
    if x(i)=='1'
        f=1100;
        z = [z, sin(2.*pi.*f.*t2)];
        
    elseif x(i)=='0'
        f=1110;
        z = [z, 15*sin(2.*pi.*f.*t2)];
        
    end
end
sound(z,fs,24);