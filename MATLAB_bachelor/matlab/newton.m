function newton(x)
for i=1:100
ffp=f(x)/fprim(x);
if (abs(ffp)<1.e-6)
break;
end
x = x - ffp;
fprintf('i = %d, x = %e \n',i,x)
end
end
function f=f(x)
  f= x*x*x-x-3;
end
function fprim=fprim(x)
  fprim= 3*x*x-1;
end
