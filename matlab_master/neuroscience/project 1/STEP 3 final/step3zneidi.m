%step3v2
clear all;
close all;
clc;
T =2000;
for j=1:20
    fileID = fopen(['matlabSTRF/data/l2a_bad/songrip/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimgoodcons{j}  = audioread(c1{1, 1}{1, 1}); 
    firespikegoodcons{j} = firingrate(['matlabSTRF/data/l2a_bad/songrip/spike' num2str(j)], T, 400);
end
    Windowlength= [100 125 150];
    h_lasso = cell(0);
    b_lasso = zeros(1,3);
    MSE_lasso = zeros(1,3);
    MSE_test = zeros(1,3);
    h_normal = cell(0);
    b_normal = zeros(1, 3);
    MSE_normal = zeros(1, 3);
    MSE_test_normal = zeros(1, 3);
    Fmax_normal = [];
    Fmax_lasso = [];
    
for m = 1 : 3
    J = 32 * Windowlength(m);
    
    for k = 1 : 20
        [stimulus{k}, response{k}] = calc(Windowlength(m),stimgoodcons{k}, firespikegoodcons{k});
    end
    stimulitot_train = [];
    responsetot_train = [];

    for l = 1 :17,
        responsetot_train = [responsetot_train response{l}];
        stimulitot_train = [stimulitot_train stimulus{l}];
    end

    stimulitot_test = [];
    responsetot_test = [];
    for j = 18:20,
        responsetot_test = [responsetot_test response{j}];
        stimulitot_test = [stimulitot_test stimulus{j}];
    end

    
    A = cov([stimulitot_train;responsetot_train]'); 
    Cs = A(1:J,1:J);
    Crs = A(1:J, J+1);
%     h_normal{m, 1} = inv(Cs)*Crs;
%     [~, Fmax1]= max(abs(h_normal{m, 1}));
%     Fmax_normal = [Fmax_normal Fmax1];
%     b_normal(1,m)  = mean(responsetot_train) - h_normal{m,1}'*mean(stimulitot_train, 2);
%     MSE_normal(1,m) = mean((responsetot_train-h_normal{m,1}'*stimulitot_train-b_normal(1,m)).^2)/var(responsetot_train);



    %lasso 
    lambda=  find_lambdamax_l1_ls(Cs', Crs);
    h_lasso{m,1} = l1_ls(Cs, Crs, lambda/1e4);
%     [~,Fmax1] =max(abs(h_lasso{m,1}));
%     Fmax_lasso = [Fmax_lasso Fmax1];
    b_lasso(1,m)  = mean(responsetot_train) - h_lasso{m,1}'*mean(stimulitot_train, 2);
    MSE_lasso(1,m) = mean((responsetot_train-h_lasso{m,1}'*stimulitot_train-b_lasso(1,m)).^2)/var(responsetot_train);

    %Evaluation of our prediction on the rest of the data
    predicted_test_response=h_lasso{m,1}'*stimulitot_test+b_lasso(1,m);
    MSE_test(1,m)= mean((responsetot_test-predicted_test_response).^2)/var(responsetot_test);
    figure();
    plot([1:length(responsetot_test)],responsetot_test,'ro',[1:length(responsetot_test)],predicted_test_response,'b*');
    a=100+(m-1)*25;
    title(['True measured responses compared to the predictions for windowlengt' num2str((a))]) ;
    xlabel('Trials number');
    ylabel('Responses values');
    legend('True measured responses','Predicted responses');
end

%   figure();
%  subplot(3,1,1);
%  plot([1:length(h_normal{1,1})],h_normal{1,1});
%  title('Regression vector h for windowlength = 100');
%  subplot(3,1,2);
%  plot([1:length(h_normal{2,1})],h_normal{2,1});
%  title('Regression vector h for windowlength = 125');
%  subplot(3,1,3);
%  plot([1:length(h_normal{3,1})],h_normal{3,1});
%  title('Regression vector h for windowlength = 150');
 
figure();
 subplot(3,1,1);
 plot([1:length(h_lasso{1,1})],h_lasso{1,1});
 title('Regression vector h for windowlength = 100 : Lasso');
 subplot(3,1,2);
 plot([1:length(h_lasso{2,1})],h_lasso{2,1});
 title('Regression vector h for windowlength = 125 Lasso');
 subplot(3,1,3);
 plot([1:length(h_lasso{3,1})],h_lasso{3,1});
 title('Regression vector h for windowlength = 150 Lasso');
 
