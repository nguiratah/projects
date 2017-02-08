%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%   Advanced Digital Communications                                       %
%   Fall 2013                                                             %
%   Homework 8                                                            %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function homework8()
clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N       = 1e5;                                     % Number of samplea/bits
L       = 5;                                              % Diversity Order
ND      = 25;
EdB     = linspace(0,15,ND);                          % Signal Energy in dB
E       = 10.^(EdB/10);                              % Actual signal energy


P_e_ML      = zeros(ND,1);                      % Allocate space beforehand 
P_e_ML_sqrtL= zeros(ND,1);                         % to speed-up the script
P_e_RAY     = zeros(ND,1);
P_e_MaxRat  = zeros(ND,1);

%% Channels %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h       = 1/sqrt(2)*randn(N,1) + j*1/sqrt(2)*randn(N,1);     % Fading model
HL      = 1/sqrt(2)*randn(N,L) + j*1/sqrt(2)*randn(N,L); % L faded channels



for i_E = 1:ND                          % Iterate through all Energy-levels
    %% Generate Signals %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    X   = sqrt(E(i_E))*( (-1).^randi([0 1],N,1) +...              % Complex 
                       j*(-1).^randi([0 1],N,1) );       % antipodal signal
    Z   = (randn(N,1) + j*randn(N,1) );              % Noise, unit-variance
    ZL  = (randn(N,L) + j*randn(N,L) );                % Noise, diversity L
    
    Y       = X                 + Z;             % Fixed, non-faded channel
    YsqrtL  = sqrt(L)*X         + Z; % Non-faded, gain matched to diversity 
                                                    % (for comparison only)
    YR      = h.*X              + Z;                 % Single faded channel
    YRL     = HL.*repmat(X,1,L) + ZL;                    % L faded channels
    
    
    
    %% Detection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Fixed channel, no pre-processing
    X_est_ML        = ML_detect(E(i_E),Y);  
    P_e_ML(i_E)     = Pe_empiric(X,X_est_ML,N);
    X_est_ML_sqrtL  = ML_detect(E(i_E),YsqrtL);          % Fixed chn w gain 
    P_e_ML_sqrtL(i_E)= Pe_empiric(X,X_est_ML_sqrtL,N); % to match diversity
                  
    % Rayleigh fading channel, pre-processing by eq (5.13) of lecture notes
    YR_proc         = exp(-j*angle(h)).*YR;              % Phase correction
    X_est_RAY       = ML_detect(E(i_E),YR_proc);
    P_e_RAY(i_E)    = Pe_empiric(X,X_est_RAY,N);
    
    % Maximum Ratio Combining
    YRL_MaxRat      = sum( conj(HL).*YRL ,2);  % Phase crrctn + Combination
    X_est_MaxRat    = ML_detect(E(i_E),YRL_MaxRat);
    P_e_MaxRat(i_E) = Pe_empiric(X,X_est_MaxRat,N);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                     %
    % \INSERT {YOUR CONTRIBUTION}                                         %
    %                                                                     %
    % to be programmed:     - Hard Decisions (considers only signs, not   %
    %                                                            values)  %
    %                       - Channel Selection (picks only the best      %
    %                                                           channel)  % 
    % Given:   - YRL, a complex vector of NxL (samples x channels)        %
    %          - HL, channel gain model of size NxL                       %
    %          - X, original signal, vector of size Nx1                   %
    %                                                                     %
    % Follow the examples as above: process your channel and              %
    % perform detection by means of the suboptimal techniques of hard     %
    % decions and channel selection.                                      %
    % At the bottom of the script, you'll find two functions you may use: %
    % an ML-dectector for a detection symmetric around zero and a         %
    % function that calculates the empirical error probability.           %
    %                                                                     %
    % LIFE SAVING TIP: remember we use COMPLEX signals. Be careful!       %
    %                  e.g., transpose(A) is not the same as A'           %
    %                                                                     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

end

%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
semilogy(EdB,P_e_ML,...                 % Fixed Channel, Maximum-Likelihood
         EdB,P_e_RAY,...                % Rayleigh Fading
         EdB,P_e_ML_sqrtL,'--',...      % Fixed channel, adjusted gain
         EdB,P_e_MaxRat,...             % Maximum Ratio Combining
         'Linewidth',2);
title  'Empirical average bit-error probabilities'
xlabel 'SNR';                 % Note: noise is of unit variance, so SNR = E
ylabel 'P_e';
grid on;
legend('Fixed Channel',...
       'Rayleigh Fading',...
       'Fixed Channel (gain=\sqrt{5})',...
       'Maximum Ratio Combining',...
       'Location','SouthWest')

end


%% AUXILIARY FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Xhat = ML_detect(E,Y)
% ML-DETECTION for complex signals symmetric around zero.
% Input: Signal power E, received complex samples Y
    Xhat = sqrt(E)*( sign(real(Y)) + j*sign(imag(Y)) ); 
end

function Pe = Pe_empiric(X,Xhat,N)
% Empirical error probability for complex signals
% Input: original signal X, estimate Xhat, N number of samples
% NOTE: N complex samples are 2N bits (real + imaginary)!
    Pe = sum([abs(real(X-Xhat))>=1e-6;
              abs(imag(X-Xhat))>=1e-6])/(2*N);
end