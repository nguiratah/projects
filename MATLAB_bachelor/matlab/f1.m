
function [f,g,h] = f1(x)

% fonction quadratique simple

% routine qui retourne la valeur de la fonction ainsi que de son gradient
% et de son Hessien en un point x

% valeur de la fonction au point x
f = x(1)^2 + 3*x(2)^2 ;		

% valeur du gradient au point x
g = [2*x(1); 6*x(2)] ;

% valeur du Hessien au point x
h = [2 0; 0 6] ;
