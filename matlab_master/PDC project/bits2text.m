function text=bits2text(estim_bits)

estim_bits=estim_bits(:); % turn the bit sequence into a column vector

% remove the tail, if necessary; length should be multiple of 8  bits. 
estim_bits=estim_bits(1:numel(estim_bits)-mod(numel(estim_bits),8));

% reshape into an nx8 matrix and convert into a text of n characters. 
%text=native2unicode(bi2de(reshape(estim_bits, 8, [])'))';

aux=reshape(estim_bits, 8, [])';
text=native2unicode(bin2dec(num2str(fliplr(aux))))';
disp(text)