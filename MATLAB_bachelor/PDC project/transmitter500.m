clear all;
A=read_txt('data.txt');
[m,n] = size(A);
fs = 32000;
t1 = 0:1/fs:0.1;
silence=zeros(size(t1));
f=500;
z = sin(2.*pi.*f.*t1);
for i=1:3:m
%     disp(i);
    if i+1>m
        f=1600;
%         disp('a')
    elseif i+2>m
        if A(i+1,1)==1
            f=1200;
%             disp('b')
        elseif A(i+1,1)==0
            f=1400;
%             disp('c')
        end
    else
        
        if A(i+1,1)==1 & A(i+2,1)==1
            f=400;
            %11
%             disp('d')
        elseif A(i+1,1)==0 & A(i+2,1)==1
            f=600;
            %01
%             disp('e')
        elseif A(i+1,1)==1 & A(i+2,1)==0
            f=800;
            %10
%             disp('f')
        elseif A(i+1,1)==0 & A(i+2,1)==0
            f=1000;
            %00
%             disp('g')
        else disp('error')
        end
        
        
    end
    if A(i,1)==1
        z = [z sin(2.*pi.*f.*t1)  silence];
    elseif A(i,1)==0
        z = [z  silence sin(2.*pi.*f.*t1)];
    end
    
end
f=4000;
z = [z 0.3*sin(2.*pi.*f.*t1)  0.3*sin(2.*pi.*f.*t1)];
soundsc(z,fs,24);