%step3v2
clear all;
close all;
clc;
T =2000;

%%l2a good conspecific
for j=1:20
    fileID = fopen(['matlabSTRF/data/l2a_good/conspecific/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimgoodcons{j}  = audioread(c1{1, 1}{1, 1}); 
    firespikegoodcons{j} = firingrate(['matlabSTRF/data/l2a_good/conspecific/spike' num2str(j)], T, 400);
end
    Windowlength= 100;
    FutWindowlength = 20;
    J = 32 * (Windowlength+FutWindowlength);
for k = 1 : 20
    [stimulusgoodcons{k}, responsegoodcons{k}] = calc_fut(Windowlength,FutWindowlength,stimgoodcons{k}, firespikegoodcons{k});
end
stimulitot_train = [];
    responsetot_train = [];

    for l = 1 :17,
        responsetot_train = [responsetot_train responsegoodcons{l}];
        stimulitot_train = [stimulitot_train stimulusgoodcons{l}];
    end

    stimulitot_test = [];
    responsetot_test = [];
    for j = 18:20,
        responsetot_test = [responsetot_test responsegoodcons{j}];
        stimulitot_test = [stimulitot_test stimulusgoodcons{j}];
    end
A = cov([stimulitot_train;responsetot_train]');
Cs = A(1:J,1:J);
Crs = A(1:J, J+1);
hl2agoodconspecific = inv(Cs)*Crs;
bl2agoodconspecific = mean(responsetot_train) - hl2agoodconspecific'*mean(stimulitot_train, 2);
MSEl2agoodconspecific = mean((responsetot_train-hl2agoodconspecific'*stimulitot_train-bl2agoodconspecific).^2)/var(responsetot_train);
figure();
plot([1:length(hl2agoodconspecific)],sort(hl2agoodconspecific)); 
title('sorted regression vector without lasso l2a_good conspecific' );
[l2agoodcpnspecificmax, posmaxl2agoodconspecific]= max(hl2agoodconspecific);
 %%lasso 
lambda=  find_lambdamax_l1_ls(Cs', Crs);
hlassol2agoodconspecific = l1_ls(Cs, Crs, lambda/1e4);%lambda max = 3.0532e-04
blassol2agoodconspecific  = mean(responsetot_train) - hlassol2agoodconspecific'*mean(stimulitot_train, 2);
MSElassol2agoodconspecific = mean((responsetot_train-hlassol2agoodconspecific'*stimulitot_train-blassol2agoodconspecific).^2)/var(responsetot_train);
figure();
plot((hlassol2agoodconspecific));
title('regression vector with sparsity condition : lambda = 6.47528e-07 l2a_good conspecific');
predicted_test_response=hlassol2agoodconspecific'*stimulitot_test+blassol2agoodconspecific;
MSE_test= mean((responsetot_test-predicted_test_response).^2)/var(responsetot_test);
figure();
plot([1:length(responsetot_test)],responsetot_test,'ro',[1:length(responsetot_test)],predicted_test_response,'b*');
title('True measured responses compared to the predictions for future window length 20');
xlabel('Trials number');
ylabel('Responses values');
legend('True measured responses','Predicted responses');