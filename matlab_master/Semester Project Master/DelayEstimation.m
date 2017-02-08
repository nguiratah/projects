function[delay] = DelayEstimation(Ts,x,y, w, K)
[fouriercoefxn1, fouriercoefxn2]=(findft(Ts, K, x, w));
[fouriercoefyn1, fouriercoefyn2]=(findft(Ts, K, y, w));
% check if their have the same absolute value
%if (abs(fouriercoefyn1)==abs(fouriercoefxn1))
poly1 = inv(w'*w)*w'*angle(fouriercoefyn1.*conj(fouriercoefxn1));
poly2 = inv(w'*w)*w'*angle(fouriercoefyn2.*conj(fouriercoefxn2));
% else
% poly1 = inv(w'*w)*w'*angle(fouriercoefyn1.*conj(fouriercoefxn2));
% poly2 = inv(w'*w)*w'*angle(fouriercoefyn2.*conj(fouriercoefxn1));  
% end
delay=[poly1(1),poly2(1)];

%end
