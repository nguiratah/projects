%Projet.m 
%Methode du simplexe  
clear all 
% variable de travail 
o1=0 
p1=0 
q1=0 
r1=0 
s1=0 
o2=0 
p2=0 
q2=0 
r2=0 
s2=0 
o3=0 
p3=0 
q3=0 
r3=0 
s3=0 
o4=0 
p4=0 
q4=0 
r4=0 
s4=0 
o5=0 
p5=0 
q5=0 
r5=0 
s5=0 
% A et cible matrices représentant le système d’équations  
A=[-1 0 -1 -1;-1 -1 0 -1;-1 -1 -1 0;-1 1 1 1;-2 0 0 0] 
I = eye (5) 
matrice =[A, I] 
cible= [-21;-18;-16;-1;-16] 
%  découpage de la matrice par colonne x1 x2 x3 x4 x5 x6 x7x8 x9 
C1=matrice(:,1) 
C2=matrice(:,2) 
C3=matrice(:,3) 
C4=matrice(:,4) 
C5=matrice(:,5) 
C6=matrice(:,6) 
C7=matrice(:,7) 
C8=matrice(:,8) 
C9=matrice(:,9) 
% itération de base x5 x6 x7 x8 x9 variables de base 
B=[C5 C6 C7 C8 C9] 
cible1= inv(B)*cible 
base= [0 0 0 0 0] 
Max = base * cible1 
%  variable x1 x2 x3 x4 x5  de base 
B=[C1 C2 C3 C4 C5]; 
S1= inv(B)*cible 
base = [-1 -1 -1 -1 0]; 
Max1 = base * S1 
%  variable x1 x2 x3 x4 x6  de base 
B=[C1 C2 C3 C4 C6]; 
S2= inv(B)*cible 
base = [-1 -1 -1 -1 0]; 
Max2 = base * S2 
%  variable x1 x2 x3 x4 x7  de base 
B=[C1 C2 C3 C4 C7]; 
S3= inv(B)*cible 
base = [-1 -1 -1 -1 0]; 
Max3 = base * S3 
%  variable x1 x2 x3 x4 x8  de base 
B=[C1 C2 C3 C4 C8]; 
S4= inv(B)*cible 
base = [-1 -1 -1 -1 0]; 
Max4 = base * S4 
%  variable x1 x2 x3 x4 x9  de base 
B=[C1 C2 C3 C4 C9]; 
S5= inv(B)*cible 
base = [-1 -1 -1 -1 0]; 
Max5 = base * S5 
Max1 
Max2 
Max3 
Max4 
Max5 
%  Max1 supérieur 
if ((Max1 >= Max2)&( Max1 >= Max3)&( Max1 >= Max4)&( Max1 >= Max5)&(S1(1,1)>=0)&(S1(2,1)>=0)&(S1(3,1)>=0)&(S1(4,1)>=0)&(S1(5,1)>=0)) 
         disp('max1 est la solution'); 
         Max1 
         disp('x1='); 
         S1(1,1) 
         disp('x2='); 
         S1(2,1) 
         disp('x3='); 
         S1(3,1) 
         disp('x4='); 
         S1(4,1) 
     else 
          
         p1=1; 
end; 
if ((p1==1)&( Max2 >= Max3)&( Max2 >= Max4)&( Max2 >=Max5)&(S2(1,1)>=0)&(S2(2,1)>=0)&(S2(3,1)>=0)&(S2(4,1)>=0)&(S2(5,1)>=0)) 
            disp('max2 est la solution'); 
            Max2 
            disp('x1='); 
            S2(1,1) 
            disp('x2='); 
            S2(2,1) 
            disp('x3='); 
            S2(3,1) 
            disp('x4='); 
            S2(4,1) 
        else 
             
            o1=1;
            end 
if ((o1==1)&( Max3 >= Max4)&( Max3 >= Max5)&(S3(1,1)>=0) & (S3(2,1)>=0) &(S3(3,1)>=0)& (S3(4,1)>=0)& (S3(5,1)>=0)) 
            disp('max3=est la solution'); 
            Max3 
            disp('x1='); 
            S3(1,1) 
            disp('x2='); 
            S3(2,1) 
            disp('x3='); 
            S3(3,1) 
            disp('x4='); 
            S3(4,1) 
        else 
             
            q1=1; 
