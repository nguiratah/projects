%initialisation des constantes
tf=[961.9,327.5]; % température de fusion
tm=20; %température du moule
L=[105,24.1]; % chaleur latente
k=[419,33]; %conductivité thermique
Cp=[0.234,0.129]; %capacité thermique
rho=[9.1,10.3]; % Densité
%calcul de a
for i=1:2 % compteur pour chaque matériax
a(i)=L(i)/(Cp(i)*(tf(i)-tm)); % calcul de a
end
beta=[0 0]; %initalisation de béta
for i=1:2
beta(i)=1/(2*a(i));
end
for i=1:2
 for j=1:5 % cinq itérations largement suffisant pour la méthode de Newton (convergence rapide) 
 f(i)=a(i)*sqrt(pi)*erfv1(beta(i))*exp(beta(i)^2)-1;
 g(i)=2*(a(i)+1)*(beta(i)^2)+1;
 beta(i)=beta(i)*(1-(f(i)/g(i))); %calcul de béta pour chaque matériau
 end
end
for i=1:2
neta(i)=k(i)/(Cp(i)*rho(i));%calcul de néta
end
%nb=0.000001;% pas de temps
t=1:0.000001:21; %definition de l'intervervalle de temps
for i=1:2
x(i,:)= 2*beta(i)*sqrt(neta(i)*t);
end
for i =1:2
z=t(1:length(t)-1); % -1 car la différence finie ajoute un terme au vecteur
y=t(1:length(t));
figure(1);
subplot(4,1,1); plot(y,x(1,:),'red');
xlabel t(s), ylabel épaisseur_(mm) , title ('évolution de l épaisseur du front de solidification en fonction du temps (Argent)')
subplot(4,1,2); plot(z,diff(x(1,:)));
xlabel t(s), ylabel vitesse_(mm/s) , title ('profil de vitesse de solidification (Argent)')
subplot(4,1,3); plot(y,x(2,:),'red');
xlabel t(s), ylabel épaisseur_(mm) , title ('évolution de l épaisseur du front de solidification en fonction du temps (plomb)')
subplot(4,1,4); plot(z,diff(x(2,:)));
xlabel t(s), ylabel vitesse_(mm/s) , title ('profil de vitesse de solidification (plomb)')
end
%for i=1:2
%valeur(i)=x(i,10/nb);%contient la valeur de l'epaisseur cherchée
%end