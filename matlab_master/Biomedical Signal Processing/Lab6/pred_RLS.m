function [pred,hfil,Omf] = pred_RLS(x,deb,fin,w0,Om0,lam);

%[pred,hfil,Omf] = pred_RLS(x,deb,fin,w0,Om0,lam);
% linear adaptive prediction using standard RLS. 
% Outputs: pred prediction vector
% pred same length as x, predicted values same indices, zeros for non predicted samples
% hfil time evolution of filter vector.
% Omf final correlation matrix inverse
% Inputs: x data vector. deb, fin, indices of beginning and end of prediction. 
% w0 initial filter vector. 
% Om0 initial correlation matrix inverse. standard 0.001*eye(p)   p order
% lam adaptation coefficient.

x = x(:);
w0 = w0(:);

pred = zeros(length(x),1);

hfil = [];
w = w0;
p = length(w0);
Om = Om0;

for k=deb:fin,
   hfil = [hfil ; w'];
   y = x(k-1:-1:k-p);
   pred(k) = w'*y;
   z = Om * y;
   g = z / (lam + y'*z);
   alpha = x(k) - y'*w;
   w = w + alpha * g;
%    pred(k) = w'*y;
   Om = (Om - g*z')/lam;
end

Omf = Om;

subplot(211)
plot(deb:fin,x(deb:fin),'b',deb:fin,x(deb:fin)-pred(deb:fin),'r')
v = max(abs(x(deb:fin)));
axis([deb fin -1.2*v 1.2*v])
title('signal (blue), prediction error (red)')
subplot(212)
plot(hfil)
v = max(max(abs(hfil)));
axis([deb fin -1.2*v 1.2*v])
title('evolution of predictor coefficients')
subplot(111)
