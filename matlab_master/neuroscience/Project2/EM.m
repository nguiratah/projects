%% EM algorithm for D dimensional data with K clusters
%%      data: contains a data vector in each row
%%      K: number of clusters (mixture components)
%%      Niter: number of iterations
         

function [gamma, means, covmx, postprob] = EM(data, K, Niter)


figure(1)
scatter(data(:,1),data(:,2));
hold on

N = size(data,1);   % number of data points
D = size(data,2);   % dimension


gamma = 1/K*ones(K,1);
covmx = zeros(D,D,K);

%init means and cov matrices
inds = randi(N, [K,1]);
means = data(inds,:);
for c=1:K
    covmx(:,:,c) = cov(data,1);
end
likelihood=zeros(Niter,1);

for i=1:Niter

    %E step - class membership probabilities
    postprob = zeros(N,K); %rows: diffent data points, columns: classes
    for c=1:K
        postprob(:,c) = mvnpdf(data,means(c,:),covmx(:,:,c))*gamma(c);
    end
    % normalizing each row
    postprob = postprob./repmat(sum(postprob,2),[1,K]);

    %M step - updating parameters (gamma, means, covmx)
    gamma = 1/N* sum(postprob,1);
    for c=1:K
        means(c,:) = 1/(gamma(c)*N) * sum(data.*repmat(postprob(:,c),[1,D]),1);
        cov_temp = zeros(D,D);
        for d=1:N
            cov_temp = cov_temp + 1/(gamma(c)*N) * postprob(d,c)* (data(d,:)-means(c,:))'*(data(d,:)-means(c,:)); 
        end
        covmx(:,:,c) = cov_temp;
    end
    
    %calculating likelihood
    l_d = zeros(N,1);
    for d=1:N
        l_c = zeros(K,1);
        for c=1:K
            l_c(c) = gamma(c)*mvnpdf(data(d,:), means(c,:),covmx(:,:,c));   
        end
        l_d(d) = log(sum(l_c));  
    end
    likelihood(i) = sum(l_d);
    
    
    
    scatter(means(:,1),means(:,2),'r');
end

hold off

figure()
plot((1:Niter), likelihood, '*');
likelihood(Niter)

end