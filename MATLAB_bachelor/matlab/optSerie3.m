%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     	        
%                                                         %
% M�thodes de descente pour l''optimisation non lin�aire  %              
% sans contraintes                                        %              
% 					                  % 
% Frank-Crittin Michael Themans				  % 
% IMA-ROSO Mars 2003		                          % 
%  					                  % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
clear; % n�cessaire pour l''interface graphique
 
%%%%%%%%%%%%%%%% 
%% Interface    %	         		
%%%%%%%%%%%%%%%%
 
% nom de la fonction � minimiser, qui est sp�cifi�e dans le fichier 'f1.m'  
% et qui est d�clar�e sous forme de string

fct = 'f1' ; 
 
% point initial 

x = [-1.5; -2] ; 
 
%%%%%%%%%%%%%%%%%%
%% Parametres     %		   
%%%%%%%%%%%%%%%%%%
 
% pour le crit�re d''arr�t 

epsilon = 0.001 ; 
maxiter = 200   ;  
 
% taille de pas initial 

alpha = 1 ; 
 
% initialisation du nombre d''iterations 

i=1 ;  
 
% initialisation de la matrice qui stocke tous les it�r�s 
% un it�r�=une colonne de cette matrice

stock(:,1) = x; 

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Boucle principale 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 

% Critere d''arret: ( normGradient(fct,x) < epsilon ) OR ( i > maxiter )

while ( normGradient(fct,x) >= epsilon ) & ( i < maxiter )
  
% Methode BFGS, la direction et H
% � implementer...

% H = (fct,H,x,x_old)
% d = ....


% calculer la taille du pas
alpha  = taillepas(fct,x,d); 
    
% calcul du nouvel it�r� 

x = x + alpha * d;
 
% mise � jour du nombre d''iterations

i = i+1;   
 
% stockage de la valeur des diff�rents it�r�s   

stock(:,i)= x ; 
 
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Affichage des r�sultats  %				   
%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% calcul la taille de la matrice contenant tous les it�r�s	  
    
taille = size(stock,2); 
     
% �valuation de la fonction en chaque point 
     
for i=1:taille 
valeurstock(i)=feval(fct,stock(:,i)); 
end 
     
disp('Valeur de la suite des it�r�s :') ; 
stock' 

disp('*****************************************')
disp(['Nombre d''it�rations :                   ' num2str(i-1)])
disp(['Valeur de la fonction � l''optimum : ' num2str(feval(fct,x))] ) ; 
disp('Valeur de l''optimum : ')  
xOptim = x' 
disp('*****************************************')
         
% passage au module de visualisation de la fonction et des r�sultats 
    
visual3d(fct, stock, valeurstock); 
     
clear; 
 
% sprintf('Nombre de fois que la boucle a �t� parcourue : %d',i)                    



