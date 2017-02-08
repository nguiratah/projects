%% EM algorithm for D dimensional data with K clusters
%%      data: contains a data vector in each row
%%      K: number of clusters (mixture components)
%%      Niter: number of iterations
         

function [gamma, means, covmx,C_prob] = EM(data, K, Niter)
close all;

figure(1)
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


loglikelihood=zeros(Niter,1);

for i=1:Niter

    %E step - class membership probabilities for each sample
    % i.e we want to compute P(Vvect|Uvect ; G_old)
    C_prob=zeros(N,K);
   	for c=1:K
        for n=1:N
            sum2=0;
            for nc=1:K
               sum1= (gamma(nc)/sqrt(((2*pi)^D)*det(covmx(:,:,nc))))*...
                    exp(-0.5*(data(n,:)-means(nc,:))*(inv(covmx(:,:,nc)))*...
                    (data(n,:)-means(nc,:))');
                sum2=sum2+sum1;
            end
            C_prob(n,c)=((gamma(c)/sqrt(((2*pi)^D)*det(covmx(:,:,c))))*...
                    exp(-0.5*(data(n,:)-means(c,:))*(inv(covmx(:,:,c)))*(data(n,:)-means(c,:))'))...
                    / sum2;
        end
    end
    

    %M step - updating parameters (gamma, means, covmx)
    
    
    for c=1:K
        means(c,:)=(C_prob(:,c)'*data)/sum(C_prob(:,c));
        Re=repmat(C_prob(:,c),1,2);
        covmx(:,:,c)=((Re.*(data-repmat(means(c,:),N,1)))'*(data-repmat(means(c,:),N,1)))/sum(C_prob(:,c));
        gamma(c)=sum(C_prob(:,c))/N;
    end
    
    %calculating likelihood
    myLikelihood2log=0;
    for n=1:N

        part1=zeros(1,K);
        part2=zeros(1,K);
       for c=1:K
           part1(c)=(gamma(c)/sqrt((2*pi)^D*det(covmx(:,:,c))));
           part2(c)=(data(n,:)-means(c,:))*(inv(covmx(:,:,c)))*(data(n,:)-means(c,:))'; 
       end
     myLikelihood2log =myLikelihood2log+log(sum(part1.*exp(-0.5*part2)));
    end
    
  
    loglikelihood(i)=myLikelihood2log;
 
    %plot mean and eigenvectors of covariance matrix for each cluster
    
    % ploting the means
    
    if i==round(1)
        %         [V,~]=eig(covmx(:,:,1));
%         plot([means(1,1),means(1,1)+V(1,1)],[means(1,2),means(1,2)+V(2,1)],'r', 'LineWidth',2);
%         plot([means(1,1),means(1,1)+V(1,2)],[means(1,2),means(1,2)+V(2,2)],'r', 'LineWidth',2);
%         
%         [V,~]=eig(covmx(:,:,2));
%         plot([means(2,1),means(2,1)+V(1,1)],[means(2,2),means(2,2)+V(2,1)],'g', 'LineWidth',2);
%         plot([means(2,1),means(2,1)+V(1,2)],[means(2,2),means(2,2)+V(2,2)],'g', 'LineWidth',2);
%         [V,~]=eig(covmx(:,:,3));
%         plot([means(3,1),means(3,1)+V(1,1)],[means(3,2),means(3,2)+V(2,1)],'k', 'LineWidth',2);
%         plot([means(3,1),means(3,1)+V(1,2)],[means(3,2),means(3,2)+V(2,2)],'k', 'LineWidth',2);
%         title 'Initial Mean and eigenvectors of each cluster'
%         xlabel 'Data1'
%         ylabel 'Data2'
        [V,~]=eig(covmx(:,:,1));
         plot([0,means(1,1)],[0,means(1,2)],'r', 'LineWidth',2);        
        [V,~]=eig(covmx(:,:,2));
        plot([0,means(2,1)],[0,means(2,2)],'g', 'LineWidth',2);
        [V,~]=eig(covmx(:,:,3));
        plot([0,means(3,1)],[0,means(3,2)],'k', 'LineWidth',2);
        title 'Initial Means  for each cluster'
        xlabel 'Data1'
        ylabel 'Data2'
        
    end
 
    if i==round(Niter/2)
        covmx
        figure(2)
        scatter(data(:,1),data(:,2));
        hold on
%         [V,~]=eig(covmx(:,:,1));
%         plot([means(1,1),means(1,1)+V(1,1)],[means(1,2),means(1,2)+V(2,1)],'r', 'LineWidth',2);
%         plot([means(1,1),means(1,1)+V(1,2)],[means(1,2),means(1,2)+V(2,2)],'r', 'LineWidth',2);
%         
%         [V,~]=eig(covmx(:,:,2));
%         plot([means(2,1),means(2,1)+V(1,1)],[means(2,2),means(2,2)+V(2,1)],'g', 'LineWidth',2);
%         plot([means(2,1),means(2,1)+V(1,2)],[means(2,2),means(2,2)+V(2,2)],'g', 'LineWidth',2);
%         [V,~]=eig(covmx(:,:,3));
%         plot([means(3,1),means(3,1)+V(1,1)],[means(3,2),means(3,2)+V(2,1)],'k', 'LineWidth',2);
%         plot([means(3,1),means(3,1)+V(1,2)],[means(3,2),means(3,2)+V(2,2)],'k', 'LineWidth',2);
%         title 'Initermediate Mean and eigenvectors of each cluster'
%         xlabel 'Data1'
%         ylabel 'Data2'
%         
         plot([0,means(1,1)],[0,means(1,2)],'r', 'LineWidth',2);        
        [V,~]=eig(covmx(:,:,2));
        plot([0,means(2,1)],[0,means(2,2)],'g', 'LineWidth',2);
        [V,~]=eig(covmx(:,:,3));
        plot([0,means(3,1)],[0,means(3,2)],'k', 'LineWidth',2);
        title 'Intermediate Means  for each cluster'
        xlabel 'Data1'
        ylabel 'Data2'
        
    end
    if i==Niter
        covmx
        figure(3)
        scatter(data(:,1),data(:,2));
        hold on
%         [V,~]=eig(covmx(:,:,1));
%         plot([means(1,1),means(1,1)+V(1,1)],[means(1,2),means(1,2)+V(2,1)],'r', 'LineWidth',2);
%         plot([means(1,1),means(1,1)+V(1,2)],[means(1,2),means(1,2)+V(2,2)],'r', 'LineWidth',2);
%         
%         [V,~]=eig(covmx(:,:,2));
%         plot([means(2,1),means(2,1)+V(1,1)],[means(2,2),means(2,2)+V(2,1)],'g', 'LineWidth',2);
%         plot([means(2,1),means(2,1)+V(1,2)],[means(2,2),means(2,2)+V(2,2)],'g', 'LineWidth',2);
%         [V,~]=eig(covmx(:,:,3));
%         plot([means(3,1),means(3,1)+V(1,1)],[means(3,2),means(3,2)+V(2,1)],'k', 'LineWidth',2);
%         plot([means(3,1),means(3,1)+V(1,2)],[means(3,2),means(3,2)+V(2,2)],'k', 'LineWidth',2);
%         title 'Final Mean and eigen vectors for each cluster'
%         xlabel 'Data1'
%         ylabel 'Data2'
%         
        plot([0,means(1,1)],[0,means(1,2)],'r', 'LineWidth',2);        
        [V,~]=eig(covmx(:,:,2));
        plot([0,means(2,1)],[0,means(2,2)],'g', 'LineWidth',2);
        [V,~]=eig(covmx(:,:,3));
        plot([0,means(3,1)],[0,means(3,2)],'k', 'LineWidth',2);
        title 'Final Means  for each cluster'
        xlabel 'Data1'
        ylabel 'Data2'
        
    end
    
end



%plot likelihood vs #iteration


figure(4)

plot (1:Niter,loglikelihood,'r');
title 'log-likelihood in each iteration'
xlabel 'Number of Iterations'
ylabel 'log-likelihood'


end