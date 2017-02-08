function phi=EQM(p,mu);

% phi=EQM(p,mu);
% Estimation of mean square error (EQM) on 250 runs. 
% "Prediction" of white noise
% p predictor order, mu adaptation coefficient
% phi averaged EQM
% Partial average displayed every 10 runs

res = zeros(250,1);

for k=1:250,
   x=randn(500,1);
   [pred,hfil] = pred_LMS(x,p+1,500,zeros(p,1),mu,0);
   res(k) = var(x(p+1:end)-pred(p+1:end));
   if mod(k,10)==0,
      [k mean(res(1:k))]
   end
end;

phi = mean(res);
