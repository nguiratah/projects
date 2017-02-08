function data=read_txt(filename)
% read data from a text file
% usage example: data=read_txt('data.txt')

fid=fopen(filename, 'r');

i=1;

%assume that there are at most 400 bits (this is equivalent to 50
%characters).
data=zeros(1,400);
 while feof(fid) == 0
    
    bit = fgetl(fid);
    if numel(bit) 
        if (str2num(bit)~=1) && (str2num(bit)~=0)
            error('only values of 0 and 1 are accepted');
        end
        data(i)=str2num(bit);
        i=i+1;
    end
    

 end
 
 data=data(1:i-1);
 data=data(:);