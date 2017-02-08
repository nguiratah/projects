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
    J = 32 * Windowlength;
for k = 1 : 20
    [stimulusgoodcons{k}, responsegoodcons{k}] = calc(Windowlength,stimgoodcons{k}, firespikegoodcons{k});
end
stimuligoodconstot = [];
responsegoodconstot = [];

for k = 1 :20
    responsegoodconstot = [responsegoodconstot responsegoodcons{k}];
    stimuligoodconstot = [stimuligoodconstot stimulusgoodcons{k}];
end
A = cov([stimuligoodconstot;responsegoodconstot]');
Cs = A(1:J,1:J);
Crs = A(1:J, J+1);
hl2agoodconspecific = inv(Cs)*Crs;
bl2agoodconspecific = mean(responsegoodconstot) - hl2agoodconspecific'*mean(stimuligoodconstot, 2);
MSEl2agoodconspecific = mean((responsegoodconstot-hl2agoodconspecific'*stimuligoodconstot-bl2agoodconspecific).^2)/var(responsegoodconstot);
figure();
plot(sort(hl2agoodconspecific)); 
title('sorted regression vector without lasso l2a_good conspecific' );
[l2agoodcpnspecificmax, posmaxl2agoodconspecific]= max(hl2agoodconspecific);
 %%lasso 
hlassol2agoodconspecific = l1_ls(Cs, Crs, 1e-6);%lambda max = 3.0532e-04
blassol2agoodconspecific  = mean(responsegoodconstot) - hlassol2agoodconspecific'*mean(stimuligoodconstot, 2);
MSElassol2agoodconspecific = mean((responsegoodconstot-hlassol2agoodconspecific'*stimuligoodconstot-blassol2agoodconspecific).^2)/var(responsegoodconstot);
figure();
plot(sort(hlassol2agoodconspecific));
title('sorted regression vector with sparsity condition : lambda = 1e-5 l2a_good conspecific');

%%L2a good  flatrip
for j=1:10
    fileID = fopen(['matlabSTRF/data/l2a_good/flatrip/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimgoodflatrip{j}  = audioread(c1{1, 1}{1, 1}); 
    firespikegoodflatrip{j} = firingrate(['matlabSTRF/data/l2a_good/flatrip/spike' num2str(j)], T, 400);
end

for k = 1 : 10
    [stimulusgoodflatrip{k}, responsegoodflatrip{k}] = calc(Windowlength,stimgoodflatrip{k}, firespikegoodflatrip{k});
end
stimuligoodflatriptot = [];
responsegoodflatriptot = [];

for k = 1 :10
    responsegoodflatriptot = [responsegoodflatriptot responsegoodflatrip{k}];
    stimuligoodflatriptot = [stimuligoodflatriptot stimulusgoodflatrip{k}];
end

A = cov([stimuligoodflatriptot;responsegoodflatriptot]');
Cs = A(1:J,1:J);
Crs = A(1:J, J+1);
hl2agoodflatrip = inv(Cs)*Crs;
bl2agoodflatrip = mean(responsegoodflatriptot) - hl2agoodflatrip'*mean(stimuligoodflatriptot, 2);
MSEl2agoodflatrip = mean((responsegoodflatriptot-hl2agoodflatrip'*stimuligoodflatriptot-bl2agoodflatrip).^2)/var(responsegoodflatriptot);
figure();
plot(sort(hl2agoodflatrip)); 
title('sorted regression vector without lasso l2a good flatrip');
[maxl2agoodflatrip, posmaxl2agoodflatrip]= max(hl2agoodflatrip);
 %%lasso 
hlassol2agoodflatrip = l1_ls(Cs, Crs, 1e-6);%lambda max = 3.0532e-04
blassol2agoodflatrip  = mean(responsegoodflatriptot) - hlassol2agoodflatrip'*mean(stimuligoodflatriptot, 2);
MSElassol2agoodflatrip = mean((responsegoodflatriptot-hlassol2agoodflatrip'*stimuligoodflatriptot-blassol2agoodflatrip).^2)/var(responsegoodflatriptot);
figure();
plot(sort(hlassol2agoodflatrip));
title('sorted regression vector with sparsity condition : lambda = 1e-5 l2a good flatrip' );
%% l2a bad songrip
for j=1:20
    fileID = fopen(['matlabSTRF/data/l2a_bad/songrip/stim' num2str(j)]);
    c1 =textscan(fileID, '%s');
    stimbadsongrip{j}  = audioread(c1{1, 1}{1, 1}); 
    firespikebadsongrip{j} = firingrate(['matlabSTRF/data/l2a_bad/songrip/spike' num2str(j)], T, 400);
end

for k = 1 : 20
    [stimulusbadsongrip{k}, responsebadsongrip{k}] = calc(Windowlength,stimbadsongrip{k}, firespikebadsongrip{k});
end
stimulibadsongriptot = [];
responsebadsongriptot = [];

for k = 1 :20
    responsebadsongriptot = [responsebadsongriptot responsebadsongrip{k}];
    stimulibadsongriptot = [stimulibadsongriptot stimulusbadsongrip{k}];
end

A = cov([stimulibadsongriptot;responsebadsongriptot]');
Cs = A(1:J,1:J);
Crs = A(1:J, J+1);
hl2abadsongrip = inv(Cs)*Crs;
bl2abadsongrip = mean(responsebadsongriptot) - hl2abadsongrip'*mean(stimulibadsongriptot, 2);
MSEl2abadsongrip = mean((responsebadsongriptot-hl2abadsongrip'*stimulibadsongriptot-bl2abadsongrip).^2)/var(responsebadsongriptot);
figure();
plot(sort(hl2abadsongrip)); 
title('sorted regression vector without lasso l2a bad songrip');
[maxl2abadsongrip, posmaxl2abadsongrip]= max(hl2abadsongrip);
 %%lasso 
hlassol2abadsongrip = l1_ls(Cs, Crs, 1e-6);%lambda max = 3.0532e-04
blassol2abadsongrip  = mean(responsebadsongriptot) - hlassol2abadsongrip'*mean(stimulibadsongriptot, 2);
MSElassol2abadsongrip = mean((responsebadsongriptot-hlasso'*stimulibadsongriptot-blassol2abadsongrip).^2)/var(responsebadsongriptot);
figure();
plot(sort(hlassol2abadsongrip));
title('sorted regression vector with sparsity condition : lambda = 1e-5 l2a bad songrip' );