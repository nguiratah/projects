
% Cette fonction calcule la norme du gradient

function valueNG = normGradient(fonc,xcurrent)

% Evalue la fonction en xcurrent

[f,g]=feval(fonc, xcurrent);

% calcule de la norme du gradient au point courant

valueNG = norm(g);
