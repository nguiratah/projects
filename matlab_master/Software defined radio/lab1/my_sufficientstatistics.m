% MY_SUFFICIENTSTATISTICS Processes the output of the channel to generate
% sufficient statistics about the transmitted symbols.
% X = MY_SUFICIENTSTATISTICS(R, H, USF) produces sufficient statistics
% about the transmitted symbols, given the signal received in vector R,
% the impulse response H of the basic pulse (transmitting filter), and
% the integer USF, which is the ratio between the sampling rate and the
% symbol rate (upsampling factor)
function X = my_sufficientstatistics(r, h, usf);
h = fliplr(h) %matched filter
x = conv(r, h);%%matched filter output
X= x(length(h): usf: end-length(h)+1);
%the first useful sample position is length(h) since we have an upsampled signal(h(k)) is non zero 
%when 1=<k<=length(h) , our step is USF and we finish in end-length(h)+1
end