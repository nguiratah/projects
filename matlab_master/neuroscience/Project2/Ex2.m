load('rates_all');
N = 1000;
dummy = 10^-40;
p=zeros(1, N);
for k =1: 184
    a = hist(rates_all(:,k),N)/numel(rates_all(:,k));
    p(k, :) =  a;
    H(k)=-p(k,:)*log(p(k, :)+dummy)';
end
x = sort(H);
x =x(184-25:184);
x = fliplr(x);
neurons = [];
for l=1:26
    neurons=[neurons find(H==x(l))];
if numel(neurons)>26
    neurons = neurons(1:26);
    break;
end
end