end 
if ((q1==1)&( Max4 >= Max5)&(S4(1,1)>=0) & (S4(2,1)>=0) & (S4(3,1)>=0)& (S4(4,1)>=0)&(S4(5,1)>=0)) 
            disp('max4=est la solution'); 
            Max4 
            disp('x1='); 
            S4(1,1) 
            disp('x2='); 
            S4(2,1) 
            disp('x3='); 
            S4(3,1) 
            disp('x4='); 
            S4(4,1) 
        else 
             
            r1=1; 
end 
if ((r1==1)&(S5(1,1)>=0) & (S5(2,1)>=0) & (S5(3,1)>=0)& (S5(4,1)>=0)& (S5(5,1)>=0)) 
            disp('max5=est la solution'); 
            Max5 
            disp('x1='); 
            S5(1,1) 
            disp('x2='); 
            S5(2,1) 
            disp('x3=');
                S5(3,1) 
            disp('x4=');
                 S5(4,1) 
        else 
             
            s1=1; 
end 
%  Max2 supérieur 
if ((Max2 >= Max1)&( Max2 >= Max3)&( Max2 >= Max4)&( Max2 >= Max5)&(S2(1,1)>=0)&(S2(2,1)>=0)&(S2(3,1)>=0)&(S2(4,1)>=0)&(S2(5,1)>=0)) 
         disp('max2 est la solution'); 
         Max2 
         disp('x1='); 
         S2(1,1) 
         disp('x2='); 
         S2(2,1) 
         disp('x3='); 
         S2(3,1) 
         disp('x4='); 
         S2(4,1) 
     else 
          
         p2=1; 
end 
if ((p2==1)&( Max1 >= Max3)&( Max1 >= Max4)&( Max1 >=Max5)&(S1(1,1)>=0)&(S1(2,1)>=0)&(S1(3,1)>=0)&(S1(4,1)>=0)&(S1(5,1)>=0)) 
            disp('max1 est la solution'); 
            Max1 
            disp('x1='); 
            S1(1,1) 
            disp('x2='); 
            S1(2,1) 
            disp('x3='); 
            S1(3,1) 
            disp('x4='); 
            S1(4,1) 
        else 
             
            o2=1; 
end 
if ((o2==1)&( Max3 >= Max4)&( Max3 >= Max5)&(S3(1,1)>=0) & (S3(2,1)>=0)&(S3(3,1)>=0)& (S3(4,1)>=0)& (S3(5,1)>=0))
  disp('max3=est la solution'); 
            Max3
                    disp('x1='); 
            S3(1,1) 
            disp('x2='); 
            S3(2,1) 
            disp('x3='); 
            S3(3,1) 
            disp('x4='); 
            S3(4,1) 
        else 
             
            q2=1; 
end 
if ((q2==1)&( Max4 >= Max5)&(S4(1,1)>=0) & (S4(2,1)>=0) & (S4(3,1)>=0)& (S4(4,1)>=0)&(S4(5,1)>=0)) 
            disp('max4=est la solution'); 
            Max4 
            disp('x1='); 
            S4(1,1) 
            disp('x2='); 
            S4(2,1) 
            disp('x3='); 
            S4(3,1) 
            disp('x4='); 
            S4(4,1) 
        else 
             
            r2=1; 
end
if ((r2==1)&(S5(1,1)>=0) & (S5(2,1)>=0) & (S5(3,1)>=0)& (S5(4,1)>=0)& (S5(5,1)>=0)) 
            disp('max5=est la solution'); 
            Max5 
            disp('x1='); 
            S5(1,1) 
            disp('x2='); 
            S5(2,1) 
            disp('x3='); 
            S5(3,1) 
            disp('x4='); 
            S5(4,1) 
        else 
             
            s2=1; 
end
%  Max3 supérieur 
if ((Max3 >= Max1)&( Max3 >= Max2)&( Max3 >= Max4)&( Max3 >=Max5)&(S3(1,1)>=0)&(S3(2,1)>=0)&(S3(3,1)>=0)&(S3(4,1)>=0)&(S3(5,1)>=0)) 
         disp('max3 est la solution'); 
         Max3 
         disp('x1='); 
         S3(1,1) 
         disp('x2='); 
         S3(2,1) 
         disp('x3='); 
         S3(3,1) 
         disp('x4='); 
         S3(4,1) 
     else 
          
         p3=1; 
