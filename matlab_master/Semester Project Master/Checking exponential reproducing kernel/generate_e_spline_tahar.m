function [phi, t] = generate_e_spline_tahar(alpha_vec, T_s)
N = length(alpha_vec) - 1;
alpha_vec = alpha_vec(:).';
t_phi_1        = 0;
t_phi_2        = 1;
t_phi          = (t_phi_1:T_s:t_phi_2)';
syms w;
for k =1:length(t_phi)
    for l=1:length(alpha_vec)
    f = @(w)(1-exp(alpha_vec(l)-1i*w)).*exp(1i*w*t_phi(k))./(1i*w-alpha_vec(l));
    sub_phi(k, l)=integral(f, -80, 80);
    end
end
%sub_phi(end,:) = 0;
%phi   = [0; sub_phi(1:end-1,1)];
phi = sub_phi(:,1);
t_0   = t_phi(1);
t_end = t_phi(end);
for i = 1:N
    t_0   = t_0 + t_phi(1);
    t_end = t_end + t_phi(end);
    phi   = T_s * conv(phi, sub_phi(:,i+1));
end
t = (t_0:T_s:t_end)';