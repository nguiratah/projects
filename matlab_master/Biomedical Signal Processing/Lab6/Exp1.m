%%Exp1 lab6
%%Serge Hochar And Mohamed Tahar Nguira.
%%Copyright Material. 
load('Heart_5.dat')
heart1 = resample(Heart_5(:,1)-mean(Heart_5(:,1)), 1, 4);
heart2 = resample(Heart_5(:,2)-mean(Heart_5(:,2)), 1, 4);
heart3 = resample(Heart_5(:,3)-mean(Heart_5(:,3)), 1, 4);
mu1 = 1/(length(heart1)*var(heart1));
mu2 = 1/(length(heart2)*var(heart2));
mu3 = 1/(length(heart3)*var(heart3));
[a1, g1]= lpc(heart1, 4);
[a2, g2]= lpc(heart2, 4);
[a3, g3]= lpc(heart3, 4);
% figure();
% pred_LMS(heart1,6, length(heart1),a1',mu1,1);
% figure();
% pred_LMS(heart2,6, length(heart2),a2',mu2,1);
% figure();
% pred_LMS(heart3,6, length(heart3),a3',mu3,1);
% figure();
% pred_NLMS(heart1, 6, length(heart1),a1', 0.15);
% figure();
% pred_NLMS(heart2, 6, length(heart2),a2', 0.15);
% figure();
% pred_NLMS(heart3, 6, length(heart3),a3', 0.15);
figure();
pred_RLS(heart1, 6, length(heart1),a1',0.001*eye(4), 0.97);
figure();
pred_RLS(heart2, 6, length(heart2),a2',0.001*eye(4), 0.97);
figure();
pred_RLS(heart3, 6, length(heart3),a3',0.001*eye(4), 0.97);
