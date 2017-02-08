close all; clear all; clc;

T=2000;
StimulusData=cell(0);
Y=cell(0);
for ii=1:20
    fileID = fopen(['matlabSTRF/data/l2a_good/conspecific/stim' num2str(ii)]);
    c1 =textscan(fileID, '%s');
    stimulus=audioread(c1{1, 1}{1, 1});
    StimulusData{ii}  = stimulus';
    y=firingrate(['matlabSTRF/data/l2a_good/conspecific/spike' num2str(ii)], T, 400);
    Y{ii}=y;
end


Windowlength = [100,120,150];  % in Milliseconds
H=cell(0);REP=cell(0);Err=zeros(3,1);
for k=1:3
    
    
    J = 32 * Windowlength(k);
    N=0;
    Stimulus = zeros(J,1);
    Response = zeros(1,1) ; 
    for i = 1:20     
    N1 = min( floor((length(StimulusData{i})-J)/32), 2000-Windowlength(k) );
    StimulusAux = StimulusData{i} ;  
    Stimulusi = zeros(J, N1);
    Responsei = zeros(1, N1);
    yi=Y{i};
    for n=1:N1,
        Stimulusi(:,n) = abs(StimulusAux((n-1)*32 +1 : J + (n-1)*32));
        Responsei(n) = yi(Windowlength(k) + (n-1));
    end
    Stimulus = [Stimulus  Stimulusi] ;
    Response = [Response Responsei] ; 
    N=N1;
    end
    Stimulus= Stimulus(:,2:end);
    Response= Response(1,2:end);
    %---------------------------------
    % Computing the regression vector 
    %---------------------------------
    StimTraining=Stimulus(:,1:end-N);
    StimTest=Stimulus(:,end-N+1:end);

    RespTraining=Response(1:end-N);
    RespTest=Response(end-N+1:end);

    A=cov([StimTraining;RespTraining]');
    Cs=A(1:J,1:J);
    Csr=A(1:J,J+1);


    % we try to find h using lasso 
    fact=10;
    lambda=find_lambdamax_l1_ls(Cs',Csr)/fact;
    [hlasso,status]=l1_ls(Cs,Csr,lambda);
    hlasso=zeros(J,1);
    b=mean(RespTraining)-hlasso'*mean(StimTraining,2);
    varRespTest=1/length(RespTest)  * (RespTest-mean(RespTest))*(RespTest-mean(RespTest))';



    predictedRespLasso=hlasso'*StimTest+b;
    Ehblasso=(1/length(RespTest))*(RespTest-predictedRespLasso)*(RespTest-predictedRespLasso)';

    NormalizedEhblasso=Ehblasso/varRespTest;
    
     
    H{k,1}=hlasso;
    REP{k,1}=RespTest;REP{k,2}=predictedRespLasso;
    Err(k,1)=NormalizedEhblasso;
    
end

figure ;
xlabel('i');
ylabel('h(i)');

J=length(H{1,1});
subplot(3,1,1);
plot(1:J,H{1,1},'r');
title('h vs hLasso for windowlength=100');
J=length(H{2,1});
subplot(3,1,2);
plot(1:J,H{2,1},'r');
title('h vs hLasso for windowlength=120');
J=length(H{3,1});
subplot(3,1,3);
plot(1:J,H{3,1},'r');
title('h vs hLasso for windowlength=150');


figure ;
xlabel('i');
ylabel('r');

x=1:length(REP{1,1});
subplot(3,1,1);
plot (x,REP{1,1},'b',x,REP{1,2},'c');
title('True response Vs predicted responses for windowlength=100');
x=1:length(REP{2,1});
subplot(3,1,2);
plot (x,REP{2,1},'b',x,REP{2,2},'c');
title('True response Vs predicted responses for windowlength=120');
x=1:length(REP{3,1});
subplot(3,1,3);
plot (x,REP{3,1},'b',x,REP{3,2},'c');
title('True response Vs predicted responses for windowlength=150');