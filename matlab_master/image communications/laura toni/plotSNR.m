 %%plot SNR for zero forcing and filtering methods.
 function[] = plot
 Pdb =-5:0.01:10;
 a0 =1;
 a1 =-1/2;
 N  =2;
 P = 10.^(Pdb/10);
 S1 = (a0^2-a1^2)*P/(N/2);
 S2 = (a0^2-a1^2)*P./((N*(a0^2 + a1^2)/2)+P*(a0+a1)^2);
 figure();
 plot(Pdb, S1,'-', Pdb, S2, '*');
 %plot(P, S1);