close all
clear all
clc
% A = [4 1 1;1 4 1;1 1 4];
% B = [1 1; 1 1];
% C = [ 3 2 -1;  2 4 2; -1 2 3];
% D = [-7 4 1; 4 4 4; 1 4 -5];
% E = [ 4 5 -1; 5 5 5; -1 5 3];
% eig(E);
%%%%%%%%%%%%%%%%%%%b%%%%%%%%%%%%%%%%%
% load hw1p1.mat;
% C = cov(xp1b(1,:),xp1b(2,:))*(length(xp1b(1,:))-1)/length(xp1b(1,:));
% [V, D] = eig(C);
% cov1= cov(xp1c1')*49/50;
% cov2= cov(xp1c2')*49/50;
% [Vcov1, Dcov1] = eig(cov1);
% [Vcov2, Dcov2] = eig(cov2);
% V1= Vcov1(:,1)*sqrt(Dcov1(1, 1));
% V2= Vcov1(:,2)*sqrt(Dcov1(2, 2));
% dcov1=sort(diag(Dcov1, 0));
% dcov2=sort(diag(Dcov2, 0));
% figure();
% scatter(xp1b(1,:),xp1b(2,:), '.');hold on;
% plot([0, V1(1)],[0, V1(2)], 'r','LineWidth', 2);hold on;
% plot([0, V2(1)],[0, V2(2)], 'r', 'LineWidth', 2);
% title('scatter plot of the stimuli and response data')
% xlabel('stimuli');
% ylabel('response');
% hold on
% figure();
% semilogy([1:10],dcov1,'r*', [1:10], dcov2,'xb');
% %Exercise3
load hw1p3;
A = cov([xp3;yp3]');
Cs=A([1:16],[1:16]);
Crs=A([1:16],17);
H=inv(Cs)*Crs
meanR=mean(yp3);
meanS=mean(xp3, 2);
b = meanR - H'*meanS
Him = zeros(4, 4);
Him(1:4, 1) = H(1:4);
Him(1:4, 2) = H(5:8);
Him(1:4, 3) = H(9:12);
Him(1:4, 4) = H(13:16);
Him = Him';
imagesc(Him);
errTrai = 0;
errTrai = mean((yp3-H'*xp3-b).^2)/var(yp3)
%exo4
load hw1p4.mat;
A= cov([[sp4a sp4b];[rp4a rp4b]]');
Cs =A([1:100],[1:100]);
Crs=A([1:100],101);
H = inv(Cs)*Crs;
 meanR=mean([rp4a rp4b]);
 meanS=zeros(1,100);
 W = [sp4a sp4b];
 for l=1:110
    meanS(:) =meanS(:)+(1/110)*W(:,l);
 end
meanS= mean(W, 2);
 b = meanR - H'*meanS;
