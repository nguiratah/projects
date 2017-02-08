function [r,number_spikes] = firingrate ( filename , N , width )
%firingrate.m  calculate the firingrate from spike times
%   taken from the bird data
%   
%   filename: name of the file with the responses.
%      Each row in the file corresponds to a single trial
%   N: In MILLISECONDS, you can specify how late spikes will
%      still be considered. The default is 2000, which is the length
%      of the stimulus.
%   width:  the width of the Gaussian window. PLAY WITH THIS AND SEE
%     WHAT HAPPENS!
%
%   OUTPUT:  r is a vector of length N, hence, at millisecond precision
%
%   NOTE: spiketimes are recorded in MILLISECONDS
%     i.e.,   325.7234   means there was a spike occuring 325.7234 milliseconds
%      after the beginning of the experiment
%   Here, we use the Gaussian window

spiketimes = dlmread(filename);

[ T, C ] = size(spiketimes);

spikeraster = zeros(1,N);
for t=1:T,
    for c=1:C,
        currentspiketime = ceil(spiketimes(t,c));
        if currentspiketime>0 & currentspiketime<N+1,
            spikeraster(currentspiketime) = spikeraster(currentspiketime)+1;
        end
    end
end
number_spikes=sum(spikeraster);
% Normalize since there were T trials
normspikeraster = 1/T * spikeraster;

% Apply the window
 WLAG = 5*width;
window = exp(-[-WLAG:WLAG].^2./(2*width));
window = window/sum(window);  % we use a normalized window
r = conv(normspikeraster,window);

%another window
%  window = hamming(10*width)/sum(hamming(10*width));
%  r = conv(normspikeraster, window);

% Finally, a small correction due to the matlab function CONV...
% NO NEED TO WORRY ABOUT THIS unless you want to...
r = r(WLAG+1:WLAG+N)*1000;
end

