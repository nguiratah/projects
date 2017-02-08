function [t_k, a_k, win_idx, K_i] = ca_detect_sliding_emom(original_signal, ...
                                                        original_t, ...
                                                        win_len, ...
                                                        tau, ...
                                                        T, ...
                                                        mode, ...
                                                        param1, ...
                                                        param2)
% -------------------------------------------------------------------------
% Communications and Signal Processing Group
% Department of Electrical and Electronic Engineering
% Imperial College London, 2012
%
% Supervisor  : Dr Pier Luigi Dragotti
% Author      : Jon Onativia
%
% File        : ca_detect_sliding_window.m
% -------------------------------------------------------------------------
% Recover a stream of decaying exponentials with constant tau with a 
% sliding window. All the decaying exponentials have the same constant. 
% The amount of decaying exponentials for a given window position can be 
% estimated from the signal, given by an oracle (we know the locations of 
% the exponentials), or considered to be fixed and equal for every 
% positions.
%
% USAGE:
%  [t_k, a_k, win_idx, max_K] = ca_detect_sliding_window(original_signal, ...
%                                                        original_t, ...
%                                                        win_len, ...
%                                                        tau, ...
%                                                        mode, ...
%                                                        param1, ...
%                                                        param2)
%
% INPUT:
%  - original_signal : Input signal with the stream of noisy decaying exps.
%  - original_t      : Time stamps of the signal's samples.
%  - win_len         : Size of the sliding window.
%  - tau             : Constant of the decaying exponentials
%                      (exp(-(t-t_k)/tau)).
%  - T               : Sampling period.
%  - mode            : Mode to estimate the number of exponentials within
%                      a window. Can be 'estimate' (number of exponentials 
%                      estimated from the signal), 'oracle' (the locations
%                      are provided) or 'fixed' (same number of exponential
%                      for every window positions).
%  - params          : If mode='oracle' this parameter provides the true
%                      positions of the exponentials.
%                      If mode='fixed' this parameter is a scalar that 
%                      provides the number of exponentials within a window.
%
% OUTPUT:
%  - t_k             : Locations of the retrieved locations.
%  - a_k             : Amplitude of the retrieved locations.
%  - win_idx         : Window for wich each t_k and a_k have been
%                      retrieved.
%  - K_i             : Vector with detected K within window each.
%


if nargin < 5 || nargin > 8
    error('ca_detect_sliding_window:err_arg', 'The number of input arguments is incorrect.')
elseif nargin == 5
    mode = 'estimate';
end

if strcmp(mode, 'estimate')
    mode = 1;
elseif strcmp(mode, 'oracle')
    sp   = param1;
    mode = 2;
elseif strcmp(mode, 'fixed')
    K_fix = param1;
    mode  = 3;
elseif strcmp(mode, 'partial_oracle_fixed') % oracle only for K=0
    sp    = param1;
    K_fix = param2;
    mode  = 4;
elseif strcmp(mode, 'partial_oracle_estimate') % oracle only for K=0
    sp    = param1;
    mode  = 5;
end

% Sampling period and time window length
T_s     = mean(diff(original_t));
TTs     = T / T_s;
N       = win_len;
tot_len = length(original_t);

% Add 'win_len' zeros before and after the signal
% original_signal = [zeros(win_len,1); original_signal; zeros(win_len,1)];
% t_00            = original_t(1) - win_len * T_s;
% t_01            = original_t(1) - T_s;
% t_end0          = original_t(end) + T_s;
% t_end1          = original_t(end) + win_len * T_s;
% original_t      = [(t_00:T_s:t_01)'; original_t; (t_end0:T_s:t_end1)'];

% Time-resolution increase to improve beta and psi kernels precision
over_samp = 512;
T_s2      = T / over_samp;

% Construct the kernel
P            = N / 2;
m            = 0:P;
alpha_0      = -1j * pi / 2;
lambda       = 1j * pi / P;
alpha_vec    = alpha_0 + lambda * m;
[phi, t_phi] = generate_e_spline(alpha_vec, T_s2, T);
t_diric = (0:T_s2/T:P+1)'*2*pi/(P+1);
t_diric = t_diric - (t_diric(end)-t_diric(1))/2;
b       = diric(t_diric, (P+1));
phi     = real(b);

