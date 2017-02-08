%function [DecodingTime] = not_expired_encoded(lambda, TD, D, N, P, G)
function [nb_packets_not_expired] = not_expired_encoded(lambda, TD, D, N, P, G)
%lambda : rate of packet arrivals
%TD : deadline
%D : Spread Delay
%N : Maximum number of packets
%P : Channel probability of erasure
%G : number of simulations
nb_packets_not_expired = 0;
DecodingTime = 0;
D = 3 + floor(N/lambda);
for h = 1 : G
nb_packs = 0;
DecTime  = 0;
T=[];
i=0;
while length(T)<N
    i=i+1;
    R = poissrnd(lambda);
    j=0;
    while (and(j<R,length(T)<N))
        T =[T,i+TD]; 
        j=j+1;
    end
end
T=T-D;
for j = 1 : length(T)
    z = 0;
    while(and(z<P, T(j)>=0))
         z = rand(1);
        T = T-1;
        DecTime = DecTime +1;
    end
    if T(length(T))<0
       DecTime = DecTime + 5*TD;
       break;
    end
end 
nb_packs = sum(T>=0);
DecodingTime = DecodingTime + DecTime;
nb_packets_not_expired = nb_packets_not_expired+nb_packs;
end
nb_packets_not_expired = nb_packets_not_expired/G;
DecodingTime = DecodingTime/G;