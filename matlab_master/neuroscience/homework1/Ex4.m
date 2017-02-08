clear all ; 
close all ; 
load hw1p4

%-----------Part a --------------------%
 [l ,~]=size(sp4a);
 covMatrixStimulusResponse = cov([sp4a;rp4a]',1);
 Cs = covMatrixStimulusResponse ([1:l],[1:l]);
 Crs = covMatrixStimulusResponse ([1:l],l+1) ; 
 h = Cs\Crs ;
 b=mean(rp4a)-h'*mean(sp4a,2) ; 
 
 %-----------Part b ------------------%
 stimulusVector = [sp4a sp4b];
 responseVector = [rp4a rp4b];
  [l ,~]=size(stimulusVector);
 covMatrixStimulusResponse1 = cov([stimulusVector;responseVector]',1);
 Cs1 = covMatrixStimulusResponse ([1:l],[1:l]);
 Crs1 = covMatrixStimulusResponse ([1:l],l+1) ; 
 h1 = Cs1\Crs1 ;
 b1=mean(responseVector)-h'*mean(stimulusVector,2) ;
 
 %----------- Part c -----------------%
 
 
 h2=l1_ls (Cs1, Crs1,1);
 h3=l1_ls (Cs1, Crs1,100);
 h4=l1_ls (Cs1, Crs1,10000);
 h5=l1_ls (Cs1, Crs1,100000);
 
h2S = sort ( abs(h2) );
h3S = sort ( abs(h3) );
h4S = sort ( abs(h4) );
h5S = sort ( abs(h5) );
 e=1:100;
figure ;
plot(e,h2S,'r+',e,h3S,'bo',e,h4S,'kx',e,h5S,'g^');
title('Magnitudes of the 100 entries with different values of lambda ');
xlabel('i');
ylabel('|h(i)|');
legend('lambda1=1','lambda2=100','lambda3=10000','lambda4=100000');

% When lambda becomes large , we observe that the vector h contains a lot
% of zeroes. The more lambda is large, more zeroes we have in the h
% vector( h become more and more sparse with respect to the growth of lambda)

%---------------- Part d -----------%

%H = [h1'; h2'; h3'; h4'; h5'];
H = [h2'; h3'; h4'; h5'];
b2=mean(responseVector)-h2'*mean(stimulusVector,2) ;
b3=mean(responseVector)-h3'*mean(stimulusVector,2) ;
b4=mean(responseVector)-h4'*mean(stimulusVector,2) ;
b5=mean(responseVector)-h5'*mean(stimulusVector,2) ;
%B = [b1;b2;b3;b4;b5];
B = [b2;b3;b4;b5];

responses = H*sp4t+repmat(B,1,40);
%MSE=[mean((rp4t-responses(1,:)).^2);mean((rp4t-responses(2,:)).^2);...
 %   mean((rp4t-responses(3,:)).^2);mean((rp4t-responses(4,:)).^2);...
  %  mean((rp4t-responses(5,:)).^2)]
MSE=[mean((rp4t-responses(1,:)).^2);mean((rp4t-responses(2,:)).^2);...
    mean((rp4t-responses(3,:)).^2);mean((rp4t-responses(4,:)).^2);]
e=1:40;
figure ;
%plot(e,rp4t,'r+',e,responses(1,:),'bo', e,responses(2,:),'g*',e,responses(3,:),'c.', e,responses(4,:),'kd',e,responses(5,:),'m^');
plot(e,rp4t,'r+',e,responses(1,:),'bo', e,responses(2,:),'g*',e,responses(3,:),'c.', e,responses(4,:),'b-');
title('True measured responses (given in rp4t) compared to the predictions');
xlabel('i');
ylabel('predicted value');
legend('true response','h for lambda1=1','h for lambda2=100','h for lambda3=1000','h for lambda4=10000');

% The predictor h calculated for lambda= 100 gives the nearest response to
% the true measured one . The more we increase the value of lamdba, the
% farest the response will be (compared to the real one => overfitting!)
%