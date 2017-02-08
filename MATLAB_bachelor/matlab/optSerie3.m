%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     	        
%                                                         %
% Méthodes de descente pour l''optimisation non linéaire  %              
% sans contraintes                                        %              
% 					                  % 
% Frank-Crittin Michael Themans				  % 
% IMA-ROSO Mars 2003		                          % 
%  					                  % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
clear; % nécessaire pour l''interface graphique
 
%%%%%%%%%%%%%%%% 
%% Interface    %	         		
%%%%%%%%%%%%%%%%
 
% nom de la fonction à minimiser, qui est spécifiée dans le fichier 'f1.m'  
% et qui est déclarée sous forme de string

fct = 'f1' ; 
 
% point initial 

x = [-1.5; -2] ; 
 
%%%%%%%%%%%%%%%%%%
%% Parametres     %		   
%%%%%%%%%%%%%%%%%%
 
% pour le critère d''arrêt 

epsilon = 0.001 ; 
maxiter = 200   ;  
 
% taille de pas initial 

alpha = 1 ; 
 
% initialisation du nombre d''iterations 

i=1 ;  
 
% initialisation de la matrice qui stocke tous les itérés 
% un itéré=une colonne de cette matrice

stock(:,1) = x; 

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Boucle principale 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 

% Critere d''arret: ( normGradient(fct,x) < epsilon ) OR ( i > maxiter )

while ( normGradient(fct,x) >= epsilon ) & ( i < maxiter )
  
% Methode BFGS, la direction et H
% à implementer...

% H = (fct,H,x,x_old)
% d = ....


% calculer la taille du pas
alpha  = taillepas(fct,x,d); 
    
% calcul du nouvel itéré 

x = x + alpha * d;
 
% mise à jour du nombre d''iterations

i = i+1;   
 
% stockage de la valeur des différents itérés   

stock(:,i)= x ; 
 
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Affichage des résultats  %				   
%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% calcul la taille de la matrice contenant tous les itérés	  
    
taille = size(stock,2); 
     
% évaluation de la fonction en chaque point 
     
for i=1:taille 
valeurstock(i)=feval(fct,stock(:,i)); 
end 
     
disp('Valeur de la suite des itérés :') ; 
stock' 

disp('*****************************************')
disp(['Nombre d''itérations :                   ' num2str(i-1)])
disp(['Valeur de la fonction à l''optimum : ' num2str(feval(fct,x))] ) ; 
disp('Valeur de l''optimum : ')  
xOptim = x' 
disp('*****************************************')
         
% passage au module de visualisation de la fonction et des résultats 
    
visual3d(fct, stock, valeurstock); 
     
clear; 
 
% sprintf('Nombre de fois que la boucle a été parcourue : %d',i)                    



