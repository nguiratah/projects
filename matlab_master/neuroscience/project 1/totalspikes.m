function [number_spikes] = totalspikes(filename,N)
spiketimes = dlmread(filename);
[ T, C ] = size(spiketimes);
spikeraster = zeros(1,N);
for t=1:T,
    for c=1:C,
        currentspiketime = ceil(spiketimes(t,c));
        if currentspiketime>0 & currentspiketime<N+1,
            spikeraster(currentspiketime) = spikeraster(currentspiketime)+1;
        end
    end
end
number_spikes=sum(spikeraster);
end