function [nb_packets_not_expired] = no_feedback(lambda, TD, D, N, P, G, K)
%lambda : rate of packet arrivals
%TD : deadline
%D : Spread Delay
%N : Maximum number of packets
%P : Channel probability of erasure
%G : number of simulations
nb_packets_not_expired = 0;
DecodingTime = 0;
for h = 1 : G
nb_packs = 0;
DecTime  = 0;
T=[];
D = 3 + floor(N/lambda);
i=0;
while(length(T)<N)
    i=i+1;
    R = poissrnd(lambda);
    j=0;
    while (and(j<R,length(T)<N))
        T =[T,i+TD]; 
        j=j+1;
    end
end
T = T-D;
j=0;
m=0;
while and(j<K , m<N)
j=j+1;
    z = rand(1);
    if z>P
        m=m+1;
    end
end
if m==N
    T = T-K;
    nb_packs = sum(T>0);
else
    nb_packs = 0;
end
%DecodingTime = DecodingTime + DecTime;
nb_packets_not_expired = nb_packets_not_expired+nb_packs;
end
nb_packets_not_expired = nb_packets_not_expired/G;
%DecodingTime = DecodingTime/G;