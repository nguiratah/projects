% MY_PSKMAP Creates constellation for Phase Shift Keying modulation
% C = MY_PSKMAP(M) outputs a 1M vector with the complex symbols
% of the PSK constellation of alphabet size M, where M is an integer power of 2.
function C = my_pskmap(M)
if round(log2(M))-log2(M) ~= 0
    error('M must be an integer power of 2.');
else
    C = exp(2*pi*1i*(0:M-1)/M);
end
