function g=filtre_hilbert(L);

% g=filtre_hilbert(L);
% generation de filtre de Hilbert
% TF inverse et fenetre de Hamming
% L longueur du filtre (impaire). 

L2=(L-1)/2;
fil=-L2:L2;
fil = fil + (fil==0);
fil = (1-cos(pi*fil))./fil;
fil(L2+1)=0;
g = fil'.*hamming(L)/pi;
