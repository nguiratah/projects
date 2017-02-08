% IMGREDUCE Reduces image size and grayscale resolution
% Y = IMGREDUCE(X, G, B) reduces the grayscale image X by
% downsampling the image by a factor G in each dimension and by
% reducing the grayscale resolution to B bits per pixel.
% X is an m x n matrix where m and n are the height and the width of
% the image, respectively, measured in pixels. The entries of X are
% values of type UINT8 (unsigned 8-bit integers) between 0 and 255,
% where 0 means black and 255 means white; values in between stand
% for intermediate shades of gray. G must be a positive integer, B
% must be an integer between 1 and 8.
% The output Y is a UINT8 matrix obtained by taking every G-th point
% of X (horizontally and vertically), starting with X(1,1), and scaling
% the values to lie in the interval [0, 2^B-1] such that 0 corresponds
% to black and 2^B-1 corresponds to white.
function Y = imgreduce(X, G, B)
[m, n] = size(X);
z = true;
for i= 1: m
    for j = 1: n
         if or(or(and(X(i , j)>255 ,X(i, j)<0), X(i, j) - round(X(i, j))~=0), or(B- round(B)~=0, and(B<0, B>0)));
            z= false;
            error('all X entries must be integers between 0 and 255')
            break;
        end
    end
    if ~z 
            break;
    end
end            
if z
Y = X(1:G:end,1:G:end);
[m, n] = size(Y);
    for i =1: m
        for j =1: n
            Y(i, j) = round(Y(i, j)/ 2^(B));
        end
    end
    imshow((mat2gray(Y)))
end    
end