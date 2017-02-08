rounded_rates = round(rates_all);
histneuro = zeros(max(max(rounded_rates)), max(max(rounded_rates)));
for k=1:max(max(rounded_rates))+1
            for l =1: max(max(rounded_rates))+1
                           for r= 1:208
                               if and(rounded_rates(r, 140)==k-1, rounded_rates(r, 177)==l-1)
                                   histneuro(k, l)=  histneuro(k, l)+1;
                               end
                           end
            end
end
histneuro = histneuro/(sum(sum(histneuro)))