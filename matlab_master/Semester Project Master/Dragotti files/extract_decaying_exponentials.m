function [t_k, a_k, K] = extract_decaying_exponentials(x, t_x, alpha, ...
                                                       phi, t_phi, ...
                                                       alpha_0, lambda, ...
                                                       T, ...
                                                       c_m_n, n_vec, ...
                                                       K, reps_per_k)
% -------------------------------------------------------------------------
% Communications and Signal Processing Group
% Department of Electrical and Electronic Engineering
% Imperial College London, 2012
%
% Supervisor  : Dr Pier Luigi Dragotti
% Author      : Jon Onativia
%
% File        : extract_decaying_exponentials.m
% -------------------------------------------------------------------------
% Extract K decaying exponentials from the signal x(t) applying FRI
% methods (sampling with an exponential reproducting kernel phi(-t/T) at 
% instants t=nT). If the K parameter is not transmitted it will be 
% estimated from the exponential moments of x(t).
%
% Stream of decaying exponentials:
%         K-1
%  x(t) = sum a_k * exp(-alpha(t-t_k)) * u(t-t_k)
%         k=0
%
% Sampling process:
%  y_n = < x(t), phi(t/T-n)>
%  z_n = y_n - y_(n-1) * exp(-alpha*T)
%
% USAGE:
%  [t_k, a_k] = extract_decaying_exponentials(x, t_x, alpha, 
%                                             phi, t_phi, 
%                                             alpha0, lambda,
%                                             T, 
%                                             c_m_n, n_vec[,
%                                             K])
%
%
% INPUT:
%  - x       : Original input signal (stream of decaying exponentials).
%  - t_x     : x(t) signal's time stamps.
%  - alpha   : Exponential decay parameter.
%  - phi     : Exponential reproducing kernel (sampling kernel).
%  - t_phi   : Kernel's time stamps.
%  - T       : Sampling period.
%  - c_m_n   : Exponential reproducing coefficients.
%  - n_vec   : n indices for which the c_m_n coefficients have been
%              computed.
%  - K       : [Optional] Total number of decaying exponentials in x(t).
%
% OUTPUT:
%  - t_k     : Decaying exponentials' time locations.
%  - a_k     : Decaying exponentials' amplitudes.
%
% WARNING:
% x(t) and phi(t/T) must have the same temporal resolution, i.e.
% t(i+1) - t(i) = t_phi(i+1) - t_phi(i)
%

if nargin == 12 
    estimate_K = true;
    sing_vals = K;
elseif nargin == 10
    estimate_K = true;
elseif nargin == 11
    estimate_K = false;
else
    error('Wrong number of arguments.')
end

% Temporal resolution
T_s = t_x(2) - t_x(1);

% Sampling indices (t = nT)
% n_vec = round(t(mod(t,T)==0)/T);

% Time stamps of the shifted signal x(t) (so x(t) is sampled according to 
% the exponential reproduction
t1   = n_vec(1) * T;
t2   = (n_vec(end)+1) * T - T_s;
t_xs = (t1:T_s:t2)';
L    = length(t_x);

% Compute y_n as y_n = <x(t),phi(t/T-n)>
y_n = zeros(length(n_vec), 1);
for it = 1:length(n_vec)
    idx_1         = round((t_phi(1) + n_vec(it) * T - t_xs(1)) / T_s) + 1;
    idx_2         = round((t_phi(end) + n_vec(it) * T - t_xs(1)) / T_s) + 1;
    idx           = (idx_1:idx_2)';
    idx           = mod(idx, L);
    idx(idx == 0) = L;

    y_n(it) = T_s * x(idx).' * phi;
end

z_n = y_n(2:end) - y_n(1:end-1) * exp(-alpha*T);

% Compute the moments of the signal
s_m = c_m_n(:,2:end) * z_n;
kk  = floor(length(s_m)/2) + 1;

% Estimate K parameter if not transmitted
if nargin == 10
    S   = toeplitz(s_m(kk:end), s_m(kk:-1:1));
    D   = svd(S);
    y_i = D / D(1);
    
    % Estimate K thresholding the eigenvalues
    K = sum(y_i > 0.3);
    
    % Estimate K from the max of the second derivative
%     K       = 0;
%     x_i     = (1:length(y_i))';
%     step    = 0.1;
%     x       = (1:step:9)';
%     y_pp    = spline(x_i, y_i, x); % cubic spline interpolation
%     d_y_pp  = diff(y_pp) / step;
%     d2_y_pp = diff(d_y_pp) / step;
%     [~, idx] = max(d2_y_pp);
%     K        = round(x(idx)) - 1;

    % K must be smaller than kk-1/2
    K = min([K kk-1]);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% new test for estimating K
if nargin == 12
    S         = toeplitz(s_m(kk:end), s_m(kk:-1:1));
    [~, D, ~] = svd(S);
    y_i       = diag(D) / D(1,1);
    
    corr_sv = sing_vals * y_i;
%     max_k   = size(sing_vals,1)/reps_per_k;
%     k_est   = zeros(max_k, 1);
%     for k = 1 : max_k
%         k_est(k) = sum(corr_sv((k-1)*reps_per_k+1:k*reps_per_k));
%     end
%     [~, K] = max(k_est);
    [~, K] = max(corr_sv);
    K      = floor((K-1)/reps_per_k);
end
% end of new test for estimating K
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Locate the diracs using matrix pencil method
P   = length(n_vec) / 2;
u_k = acmp_p(s_m, K, round(P/2), P, 1);
t_k = real(T * log(u_k) / lambda);

% Find the amplitudes a_k
A = zeros(K, K);
for i = 0:K-1
    A(i+1,:) = u_k(1:K).^i;
end
B    = s_m(1:K);
B    = B(:);
ah_k = linsolve(A, B);
a_k  = ah_k .* exp(-alpha_0 * t_k / T);

% Round the time locations
% t_k = round(t_k / T_s) * T_s;

% Order chronologically and shift to "real" time stamps
[~, idx] = sort(t_k);
t_k = t_k(idx) + t_x(1) - t_xs(1);
a_k = a_k(idx);
