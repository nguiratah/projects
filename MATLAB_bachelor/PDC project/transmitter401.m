clear all;
A=read_txt('data.txt');
[m,n] = size(A);
fs = 32000;
t1 = 0:1/fs:0.1;

silence=zeros(size(t1));

f=500;
z = sin(2.*pi.*f.*t1);
for i=1:m
    if A(i,1)==1
        z = [z sin(2.*pi.*f.*t1)  silence];
        
    elseif A(i,1)==0
        z = [z  silence sin(2.*pi.*f.*t1)];
    end
end

sound(z,fs,24);

