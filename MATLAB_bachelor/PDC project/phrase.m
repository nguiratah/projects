M = 'Je pense donc je suis rene decartes'
%new encode 
y = dec2bin(double(M), 7);
z = reshape(y', 1, numel(y)) 