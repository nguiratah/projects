%% EM algorithm for D dimensional data with K clusters
%%      data: contains a data vector in each row
%%      K: number of clusters (mixture components)
%%      Niter: number of iterations
         

function [gamma, means, covmx, postprob] = EM(data, K, Niter)


figure()
scatter(data(:,1),data(:,2));
hold on

N = size(data,1);               % # of data points
D = size(data,2);               % dimension


gamma = 1/K*ones(K,1);          %mixing probabilities
covmx = zeros(D,D,K);           %covariance matrix for each cluster

%init means and cov matrices
inds = randi(N, [K,1]);
means = data(inds,:);


for c=1:K
    covmx(:,:,c) = cov(data,1);
end


likelihood=zeros(Niter,1);

for i=1:Niter

    %E step - class membership probabilities for each sample
    
    

    %M step - updating parameters (gamma, means, covmx)
   
    
    %calculating likelihood
    %likelihood(i) = ...
    
    
 
    %plot mean and eigenvectors of covariance matrix for each cluster
    
 
end



%plot likelihood vs #iteration








end