end 
if ((p3==1)&( Max1 >= Max2)&( Max1 >= Max4)&( Max1 >=Max5)&(S1(1,1)>=0)&(S1(2,1)>=0)&(S1(3,1)>=0)&(S1(4,1)>=0)&(S1(5,1)>=0)) 
            disp('max1 est la solution'); 
            Max1 
            disp('x1='); 
            S1(1,1) 
            disp('x2='); 
            S1(2,1) 
            disp('x3='); 
            S1(3,1) 
            disp('x4='); 
            S1(4,1) 
        else 
             
            o3=1; 
end 
if ((o3==1)&( Max2 >= Max4)&( Max2 >= Max5)&(S2(1,1)>=0) & (S2(2,1)>=0)&(S2(3,1)>=0)& (S2(4,1)>=0)& (S2(5,1)>=0)) 
            disp('max2=est la solution'); 
            Max2 
            disp('x1='); 
            S2(1,1) 
            disp('x2='); 
            S2(2,1) 
            disp('x3='); 
            S2(3,1) 
            disp('x4=');
            S2(4,1) 
        else 
             
            q3=1; 
end 
if ((q3==1)&( Max4 >= Max5)&(S4(1,1)>=0) & (S4(2,1)>=0) & (S4(3,1)>=0)& (S4(4,1)>=0)&(S4(5,1)>=0)) 
            disp('max4=est la solution'); 
            Max4 
            disp('x1='); 
            S4(1,1) 
            disp('x2='); 
            S4(2,1) 
            disp('x3='); 
            S4(3,1) 
            disp('x4='); 
            S4(4,1) 
        else 
             
            r3=1; 
end 
if ((r3==1)&(S5(1,1)>=0) & (S5(2,1)>=0) & (S5(3,1)>=0)& (S5(4,1)>=0)& (S5(5,1)>=0)) 
            disp('max5=est la solution'); 
            Max5 
            disp('x1='); 
            S5(1,1) 
            disp('x2='); 
            S5(2,1) 
            disp('x3='); 
            S5(3,1) 
            disp('x4='); 
            S5(4,1) 
        else 
             
            s3=1; 
end
%  Max4 supérieur 
if ((Max4 >= Max1)&( Max4 >= Max2)&( Max4 >= Max3)&( Max4 >=Max5)&(S4(1,1)>=0)&(S4(2,1)>=0)&(S4(3,1)>=0)&(S4(4,1)>=0)&(S4(5,1)>=0)) 
         disp('max4 est la solution');
             Max4 
         disp('x1='); 
         S4(1,1) 
         disp('x2='); 
         S4(2,1) 
         disp('x3='); 
         S4(3,1) 
         disp('x4='); 
         S4(4,1) 
     else 
          
         p4=1; 
end 
if ((p4==1)&( Max1 >= Max2)&( Max1 >= Max3)&( Max1 >=Max5)&(S1(1,1)>=0)&(S1(2,1)>=0)&(S1(3,1)>=0)&(S1(4,1)>=0)&(S1(5,1)>=0)) 
            disp('max1 est la solution'); 
            Max1 
            disp('x1='); 
            S1(1,1) 
            disp('x2='); 
            S1(2,1) 
            disp('x3='); 
            S1(3,1) 
            disp('x4='); 
            S1(4,1) 
        else 
             
            o4=1; 
end 
if ((o4==1)&( Max2 >= Max3)&( Max2 >= Max5)&(S2(1,1)>=0) & (S2(2,1)>=0)&(S2(3,1)>=0)& (S2(4,1)>=0)& (S2(5,1)>=0)) 
            disp('max2=est la solution'); 
            Max2 
            disp('x1='); 
            S2(1,1) 
            disp('x2='); 
            S2(2,1) 
            disp('x3='); 
            S2(3,1) 
            disp('x4='); 
            S2(4,1) 
        else 
             
            q4=1; 
            end 
