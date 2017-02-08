function g=diffe(L,fe);

% generation de filtre diff�rentateur avec coupure
% L longueur du filtre (impaire). 
% fe fr�quence d'�chantillonnage

% fc fr�quence de coupure (normalis�e)
fc = 0.5;
L2=(L-1)/2;
fil=-L2:L2;
fil = fil + (fil==0);
fil = -sin(2*pi*fc*fil)./fil./fil/pi + 2*fc*cos(2*pi*fc*fil)./fil;
fil(L2+1)=0;
g = fe*fil'.*hamming(L);
