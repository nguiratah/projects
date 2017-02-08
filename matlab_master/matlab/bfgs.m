% Quasi-Newton - Mise à jour BFGS (Definition 13.1)
% doit retourner la matrice H

function h = bfgs(fonc,H,x,xold)

[f, g]= feval(fonc, x);
[f1, g1]= feval(fonc, xold)
g = g-g1;
z = x-xold
h = H + ((g*g')/(g'*(z))) - (H*(z)*(z)'*H)/((z)'*H*(z)); 
