P1= 30;
N= [10 100 1000 10000];
x = [1:100];
lambda = 10;
xfact = factorial(x);
EntropyEstimate =zeros(1, 4);
EntropyML = zeros(1, 4);
EntropyMath =(lambda*log2(exp(1))*(1-log(lambda))+exp(-lambda)*sum((lambda.^x).*log2(xfact)./xfact));
for h=1:4
    hhist=0;
    for l=1:P1
    A = poissrnd(lambda, N(h), 1);
    lambdaML= mean(A);
    P = hist(A,max(A))/N(h);
    P(P==0)=[];
     hhist=hhist+ sum(P.*log2(1./P));
    EntropyML(h) = EntropyML(h)+(lambdaML*log2(exp(1))*(1-log(lambdaML))+exp(-lambdaML)*sum((lambdaML.^x).*log2(xfact)./xfact))/P1;
    end
    EntropyEstimate(h)=hhist/P1;
end
    plot(N, EntropyEstimate, N, EntropyML);