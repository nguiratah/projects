function [L_vect]=L_vect(P)
L =0:P;
Proba_vect_init=allcomb(L,L);
Position= sum(Proba_vect_init,2)==P;
L_vect=Proba_vect_init(Position,:);
end