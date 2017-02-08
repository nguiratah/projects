% TRANSMIT_BPSK Simulate BPSK transmission across the AWGN channel
% [S_EST, BER] = TRANSMIT_BPSK(S, Es_sigma2) simulates the
% transmission of the bit sequence S over an additive white
% Gaussian noise channel using BPSK modulation.
% S is a row or column vector with the bits to be transmitted.
% Es_sigma2 is the ratio, expressed in dB, of the energy per
% symbol to noise variance at the output of the matched filter
% of the receiver (2 = N0=2).
%
% The function has two return values: S_EST is a vector
% (same dimensions as input S) containing the bit sequence
% estimated by the receiver; BER is the bit error rate, i.e,
% the fraction of bits that were received incorrectly.

function[S_EST, BER] = transmit_bpsk(S, Es_sigma2)

end