% Compute psi(t) = beta_-alphaT(t) * phi(t)
alpha                 = 1 / tau;
[beta_alphaT, t_beta] = generate_e_spline(-alpha*T, T_s2, T);
beta_alphaT_rev       = [0; beta_alphaT(end:-1:2)];
t_beta_rev            = -t_beta(end:-1:1);
t_0                   = t_phi(1) + t_beta_rev(1);
t_end                 = t_phi(end) + t_beta_rev(end);
psi                   = T_s2 * conv(phi, beta_alphaT_rev);
t_psi                 = (t_0:T_s2:t_end)';

% Time interval that we consider (exponential reproduction interval)
if mod(N, 2) == 0
    n1 = -N/2;
    n2 = N/2 - 1;
else
    n1 = -(N-1)/2;
    n2 = (N-1)/2;
end
n_vec = (n1:n2)';
t1    = n1 * T;
t2    = (n2+1) * T - T_s;
t     = (t1:T_s:t2)';

% c_m_n parameters
c_m_n = get_c_m_n_exp(alpha_vec, n_vec, psi, t_psi, T);

t_phi = t_phi(1:over_samp/TTs:end);
phi   = real(phi(1:over_samp/TTs:end));

t_k      = [];
a_k      = [];
win_idx  = [];
step     = TTs;
num_wins = floor((tot_len-win_len)/step) + 1;
K_i      = zeros(num_wins,1);
ith_win  = 1;
for i_0 = 1 : step : tot_len-win_len*TTs+1
    % Time window of the input signal and real number of spikes in the window
    idx    = (i_0:i_0+win_len*TTs-1)';
    t_x    = original_t(idx);
    x      = original_signal(idx);
    
    if mode == 1
        % Exponentials recovery estimating K
        [tt_k, aa_k, K] = extract_decaying_exponentials(x, t_x, alpha, ...
                                                        phi, t_phi, ...
                                                        alpha_0, lambda, ...
                                                        T, c_m_n, n_vec);
    elseif mode == 2
        % Exponential recovery with oracle for K
        K_real = sum(sp >= t_x(1) & sp <= t_x(end));
        [tt_k, aa_k, K] = extract_decaying_exponentials(x, t_x, alpha, ...
                                                        phi, t_phi, ...
                                                        alpha_0, lambda, ...
                                                        T, c_m_n, n_vec, ...
                                                        K_real);
    elseif mode == 3
        % Exponential recovery with fixed K
        [tt_k, aa_k, K] = extract_decaying_exponentials(x, t_x, alpha, ...
                                                        phi, t_phi, ...
                                                        alpha_0, lambda, ...
                                                        T, c_m_n, n_vec, ...
                                                        K_fix);
    elseif mode == 4
        % Exponential recovery with partial oracle and fixed K
        K_real = sum(sp >= t_x(1) & sp <= t_x(end));
        if K_real == 0
            tt_k = [];
            aa_k = [];
            K    = 0;
        else
            [tt_k, aa_k, K] = extract_decaying_exponentials(x, t_x, alpha, ...
                                                        phi, t_phi, ...
                                                        alpha_0, lambda, ...
                                                        T, c_m_n, n_vec, ...
                                                        K_fix);
        end
    elseif mode == 5
        % Exponential recovery with partial oracle and estimated K
        K_real = sum(sp >= t_x(1) & sp <= t_x(end));
        if K_real == 0
            tt_k = [];
            aa_k = [];
            K    = 0;
        else
            [tt_k, aa_k, K] = extract_decaying_exponentials(x, t_x, alpha, ...
                                                        phi, t_phi, ...
                                                        alpha_0, lambda, ...
                                                        T, c_m_n, n_vec);
        end

    end
    
    % Store value of K
    K_i(ith_win) = K;
    
    t_k     = [t_k; tt_k];
    a_k     = [a_k; aa_k];
    win_idx = [win_idx; i_0*ones(K,1)];
    
    ith_win = ith_win + 1;
end
