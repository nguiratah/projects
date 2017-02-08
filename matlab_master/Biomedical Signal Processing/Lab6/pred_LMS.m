function [pred,hfil] = pred_LMS(x,deb,fin,w0,mu,Aff);

%[pred,hfil] = pred_LMS(x,deb,fin,w0,mu,Aff)
% linear adaptive prediction using standard LMS. 
% Outputs: pred prediction vector 
% pred same length as x, predicted values same indices, zeros for non predicted samples
% hfil time evolution of filter vector.
% Inputs: x data vector. deb, fin, indices of beginning and end of prediction. 
% w0 initial filter vector. 
% mu adaptation coefficient.
% Aff = 0 no plot, Aff <> 0 plot

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
    fil = fil + 2 * mu * err * v ;
end

if Aff==1,
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
end
