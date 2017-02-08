function[beta]= beta(alpha)
w=2*pi*(0:0.05:0.95);
beta=ones(1,length(w));
num = ones(1, length(w));
denum=ones(1, length(w));
for l=1:length(w)
    for k=1:length(alpha)
        if (1-exp(1i*(alpha(k)-w(l))))==0
            num(l)=num(l)*-1;
        else
            num(l)=num(l)*(1-exp(1i*(alpha(k)-w(l))));
            denum(l)=denum(l)*(1i*(w(l)-alpha(k))); 
        end
    end
    beta(l) = num(l)/denum(l);
end
