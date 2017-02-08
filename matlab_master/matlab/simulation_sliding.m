%%function [Prob] = simulation_sliding(P)
function [Prob] = simulation_sliding(N,TD, P, nb_packs)
%N : Number of loops
%TD : Deadline
%P : Probability of erasure
%nb_packs : Number of packets
TOT_DEC_GEN=0;
j=1;
for i = j : N
    count_rc_pck=0;
    for t =1 : TD
        x= rand(1);
        if (x>P)
            count_rc_pck=count_rc_pck +1;
            j = j+1;
            N = N+1;
        end
        if (count_rc_pck==nb_packs)
            TOT_DEC_GEN= TOT_DEC_GEN +1;
            break;
        end
    end
end
Prob =TOT_DEC_GEN/N ;
