clear all;
close all;
clc;
%step3
fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim1');
c1 =textscan(fileID, '%s');
stim1 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim2');
c1 =textscan(fileID, '%s');
stim2 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim3');
c1 =textscan(fileID, '%s');
stim3 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim4');
c1 =textscan(fileID, '%s');
stim4 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim5');
c1 =textscan(fileID, '%s');
stim5 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim6');
c1 =textscan(fileID, '%s');
stim6 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim7');
c1 =textscan(fileID, '%s');
stim7 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim8');
c1 =textscan(fileID, '%s');
stim8 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim9');
c1 =textscan(fileID, '%s');
stim9 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim10');
c1 =textscan(fileID, '%s');
stim10 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim11');
c1 =textscan(fileID, '%s');
stim11 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim12');
c1 =textscan(fileID, '%s');
stim12 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim13');
c1 =textscan(fileID, '%s');
stim13 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim14');
c1 =textscan(fileID, '%s');
stim14 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim15');
c1 =textscan(fileID, '%s');
stim15 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim16');
c1 =textscan(fileID, '%s');
stim16 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim17');
c1 =textscan(fileID, '%s');
stim17 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim18');
c1 =textscan(fileID, '%s');
stim18 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim19');
c1 =textscan(fileID, '%s');
stim19 = audioread(c1{1, 1}{1, 1});fileID = fopen('matlabSTRF/data/l2a_good/conspecific/stim20');
c1 =textscan(fileID, '%s');
stim20 = audioread(c1{1, 1}{1, 1});
%specify the value of T
T = 2000;
%value of T specified
y1 = firingrate('matlabSTRF/data/l2a_good/conspecific/spike1', T, 400);
y2 = firingrate('matlabSTRF/data/l2a_good/conspecific/spike2', T, 400);
y3 = firingrate('matlabSTRF/data/l2a_good/conspecific/spike3', T, 400);
y4 = firingrate('matlabSTRF/data/l2a_good/conspecific/spike4', T, 400);
y5 = firingrate('matlabSTRF/data/l2a_good/conspecific/spike5', T, 400);
y6 = firingrate('matlabSTRF/data/l2a_good/conspecific/spike6', T, 400);
y7 = firingrate('matlabSTRF/data/l2a_good/conspecific/spike7', T, 400);
y8 = firingrate('matlabSTRF/data/l2a_good/conspecific/spike8', T, 400);
y9 = firingrate('matlabSTRF/data/l2a_good/conspecific/spike9', T, 400);
y10= firingrate('matlabSTRF/data/l2a_good/conspecific/spike10', T, 400);
y11= firingrate('matlabSTRF/data/l2a_good/conspecific/spike11', T, 400);
y12= firingrate('matlabSTRF/data/l2a_good/conspecific/spike12', T, 400);
y13= firingrate('matlabSTRF/data/l2a_good/conspecific/spike13', T, 400);
y14= firingrate('matlabSTRF/data/l2a_good/conspecific/spike14', T, 400);
y15= firingrate('matlabSTRF/data/l2a_good/conspecific/spike15', T, 400);
y16= firingrate('matlabSTRF/data/l2a_good/conspecific/spike16', T, 400);
y17= firingrate('matlabSTRF/data/l2a_good/conspecific/spike17', T, 400);
y18= firingrate('matlabSTRF/data/l2a_good/conspecific/spike18', T, 400);
y19= firingrate('matlabSTRF/data/l2a_good/conspecific/spike19', T, 400);
y20= firingrate('matlabSTRF/data/l2a_good/conspecific/spike20', T, 400);

Windowlength = 100;
J = 32 * Windowlength;
%and so on, and then something like
[Stimulus1, Response1] = calc(Windowlength,stim1, y1);
[Stimulus2, Response2] = calc(Windowlength,stim2, y2);
[Stimulus3, Response3] = calc(Windowlength,stim3, y3);
[Stimulus4, Response4] = calc(Windowlength,stim4, y4);
[Stimulus5, Response5] = calc(Windowlength,stim5, y5);
[Stimulus6, Response6] = calc(Windowlength,stim6, y6);
[Stimulus7, Response7] = calc(Windowlength,stim7, y7);
[Stimulus8, Response8] = calc(Windowlength,stim8, y8);
[Stimulus9, Response9] = calc(Windowlength,stim9, y9);
[Stimulus10, Response10] = calc(Windowlength,stim10, y10);
[Stimulus11, Response11] = calc(Windowlength,stim11, y11);
[Stimulus12, Response12] = calc(Windowlength,stim12, y12);
[Stimulus13, Response13] = calc(Windowlength,stim13, y13);
[Stimulus14, Response14] = calc(Windowlength,stim14, y14);
[Stimulus15, Response15] = calc(Windowlength,stim15, y15);
[Stimulus16, Response16] = calc(Windowlength,stim16, y16);
[Stimulus17, Response17] = calc(Windowlength,stim17, y17);
[Stimulus18, Response18] = calc(Windowlength,stim18, y18);
[Stimulus19, Response19] = calc(Windowlength,stim19, y19);
[Stimulus20, Response20] = calc(Windowlength,stim20, y20);


Response = [Response1 Response2 Response3 Response4 Response5 Response6 Response7 Response8 Response9 Response10 Response11 Response12 Response13 Response14 Response15 Response16 Response17 Response18 Response19 Response20];
Stimulus = [Stimulus1 Stimulus2 Stimulus3 Stimulus4 Stimulus5 Stimulus6 Stimulus7 Stimulus8 Stimulus9 Stimulus10 Stimulus11 Stimulus12 Stimulus13 Stimulus14 Stimulus15 Stimulus16 Stimulus17 Stimulus18 Stimulus19 Stimulus20];

 A = cov([Stimulus;Response]'); 
 Cs = A(1:J,1:J);
 Crs = A(1:J, J+1);
 h = inv(Cs)*Crs;
 b = mean(Response) - h'*mean(Stimulus, 2);
 error = mean((Response-h'*Stimulus-b).^2)/var(Response)
 %%%lasso
% h0=l1_ls(Cs, Crs, 0);%lambda = 0;
% h1=l1_ls(Cs, Crs,1, 1e-6); %lambda= 1;
% h2=l1_ls(Cs, Crs,10, 1e-6);%lambda =10;
% h3=l1_ls(Cs, Crs,100,1e-6);%lambda = 100;
%  figure();
%  plot(h1);
%  title('lasso lambda = 1');
%  figure();
%  plot(h2);
%  title('lasso lambda = 10');
%  figure();
%  plot(h3);
%  title('lambda = 100');
 %% finish step 3
 %%Step 4