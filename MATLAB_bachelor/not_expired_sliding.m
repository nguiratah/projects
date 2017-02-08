%function [nb_packets_not_expired] = not_expired_sliding(lambda, TD, D, N, P, G)
%function [DecodingTime] = not_expired_sliding(lambda, TD, D, N, P, G, L)
function [nb_packets_not_expired] = not_expired_sliding(lambda, TD, D, N, P, G, L)
%lambda : rate of packet arrivals
%TD : deadline
%D : Spread Delay
%N : Maximum number of packets
%P : Channel probability of erasure
%G : number of simulations
%n : sliding window size
nb_packets_not_expired = 0;
DecodingTime = 0;
for h = 1 : G
nb_packs = 0;
DecTime  = 0;
T=[];
for i = 1 : D
    R = poissrnd(lambda);
    j=0;
    while (and(j<R,length(T)<N))
        T =[T,i+TD]; 
        j=j+1;
    end
end
T = T-Ts;
for  j =1 : length(T)
     z = 0;
     if P ==1
            for p =1 : length(T)
                T(p) = -1;
            end
            DecTime = DecTime +6*TD;
            break;
     end
    while(z<P)
        if T(length(T))<0
            break;
        end
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