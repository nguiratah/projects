clear all;
fileID = fopen('data.txt');
A = textscan(fileID,'%s');
A = reshape(A', 1, numel(A));   
x=A{1}{1}
l = length(x);
fs = 32000;
t1 = 0:1/fs:0.05;
silence=zeros(size(t1));
f= 500;
z = 10*sin(2.*pi.*f.*t1);
for i=1:l
    if x(i)=='1'
      %  f=320;
        z = [z 10*sin(2.*pi.*f.*t1)  silence];
    elseif x(i)=='0'
       % f=320;
        z = [z  silence 10*sin(2.*pi.*f.*t1)];
    end
end
 sound(z,fs,24);
% 
% Fs = 32000;
% T=10;
% recObj = audiorecorder(Fs,24,1);
% recordblocking(recObj, T);
% sig = getaudiodata(recObj);
% plot(sig)
