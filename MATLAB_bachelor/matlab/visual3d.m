%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Module graphique 3d pour une fonction quelconque
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function rep = visual3d(fct, stock, valeurstock)

rotate3d on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT:
%
% fct   : doit etre defini comme un string
% stock : matrice de dimension 2xn qui contient la suite 
%         d''iteres engendree par l''algorithme
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%to initialize the size of x
x=[1 1];
j=1;
i=1;

[X,Y]=meshgrid(-3:.2:3,-3:.2:3);

% calcul de la taille de [X,Y]
[m,n] = size([X,Y]);

% construction de la matrice Z de dessin
for j=1:m
   for i=1:m
      % artifice afin d'utiliser la valeur de la fonction avec le meshgrid
      x(1) = X(1,j);
      x(2) = Y(i,1);
      Z(i,j)=feval(fct,x);
      i=i+1;
   end
   j=j+1;
end

disp('Appuyer sur une touche afin de visualiser la fonction en trois dimensions.');
pause
surf(X,Y,Z);

disp('Appuyer sur une touche afin de voir les courbes de niveau de la fonction.');
pause

% affichage des courbes de niveau
nombrecourbe = 20;
contour(X,Y,Z,nombrecourbe);


% on peut à présent dessiner les itérés sur les courbe de niveaux
hold on
disp('Appuyer sur une touche afin de voir la suite des itérés sur les courbes de niveau.');
pause
plot(stock(1,:),stock(2,:),'ko:');

hold off;

disp('Appuyer sur une touche afin de visualiser l''amélioration de la valeur de la fonction au cours de l''algorithme.');
pause
plot(valeurstock);
% disp('Fin de la visualisation, appuyer sur une touche');
% pause

rep = 'Fin du module visual3d';
