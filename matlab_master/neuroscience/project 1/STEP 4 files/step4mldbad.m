close all;
clc;
clear all;
interval = -9999:10000; 
dictionary = zeros(10, 20000);
P = 20;
FS = 32000;
sigma =400;
for j=1:20
    fileID = fopen(['matlabSTRF/data/mld_bad/conspecific/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimbad{j}  = audioread(c1{1, 1}{1, 1}); 
    responsebad{j} = totalspikes(['matlabSTRF/data/mld_bad/conspecific/spike' num2str(j)], 2000);
end
for j=1:10
    fileID = fopen(['matlabSTRF/data/mld_bad/flatrip/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimbad{j+20}  = audioread(c1{1, 1}{1, 1}); 
    responsebad{j+20} = totalspikes(['matlabSTRF/data/mld_bad/flatrip/spike' num2str(j)], 2000);

end
for j=1:20
    fileID = fopen(['matlabSTRF/data/l2a_bad/songrip/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimbad{j+30}  = audioread(c1{1, 1}{1, 1}); 
    responsebad{j+30} = totalspikes(['matlabSTRF/data/l2a_bad/songrip/spike' num2str(j)], 2000);
end
stimuli_train = [];
response_train = [];

for j = 1 : 40
    response_train = [response_train responsebad{j}];
    N = length(responsebad{j});
    X = abs(fft(stimbad{j}));
    stimuli_train = [stimuli_train X(1:20000)];
end
%Crossvalidation
stimuli_test = [];
response_test = [];
for j = 41 : 50
    response_test = [response_test responsebad{j}];
    N = length(responsebad{j});
    X = abs(fft(stimbad{j}));
    stimuli_test = [stimuli_test X(1:20000)];
end

for k = 1 : P+1
    dictionary(k,:) = exp(-((interval-(1000*(k-1)-10000)).^2)/(sigma^2));
end
for k = 1 : P+1
     dictionary(k,:) = log(1 + exp(-(interval-(1000*(k-1)-10000)).^2/400^2));
end

stimuliDic_train = dictionary*stimuli_train;
A = cov([stimuliDic_train;response_train]'); 
Cs = A([1:P+1],[1:P+1]);
Crs = A([1:P+1], P+2);
lambda=  find_lambdamax_l1_ls(Cs', Crs);
g = l1_ls(Cs, Crs, lambda/1e9)
h = (dictionary'*g)';
b = mean(response_train) - h*mean(stimuli_train,2);
MSE = mean((response_train - h*stimuli_train-b).^2)/var(response_train);
predicted_test_response = h*stimuli_test+b;
MSE_test= mean((response_test-predicted_test_response).^2)/var(response_test);
plot([1:10],response_test,'ro',[1:10],predicted_test_response,'b*');
title('True measured responses compared to the predictions');
xlabel('Trials number');
ylabel('Predicted value');
legend('True measured responses','Predicted responses');

close all;
clc;
clear all;
interval = -9999:10000; 
dictionary = zeros(10, 20000);
P = 20;
FS = 32000;
sigma =400;
for j=1:20
    fileID = fopen(['matlabSTRF/data/mld_bad/conspecific/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimbad{j}  = audioread(c1{1, 1}{1, 1}); 
    responsebad{j} = totalspikes(['matlabSTRF/data/mld_bad/conspecific/spike' num2str(j)], 2000);
end
for j=1:10
    fileID = fopen(['matlabSTRF/data/mld_bad/flatrip/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimbad{j+20}  = audioread(c1{1, 1}{1, 1}); 
    responsebad{j+20} = totalspikes(['matlabSTRF/data/mld_bad/flatrip/spike' num2str(j)], 2000);

end
for j=1:20
    fileID = fopen(['matlabSTRF/data/mld_bad/bengalese/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimbad{j+30}  = audioread(c1{1, 1}{1, 1}); 
    responsebad{j+30} = totalspikes(['matlabSTRF/data/mld_bad/bengalese/spike' num2str(j)], 2000);
end
stimuli_train = [];
response_train = [];

for j = 1 : 40
    response_train = [response_train responsebad{j}];
    N = length(responsebad{j});
    X = abs(fft(stimbad{j}));
    stimuli_train = [stimuli_train X(1:20000)];
end
%Crossvalidation
stimuli_test = [];
response_test = [];
for j = 41 : 50
    response_test = [response_test responsebad{j}];
    N = length(responsebad{j});
    X = abs(fft(stimbad{j}));
    stimuli_test = [stimuli_test X(1:20000)];
end

% for k = 1 : P+1
%     dictionary(k,:) = exp(-((interval-(1000*(k-1)-10000)).^2)/(sigma^2));
% end
for k = 1 : P+1
     dictionary(k,:) = log(1 + exp(-(interval-(1000*(k-1)-10000)).^2/400^2));
end

stimuliDic_train = dictionary*stimuli_train;
A = cov([stimuliDic_train;response_train]'); 
Cs = A([1:P+1],[1:P+1]);
Crs = A([1:P+1], P+2);
lambda=  find_lambdamax_l1_ls(Cs', Crs);
g = l1_ls(Cs, Crs, lambda/1e9)
h = (dictionary'*g)';
% b = mean(response_train) - h*mean(stimuli_train,2);
% MSE = mean((response_train - h*stimuli_train-b).^2)/var(response_train);
% predicted_test_response = h*stimuli_test+b;
% MSE_test= mean((response_test-predicted_test_response).^2)/var(response_test);
% plot([1:10],response_test,'ro',[1:10],predicted_test_response,'b*');
% title('True measured responses compared to the predictions');
% xlabel('Trials number');
% ylabel('Predicted value');
% legend('True measured responses','Predicted responses');
[~, Freq] = max(h);

