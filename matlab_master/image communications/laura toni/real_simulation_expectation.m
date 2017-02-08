function [Expectation] = real_simulation_expectation(N,TD, P, nb_packs)
%N : Number of loops
%TD : Deadline
%P : Probability of erasure
%nb_packs : Number of packets
TOT_DEC_GEN=0;
Expectation = 0;
for i = 1 : N
    count_rc_pck=0;
    for t =1 : TD+1
        x= rand(1);
        if (x>P)
            count_rc_pck=count_rc_pck +1;
        end
        if (count_rc_pck==nb_packs)
            TOT_DEC_GEN= TOT_DEC_GEN +1;
            Expectation = Expectation + t;
            break;
        end
        if t>TD
            Expectation = Expectation +10*TD;
        end
    end
end
Expectation = Expectation/N;