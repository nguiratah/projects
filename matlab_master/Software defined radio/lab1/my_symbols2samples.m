% MY_SYMBOLS2SAMPLES Produces the samples of the modulated signal
% Z = MY_SYMBOLS2SAMPLES(Y, H, USF) produces the samples of a
% modulated pulse train. The sampled pulse is given in vector H,
% and the symbols modulating the pulse are contained in vector Y.
% USF is the upsampling factor, i.e., the number of samples per symbol.
% It is the the ratio between the sampling frequency (Fs)
% and the symbol frequency (Fd), USF=Fs/Fd.
function Z = my_symbols2samples(Y, H, USF)
X = upsample(Y, USF);
X = X(:);
Z = conv(X, H);
end