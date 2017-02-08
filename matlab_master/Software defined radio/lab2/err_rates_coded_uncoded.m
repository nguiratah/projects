% ERR_RATES_CODED_UNCODED Plots error rate vs. Es_N0 for coded and uncoded BPSK modulation
%    [uncoded_BER, coded_BER] = ERR_RATES_CODED_UNCODED(NUM_BITS, Es_sigma2) 
%    simulates the transmission of a sequence of NUM_BITS bits over an AWGN
%    channel using BPSK modulation, both uncoded and coded (with a convolutional
%    code of rate 1/2 and octal generators [5 7]). The second input, Es_sigma2,
%    specifies, in dB, the ratio of the average energy per symbol to the
%    noise variance at the matched filter output (sigma2 = N0/2). It can be 
%    a scalar or a vector containing multiple values.
%
%    The function also plots the bit error rates vs. Es_sigma2

% $Id: err_rates_coded_uncoded.m 1540 2013-01-28 12:55:00Z tarniceriu $

function [uncoded_BER, coded_BER] = err_rates_coded_uncoded(num_bits, Es_sigma2)

    if (nargin < 1)
        num_bits = 1E6;
    end
    
    if (nargin < 2)
    	Es_sigma2 = (3:0.5:12); % ratio of average energy per bit to noise power spectral density, in dB
    end	

	% Allocate space for bit-error-rate
	uncoded_BER = nan(1, length(Es_sigma2));
    coded_BER = nan(1, length(Es_sigma2));
		
    % Initialize wait bar
	h = waitbar(0, '');
	% evaluate coded / uncoded BER by simulation    
    for e = 1: length(Es_sigma2)
        
        waitbar(e/length(Es_sigma2), h, sprintf('Computing error rates for E_s/sigma2 = %2.2f dB', Es_sigma2(e)));
        
        % generate vector of random bits
        s =  randi(2, num_bits, 1) - 1;
        [~, uncoded_BER(e)] = transmit_bpsk(s, Es_sigma2(e));
        [~, coded_BER(e)] = transmit_coded_bpsk(s, Es_sigma2(e));       
		
    end			
	close(h); % close the progress bar when done
	
	%% Plot results	
    
    % theoretical/reference results for comparison
    Eb_N0 = Es_sigma2 - 3; % Es = Eb, sigma2 = N0/2;
    uncoded_BER_theo = berawgn(Eb_N0, 'psk', 2, 'nondiff'); 
    coded_BER_theo_soft_decisions = [0.0035684 0.0015926 0.00064695 0.00024045 8.11e-05 2.64e-05 6.95e-06 1.55e-06 4.5e-07 1e-7];
    
	figure();
    semilogy(Es_sigma2, uncoded_BER, 'ob'); hold on; grid on; % simulated, uncoded
    semilogy(Es_sigma2, uncoded_BER_theo, '-b');              % theoretical, uncoded
    
	semilogy(Es_sigma2, coded_BER, 'sr'); % simulated, coded, soft decisions
    semilogy(Es_sigma2(1:length(coded_BER_theo_soft_decisions)), coded_BER_theo_soft_decisions, '-.r'); % reference, coded, soft decisions
        
    legend('uncoded (simulation)', 'uncoded (theory)', 'coded (simulation, soft decisions)', 'coded (reference, soft decisions)');
    
    xlabel('E_s/\sigma^2 [dB]'); ylabel('Bit Error Rate (BER)');
	title({'Comparison of coded and uncoded BER for BPSK', 'Rate 1/2 convolutional code with octal generators [ 5 7]'});
	axis([Es_sigma2(1) Es_sigma2(end) 1E-6 1E-0]);    
    
end