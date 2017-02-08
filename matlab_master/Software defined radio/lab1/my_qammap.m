% MY_QAMMAP Creates constellation for square QAM modulations
% C = MY_QAMMAP(M) outputs a 1M vector with the
% constellation for the quadrature amplitude modulation of
% alphabet size M, where M is the square of an integer power
% of 2 (e.g. 4, 16, 64, ...).
% The signal constellation is a square constellation.
function C = my_qammap(n)
if mod(log2(n), 2)~= 0
    error('M must be in the form M = 2^(2K), where K is a positive integer.');
else
    x = -sqrt(n)+1 :2 : sqrt(n)-1;
    y = sqrt(n)-1 :-2 : -sqrt(n)+1;
    [X, Y]= meshgrid(x, y);
    H = X+j*Y;
    C = H(:).';
end 