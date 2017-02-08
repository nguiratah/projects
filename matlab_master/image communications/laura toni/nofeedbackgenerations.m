 function [nb_packets_not_expired_block , k] = nofeedbackgenerations(lambda, TD, D, N, P, G, size_window, K)
%        lambda = 1;         
%        G = 1;
%        N  = 25;
%        size_window = 8;
%        K =32;
%        TD=60;
%        P=0.75;
k= 0;
nb_packets_not_expired_block = 0;
 D  = floor(size_window/lambda) +3;
DecodingTime = 0;
for h = 1 : G
nb_packs = 0;
DecTime  = 0;
T=[];
i = 0;
%%random arrivals%%
while(length(T)<N)
    R = poissrnd(lambda);
    j=0;
    while (and(j<R,length(T)<N))
        T =[T,i+TD]; 
        j=j+1;
    end
i = i+1;
end
T = T-D;
if size_window>length(T)
    size_window = length(T);
end
t=0;
m=0;
g=0;
%%network coding%%
for  j =0 : floor(length(T)/size_window)-1;
 i =(j*size_window) ;
 g=i;
 %g=m;
 L = t;
%F = f;
 while and(and(i<(j*size_window)+K, m<N), m<g+size_window)
     i=  i+1;
        if(T(m+1)-(i-g)<0) %%check if this packet is expired
         break;
        end
        z = rand(1);
        k = k+1;
     if z>P
         m=m+1;
     end
 end
 T(j*size_window+1 : (j+1)*size_window) = T(j*size_window+1 : (j+1)*size_window)-(i-g);
 if m<g+size_window
 T((j+1)*size_window+1 : length(T)) =  T((j+1)*size_window+1 : length(T))-(i-g);
 else
 T((j+1)*size_window+1 : length(T)) =  T((j+1)*size_window+1 : length(T))-K;
 end
 if m == g+size_window
     nb_packs = nb_packs + sum(T(j*size_window+1:(j+1)*size_window)>=0);
 end
 m = g + size_window;
end
g= m ;
i=0;
while and(i<floor(K*mod(length(T), size_window)/size_window), m<N)
     i=  i+1;
     if T(m+1)<0
      break;
     end
      z = rand(1);
      k = k+1;
     if z>P
         m=m+1;
     end
 end
for x = length(T) +1-mod(length(T), size_window) : length(T)
            T(x) = T(x)-i;
end
if m== mod(length(T), size_window)+g;
    nb_packs = nb_packs +  sum(T(size_window*floor(N/size_window)+1:length(T))>=0);
end
nb_packets_not_expired_block = nb_packets_not_expired_block+nb_packs/G;
end
end