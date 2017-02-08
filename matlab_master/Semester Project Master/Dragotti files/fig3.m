% -------------------------------------------------------------------------
% Communications and Signal Processing Group
% Department of Electrical and Electronic Engineering
% Imperial College London, 2012
%
% Supervisor  : Dr Pier Luigi Dragotti
% Author      : Jon Onativia
%
% File        : fig3.m
% -------------------------------------------------------------------------
% Figure 3 of the journal paper. Shows an E-spline reproducing 2
% exponentials.

clear all
close all
clc

% Mode
mode = 1; % E-splines with alpha_m real
% mode = 2; % E-splines with alpha_m being purely imaginary
% mode = 3; % E-splines, alpha_m purely imaginary, N <= P+1 

% Sampling period in seconds
T = 1;

% "Continuous" time resolution
T_s = T/64;

% E-spline
P = 1; % m = 0, 1, ..., P
N = 8; % number of samples
m = 0:P;
if mode == 1
    alpha_0 = -.5;
    lambda  = 1;
elseif mode == 2
    if mod(P, 2) == 0
        % P is even
        alpha_0 = -1j * pi * P / N;
        lambda  = 1j * 2 * pi / N;
    else
        % P is odd
        alpha_0 = -1j * 2 * pi * P / N;
        lambda  = 1j * 4 * pi / N;
    end
elseif mode == 3
    alpha_0 = -1j * pi * P / (P + 1);
    lambda  = 1j * 2 * pi / (P + 1);
end
alpha_vec    = alpha_0 + lambda * m;
[phi, t_phi] = generate_e_spline(alpha_vec, T_s, T, 'symmetric'); % compute in time

% Plot the E-spline
figure
set(gcf, 'Position', [50 500 420 315])
plot(t_phi, real(phi), 'k')
hdl = xlabel('t');
set(hdl, 'FontSize', 16)
set(gca, 'FontSize', 16)
axis([t_phi(1)-1 t_phi(end)+1 min(real(phi)) max(real(phi))*1.1])

% Time interval that we want to reconstruct
%N = .5*N;
if mod(N, 2) == 0
    n1 = -N/2;
    n2 = N/2 - 1;
else
    n1 = -(N-1)/2;
    n2 = (N-1)/2;
end
n_vec = (n1:n2)';
t1    = n1 * T + t_phi(1);
t2    = n2 * T + t_phi(end);
t     = (t1:T_s:t2)';
L     = length(t);
t_int = t2 - t1 + T_s;

% c_m_n parameters
c_m_n = get_c_m_n_exp(alpha_vec, n_vec, phi, t_phi, T);

for m = 1:length(alpha_vec)
    
    alpha = alpha_vec(m);
    
    % Original exponential
    f = exp(alpha * t / T);

    % Exponential reproduction
    f_rec = zeros(length(t), length(n_vec)+1);
    for i = 1:length(n_vec)
        [~, idx_f, idx_phi] = intersect(t, t_phi+n_vec(i)*T);
        f_rec(idx_f,i+1)    = c_m_n(m, i) * phi(idx_phi);

        f_rec(:,1) = f_rec(:,1) + f_rec(:,i+1);
    end

    % Dynamic range of the reproduced polynomial
    dyn_range = max(real(f_rec(:,1))) - min(real(f_rec(:,1)));
    
    % Measure the error
    phi_support = length(phi);
    idx         = (1+phi_support:length(f)-phi_support)';
    rec_er      = f(idx) - f_rec(idx,1);
    MSE         = (rec_er' * rec_er) / length(rec_er);

    figure
    set(gcf, 'Position', [50 50 420 315])
    plot(t, real(f_rec(:,1)), '-b', 'LineWidth', 2)
    hold on
    plot(t, real(f), '--r', 'LineWidth', 2)
    for i = 1:length(n_vec)
        plot(t, real(f_rec(:,i+1)), '-k')
    end
    hdl = xlabel('t');
    set(hdl, 'FontSize', 16)
    set(gca, 'FontSize', 16)

    if m==1
        hdl = legend('Reconstructed exponential', ...
            'Original exponential', ...
            'Shifted and weighted splines', ...
            'Location', 'NorthEast');
    else
        hdl = legend('Reconstructed exponential', ...
            'Original exponential', ...
            'Shifted and weighted splines', ...
            'Location', 'NorthWest');
    end
    set(hdl, 'FontSize', 16)
    
    axis([t(1) t(end) 0 max(real(f_rec(:,1)))+.3*dyn_range])
end
