%
% A replacement for the AWGN function in the Communications Toolbox
% by Robert Morelos-Zaragoza for EE251-Fall 2002 students at SJSU
%
function [r]=awgn(x,snr)
sigma = sqrt(10.0^(-snr/10.0));
if isreal(x)
    r=x+sigma*randn(size(x));
else
    r=(real(x)+sigma*randn(size(x))) +i*(imag(x)+sigma*randn(size(x)));
end;