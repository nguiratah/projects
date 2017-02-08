function h = gen2par(g); 
%GEN2PAR Converts generator matrix to parity-check matrix in GF(2). 
%       H = GEN2PAR(G) computes parity-check matrix H from generator matrix G. 
%       The function can also used to convert parity-check matrix to generator 
%       matrix. The conversion is used in GF(2) only. 
% 
%       See also: CYCLGEN, HAMMGEN. 
 
%       Wes Wang 10/5/95 
%       Copyright (c) 1995-96 by The MathWorks, Inc. 
%       $Revision: 1.1 $  $Date: 1996/04/01 17:57:58 $ 
 
[n,m] = size(g); 
if n >= m 
    error('The input for GEN2PAR is not a generator or parity-check matrix') 
end; 
 
I = eye(n); 
if abs(max(max(g(:, 1:n)-I))) == 0 
    h = [g(:,n+1:m)' eye(m-n)]; 
elseif abs(max(max(g(:, m-n+1:m)-I))) == 0 
    h = [eye(m-n) g(:,1:m-n)']; 
else 
    error('The input for GEN2PAR is not a generator or parity-check matrix') 
end; 
 
%--end of GEN2PAR 