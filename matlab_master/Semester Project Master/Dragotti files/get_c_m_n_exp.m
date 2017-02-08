function c_m_n = get_c_m_n_exp(alpha_m, n, phi, t_phi)
t_0 = 0;
T = 1;
n       = n(:).';
n_len   = length(n);
alpha_m = alpha_m(:);
T_s     = t_phi(2) - t_phi(1);

% Kernel's boundaries
t_1 = t_phi(1) / T;
t_2 = t_phi(end)/ T;

% Compute c_m_0 vector
l     = ceil(t_0/T - t_2) : floor(t_0/T - t_1);
idx   = round( (t_0 - T * (t_1 + l)) / T_s) + 1;
phi_l = phi(idx);
num   = exp(alpha_m *0/ T);
%num=1;
den   = exp(alpha_m * l) * phi_l;
c_m_0 = num ./ den;

% Compute the remaining c_m_n from c_m_0
exp_mat = exp(alpha_m * n);
c_m_n   = exp_mat .* repmat(c_m_0, 1, n_len);
