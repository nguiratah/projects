%function [DecodingTime] = not_expired_encoded_block(lambda, TD, D, N, P, G, size_window)
function [nb_packets_not_expired] = not_expired_encoded_block(lambda, TD, D, N, P, G, size_window)
%lambda : rate of packet arrivals
%TD : deadline
%D : Spread Delay
%N : Maximum number of packets
%P : Channel probability of erasure
%G : number of simulations
nb_packets_not_expired = 0;
DecodingTime = 0;
D = 3 + floor(size_window/lambda);
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
T = T-D;
for  j =0 : floor(length(T)/size_window)-1;
for i =j*size_window+1 : size_window*(j+1);
    z = 0;
    if P ==1
            for p =1 : length(T)
                T(p) = -1;
            end
            break;
    end
    for x = j*size_window+1 : length(T)
            T(x) = T(x)-1;
    end
    z = rand(1);
    while and((z<P), T(i)>=0)
            for x = j*size_window+1 : length(T)
            T(x) = T(x)-1;
            end
            z = rand(1);
            DecTime = DecTime +1;
    end
    if T(length(T)<0)
    break;
    end
end
end
for i =1 : mod(length(T), size_window)
    z = rand(1);
        for x = length(T) +1-mod(length(T), size_window) : length(T)
            T(x) = T(x)-1;
        end
    if T(length(T))<0
            break;
    end
    DecTime = DecTime +1;
    while and((z<P), T(i)>=0)
    if P ==1
            break;
    end
        for x = length(T) +1-mod(length(T), size_window) : length(T)
            T(x) = T(x)-1;
        end
     z = rand(1);
     DecTime = DecTime+1;
    end
end
if P ==1
    DecodingTime  = 6*TD*G;
    break;
end
if T(length(T))<0
            DecTime = DecTime + 5*TD;
end
nb_packs = sum(T>=0);
DecodingTime = DecodingTime + DecTime;
nb_packets_not_expired = nb_packets_not_expired+nb_packs;
end
nb_packets_not_expired = nb_packets_not_expired/G;
DecodingTime = DecodingTime/G;
end