 function [nb_packets_not_expired_block] = nofeedbackslidingv2(lambda, TD, D, N, P, G, size_window, K, s)
%               lambda = 25;         
%               G = 1000;
%               N  = 25;
%               size_window = 15;
%               s=1;
%               K  =60;
%               TD =60;
%               P =0.75;
nb_packets_not_expired_block = 0;
D  = floor(size_window/lambda) +3;
DecodingTime = 0;
for h = 1 : G
nb_packs = 0;
DecTime  = 0;
T=[];
i = 0;
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
SP = size_window;
SR =0;
a = 0;
while SP<=N
    i=0;  
    if SR>SP
          disp('__________________________________________________________________________________')
    end
      g = SR;
      while and(and(i<K,SR<g+size_window ), SR<SP)
      i = i+1;
      z = rand(1);
      if z>P
          SR = SR+1;
      end
      end
     if (SR==SP)
        T(a+1:SR) = T(a+1:SR)-i;
        T(SR+1 : length(T)) = T(SR+1 : length(T))-K;
        nb_packs = nb_packs + sum(T(a+1:SP)>=0);
        a= SR;
     elseif (SR==g+size_window)
        T(a+1:SP-size_window) = T(a+1:SP-size_window)-K;
        T(SP-size_window+1:SP) = T(SP-size_window+1:SP) - i;
        T(SP:length(T)) = T(SP:length(T))-K;
        nb_packs = nb_packs + sum(T(SP-size_window+1:SP)>=0);
        T(SP-size_window+1:SP) = T(SP-size_window+1:SP)-100*TD;
    else  T(a+1 : length(T)) =  T(a+1 : length(T))-K;
     end
    SP = SP+s;
end
i=0;
SP = mod(length(T)-size_window, s);
SR = 0;
while and(i<floor(K*mod(N, s)/s),SR<SP)
    z = rand(1);
    if z>P
        SR = SR+1;
    end
    i = i+1;
end
if (SP==SR)
    for x = length(T) +1-mod(length(T)-size_window,s) : length(T)
            T(x) = T(x)-i;
    end
    nb_packs = nb_packs + sum(T(length(T) +1-mod(length(T)-size_window,s) : length(T))>=0);
end
nb_packets_not_expired_block = nb_packets_not_expired_block+nb_packs;
end
nb_packets_not_expired_block = nb_packets_not_expired_block/G;
end