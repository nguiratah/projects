%step3v3.1
clear all;
close all;
clc;
T =2000;
for j=1:20
    fileID = fopen(['matlabSTRF/data/l2a_good/songrip/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimgoodcons{j}  = audioread(c1{1, 1}{1, 1}); 
    firespikegoodcons{j} = firingrate(['matlabSTRF/data/l2a_good/songrip/spike' num2str(j)], T, 400);
end
    Windowlength= 100;
    J = 32 * Windowlength;
for k = 1 : 20
    [stimulus{k}, response{k}] = calc(Windowlength,stimgoodcons{k}, firespikegoodcons{k});
end
stimulitot_train = [];
responsetot_train = [];

for l = 1 :15,
    responsetot_train = [responsetot_train response{l}];
    stimulitot_train = [stimulitot_train stimulus{l}];
end

stimulitot_test = [];
responsetot_test = [];
for j = 16:20,
    responsetot_test = [responsetot_test response{j}];
    stimulitot_test = [stimulitot_test stimulus{j}];
end

A = cov([stimulitot_train;responsetot_train]'); 
Cs = A(1:J,1:J);
Crs = A(1:J, J+1);
h = inv(Cs)*Crs;
[maximum_value,sample] =max(h);
b = mean(responsetot_train) - h'*mean(stimulitot_train, 2);
MSE = mean((responsetot_train-h'*stimulitot_train-b).^2)/var(responsetot_train);
figure();
plot([1:3200],h);
 
% %lasso 
% hlasso = l1_ls(Cs, Crs, 1e-6);
% [maximum_value_lasso,sample_lasso] =max(h);
% blasso  = mean(responsetot_train) - hlasso'*mean(stimulitot_train, 2);
% MSElasso = mean((responsetot_train-hlasso'*stimulitot_train-blasso).^2)/var(responsetot_train);
% hlasso_sort = sort(abs(hlasso));
% figure();
% plot([1:3200],hlasso_sort,'k*');
  
%Evaluation of our prediction on the rest of the data
predicted_test_response=h'*stimulitot_test+b;
MSE_test= mean((responsetot_test-h'*stimulitot_test-b).^2)/var(responsetot_test);
plot([1:length(responsetot_test)],responsetot_test,'ro',[1:length(responsetot_test)],predicted_test_response,'b*');
title('True measured responses compared to the predictions');
xlabel('Trials number');
ylabel('Predicted value');
legend('True measured responses','Predicted responses');