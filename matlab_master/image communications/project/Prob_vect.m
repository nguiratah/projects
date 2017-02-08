function [Proba_vect]=Prob_vect(step)
P = 0:step:1;
Proba_vect_init=allcomb(P,P,P,P,P,P,P,P,P,P);
s1=size(Proba_vect_init,1);
Position= sum(Proba_vect_init,2)==1;
Proba_vect=Proba_vect_init(Position,:);
end