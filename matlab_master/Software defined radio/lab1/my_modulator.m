% MY_MODULATOR Maps a vector of M-ary integers to constellation points
% Y = MY_MODULATOR(X, MAP) outputs a vector of (possibly complex)
% symbols from the constellation specified as second parameter,
% corresponding to the integer valued symbols of X.
% Input X can be a row or column vector, and output Y has the same
% dimensions as X.
% If the length of MAP is M, then the message symbols of X
% must be integers between 0 and M-1.
function Y = my_modulator(X, MAP)
z = true;
for i= 1 :length(X)
    if (X(i) - round(X(i)))~=0 %to check if X(i) is  integer
        z =  false;
        break;
    end
end
if (max(X)<length(MAP) && (min(X)>=0)&& z) 
for j = 1 : length(X)
    Y(j) = MAP(X(j)+1);
end
else
    error('the message symbols of X must be integers between zero and M-1');
end