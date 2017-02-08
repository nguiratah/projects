% IMG2BITS Converts an image to a sequence of bits
% S = IMG2BITS(X, B) returns a row vector S that is obtained by
% serializing the image matrix X column by column and then converting
% each value to its binary representation. The conversion to bits is
% 'right-msb'. The number of bits per pixel is given by B; B must be
% larger than or equal ceil(log2(M+1)), where M is the largest value
% of X.

function S = img2bits(X, B)
if or(B - round(B)~=0, B<ceil(log2(max(X)+1)))
    ('error : B must bigger integer and bigger than ceil(log2(max(X)+1))')
else
    H = [];
    [m, n] = size(X);
    for i=1 :m
        H= [H, X(i,1:end)];
    end
    for i=1: length(H)
        z = H(i);
        S(i, 1:B) =de2bi(z);%matlab function downloaded from internet (no communication systems toolbox) 
    end
end
