function bits=text2bits(text)

uni_s=unicode2native(text);
bits=dec2bin(uni_s,8)';
bits=flipud(bits);
bits=str2num(bits(:));

