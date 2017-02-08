load('rates_all');
N = 1000;
dummy = 10^-40;
p=zeros(1, N);
for k =1: 184
    a = hist(rates_all(:,k),N)/numel(rates_all(:,k));
    p(k, :) =  a;
    H(k)=-p(k,:)*log(p(k, :)+dummy)';
end
%plot(H);
%we can see that the results are more and more accurate when we increase
%the number of bins N;
%b/
tic;
rounded_rates= round(rates_all);
histneuro=zeros(10, 10);
I = zeros(184, 184);
for x=1:184
     for h=1:184
        for k=1:max(max(rounded_rates))+1
            for l =1: max(max(rounded_rates))+1
                 [x h k l]
                histneuro(x, h, k, l)= 0;
                           for r= 1:208
                               if and(rounded_rates(r,x)==k-1, rounded_rates(r, h)==l-1)
                                   histneuro(x, h, k, l)=  histneuro(x, h, k, l)+1;
                               end
                           end
            end
        end
        n=size(histneuro);
        a=zeros(n(3),n(4));
        a(:,:)=histneuro(x,h,:,:)/(sum(sum(histneuro(x, h,:,:))));
        I(x, h)= information(a);
    end
end
                