if ((q4==1)&( Max3 >= Max5)&(S3(1,1)>=0) & (S3(2,1)>=0) & (S3(3,1)>=0)& (S3(4,1)>=0)&(S3(5,1)>=0)) 
            disp('max3=est la solution'); 
            Max3 
            disp('x1='); 
            S3(1,1) 
            disp('x2='); 
            S3(2,1) 
            disp('x3='); 
            S3(3,1) 
            disp('x4='); 
            S3(4,1) 
        else 
             
            r4=1; 
end 
if ((r4==1)&(S5(1,1)>=0) & (S5(2,1)>=0) & (S5(3,1)>=0)& (S5(4,1)>=0)& (S5(5,1)>=0)) 
            disp('max5=est la solution'); 
            Max5 
            disp('x1='); 
            S5(1,1) 
            disp('x2='); 
            S5(2,1) 
            disp('x3='); 
            S5(3,1) 
            disp('x4='); 
            S5(4,1) 
        else 
             
            s4=1; 
end 
%  Max5 supérieur 
if ((Max5 >= Max1)&( Max5 >= Max2)&( Max5 >= Max3)&( Max5 >=Max4)&(S5(1,1)>=0)&(S5(2,1)>=0)&(S5(3,1)>=0)&(S5(4,1)>=0)&(S5(5,1)>=0)) 
         disp('max5 est la solution'); 
         Max5 
         disp('x1='); 
         S5(1,1) 
         disp('x2='); 
         S5(2,1)
          disp('x3='); 
         S5(3,1) 
         disp('x4='); 
         S5(4,1) 
     else 
          
         p5=1; 
end 
if ((p5==1)&( Max1 >= Max2)&( Max1 >= Max3)&( Max1 >=Max4)&(S1(1,1)>=0)&(S1(2,1)>=0)&(S1(3,1)>=0)&(S1(4,1)>=0)&(S1(5,1)>=0)) 
            disp('max1 est la solution'); 
            Max1 
            disp('x1='); 
            S1(1,1) 
            disp('x2='); 
            S1(2,1) 
            disp('x3='); 
            S1(3,1) 
            disp('x4='); 
            S1(4,1) 
        else 
             
            o5=1; 
end 
if ((o5==1)&( Max2 >= Max3)&( Max2 >= Max4)&(S2(1,1)>=0) & (S2(2,1)>=0)&(S2(3,1)>=0)& (S2(4,1)>=0)& (S2(5,1)>=0)) 
            disp('max2=est la solution'); 
            Max2 
            disp('x1='); 
            S2(1,1) 
            disp('x2='); 
            S2(2,1) 
            disp('x3='); 
            S2(3,1) 
            disp('x4='); 
            S2(4,1) 
        else 
             
            q5=1; 
end 
if ((q5==1)&( Max3 >= Max4)&(S3(1,1)>=0) & (S3(2,1)>=0) & (S3(3,1)>=0)& (S3(4,1)>=0)&(S3(5,1)>=0)) 
            disp('max3=est la solution'); 
                  Max3 
            disp('x1='); 
            S3(1,1) 
            disp('x2='); 
            S3(2,1) 
            disp('x3='); 
            S3(3,1) 
            disp('x4='); 
            S3(4,1) 
        else 
             
            r5=1; 
end 
if ((r5==1)&(S4(1,1)>=0) & (S4(2,1)>=0) & (S4(3,1)>=0)& (S4(4,1)>=0)& (S4(5,1)>=0)) 
            disp('max4=est la solution'); 
            Max4 
            disp('x1='); 
            S4(1,1) 
            disp('x2='); 
            S4(2,1) 
            disp('x3='); 
            S4(3,1) 
            disp('x4='); 
            S4(4,1) 
        else 
             
            s5=1; 
end
% cas où pas de solution 
if ((o1==1)& (p1==1)& (q1==1)& (r1==1)& (s1==1)&(o2==1)& (p2==1)& (q2==1)&(r2==1)& (s2==1)&(o3==1)& (p3==1)& (q3==1)& (r3==1)& (s3==1)&(o4==1)& (p4==1)&&(q4==1)& (r4==1)& (s4==1)&&(o5==1)& (p5==1)& (q5==1)& (r5==1)& (s5==1))  
disp('pas de solution'); 
end