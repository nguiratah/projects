% MY_DEMODULATOR Minimum distance slicer
% Z = MY_DEMODULATOR(Y, MAP) demodulates vector Y
% by finding the element of the specified constellation that is
% closest to each element of input Y. Y contains the outputs of
% the matched filter of the receiver, and it can be a row or
% column vector. MAP specifies the constellation used, it can
% also be a row or column vector.
% Output Z has the same dimensions as input Y.
% The elements of Z are M-a
function Z = my_demodulator(Y, MAP)
for j =1:length(Y)
    H = abs(MAP(1:length(MAP)) - Y(j)); %% distance between MAP(i)  and Y(j)
    [A, B]= min(H); %% B is the position of the minimum of H
    Z(j) = B-1;
end
end