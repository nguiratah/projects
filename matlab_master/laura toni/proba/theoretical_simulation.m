function [P] = theoretical_simulation(TD,P, nb_packets)
%%TD : deadline
%%P : Probability of not innovative
%%nb_packets : number of packets
Pi = 0;
for i =nb_packets :(TD)
    Pi = Pi+nchoosek(i-1, nb_packets-1).*((P).^(i-nb_packets)).*(1-P)^(nb_packets);
end;
P = Pi;


    