% BITS2IMG Converts a vector of bits to an image
% X = BITS2IMG(S, B, M, N) returns an M x N matrix X whose entries
% are of type UINT8 that is obtained by reconstructing the image from
% the bit sequence S. B is the number of bits per pixel, and M and N
% are the height and width of the image, respectively. The number of
% elements in S must be equal to M*N*B.
function X = bits2img(S, B, M, N)
[k, l] = size(S);
if k*l~=M*N*B
    error('The number of elements of S must be equal to M*N*B')
else
    for i =1: k
        H(i) = bi2de(S(i, 1:B)); %%i have used a function downloaded from internet
    end
    for i=1:N
        for j =(i-1)*M +1 :i*M
            X(i, j) = H(j);
        end
    end
end
            
        
        