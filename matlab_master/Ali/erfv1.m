function [erf] = erfv2(x)
erf = 2*x-x^3*2/3+ x^5*1/5;
erf = erf/sqrt(pi);
end