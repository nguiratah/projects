%checkrepkernelfunfreqdomain
clear all;
close all;
t=-3:0.10:3;
n=-50:0.25:50;
alpha=[0, 2*pi/3 4*pi/3];
g=@(w)(1);
for s=1:length(alpha)
    g=@(w)(g(w).*(1-exp(1i*(alpha(s)-w)))./(1i*(w-alpha(s)))); %build the filter beta
end
c0=1/feval(g, alpha(3)+1e-10);
c1=c0*exp(-1i*alpha(3)*n);
for k=1:length(t)
    k
    parfor l=1:length(n)
        f=@(w)(g(w).*exp(1i*w*(t(k)-n(l))));
        Xf(l, k)=integral(f, -70, 70)/(2*pi*2); %FREQ =-8pi/3..
    end
end
plot(t, real(c1*Xf./exp(-1i*t*alpha(3))))