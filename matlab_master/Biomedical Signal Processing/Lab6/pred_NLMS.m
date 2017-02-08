function [pred,hfil] = pred_NLMS(x,deb,fin,w0,gam);

%[pred,hfil] = pred_NLMS(x,deb,fin,w0,gam)
% linear adaptive prediction using normalized LMS. 
% Outputs: pred prediction vector
% pred same length as x, predicted values same indices, zeros for non predicted samples
% hfil time evolution of filter vector.
% Inputs: x data vector. deb, fin, indices of beginning and end of prediction. 
% w0 initial filter vector. 
% gam adaptation coefficient.

x = x(:);

pred = zeros(length(x),1);

hfil = [];
fil = w0;

p = length(w0);

for k=deb:fin,
    hfil = [hfil ; fil'];
    v = x(k-1:-1:k-p);
    pred(k) = fil'*v;
    err = x(k) - pred(k);
    fil = fil + gam * (x(k) - pred(k)) * v / (0.001 + v'*v);
end

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


