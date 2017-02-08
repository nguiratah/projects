% -------------------------------------------------------------------------
% Communications and Signal Processing Group
% Department of Electrical and Electronic Engineering
% Imperial College London, 2012
%
% Supervisor  : Dr Pier Luigi Dragotti
% Author      : Jon Onativia
%
% File        : surrogate_data.m
% -------------------------------------------------------------------------
% Ca transient detection with double consistency
% -> big window and K estimation
% -> small window and fixed K
% Spikes detected from the union of the histograms

clear all
close all
clc

load('data/thousand_spikes_lambda_049.mat', 'sp', 'tau', 'f', 't')

T_s = t(2) - t(1);
f_s = 1 / T_s;
T   = T_s;
len = t(end) - t(1);

% Add noise
SNR   = 10;
N     = length(f);
Ps    = (f' * f) / N;
noise = randn(N, 1);
Pn    = (noise' * noise) / N;
noise = sqrt(Ps/Pn * 10^(-SNR/10)) * noise;
sigma = (noise' * noise) / N;

noisy_signal = f + noise;

t_k1     = [];
a_k1     = [];
win_idx1 = [];
t_k2     = [];
a_k2     = [];
win_idx2 = [];

% First iteration, big window size and K estimated from S matrix
win_len1 = 32;
[t_k1, a_k1, win_idx1] = ca_detect_sliding_emom(noisy_signal, ...
                                                t, ...
                                                win_len1, ...
                                                tau, ...
                                                T, ...
                                                'estimate');
t_k = t_k1;

% Second iteration, small window and fixed K
win_len2 = 8;
if win_len2 > 0
    K_fix    = 1;
    [t_k2, a_k2, win_idx2] = ca_detect_sliding_emom(noisy_signal, ...
                                                    t, ...
                                                    win_len2, ...
                                                    tau, ...
                                                    T, ...
                                                    'fixed', ...
                                                    K_fix);
    t_k = [t_k; t_k2];
end

%% Count the number of detected exponentials within a time interval
hist_res   = 1; % => produce the histogram with a higher res than original_t
T_h        = T_s / hist_res;
hist_t     = (t(1) : T_h : t(end))';
hist_len   = length(hist_t);
delta_t    = 1 * T_h;
hist_sp    = zeros(hist_len, 1);
max_detect = win_len1 + win_len2;
for ith_t = 1 : hist_len
    t_i = hist_t(ith_t);
    
    inds           = find(t_k > (t_i - delta_t/2) & t_k < (t_i + delta_t/2));
    hist_sp(ith_t) = length(inds);
    
%     if hist_sp(ith_t) > threshold
%         sspp = [sspp; mean(t_k(inds))];
%     end
end

% Only take into account the peak of the histograms
sspp       = [];
threshold  = 0.45 * max_detect;
for ith_t = 1 : hist_len
    if hist_sp(ith_t) > threshold
        if ( ith_t < hist_len && (hist_sp(ith_t) >= hist_sp(ith_t+1)) ) ...
        && ( ith_t > 1       && (hist_sp(ith_t) >  hist_sp(ith_t-1)) )
            t_i  = hist_t(ith_t);
            inds = find(t_k > (t_i - delta_t/2) & t_k < (t_i + delta_t/2));
            sspp = [sspp; mean(t_k(inds))];
        end
    end
end

% Retrieve the amplitudes of the spikes
ap   = retrieve_amplitudes(noisy_signal, t, sp, 7*T_s, .5);
aapp = retrieve_amplitudes(noisy_signal, t, sspp, 7*T_s, .5);

% Remove spikes with an amplitude smaller than a threshold
max_amp = max(noisy_signal);
sspp(aapp < 0.3 * max_amp) = [];
aapp(aapp < 0.3 * max_amp) = [];

% Compare the detected spikes with the real spikes
num_sp   = length(sp);
hit_sp   = false(num_sp, 1);
sspp_ids = [];
sspp_cpy = sspp;
delta_t  = 2*T_s;
for ith_sp = 1 : num_sp
    t_i  = sp(ith_sp);
    inds = find(sspp_cpy > (t_i - delta_t/2) & sspp_cpy < (t_i + delta_t/2));
    
    if ~isempty(inds)
        hit_sp(ith_sp) = true;
        sspp_ids       = [sspp_ids; find(sspp == sspp_cpy(inds(1)))];
        
        % Remove this spike from detected spikes
        sspp_cpy(inds(1)) = [];
        
        if length(inds) > 1
            warning('More than one spike detected in the neighbourhood of a real spike');
        end
    end
end

% Accuracy of detected spikes
hit_rate  = sum(hit_sp) / length(hit_sp) * 100;
false_pos = length(sspp_cpy);
mse       = mean( (sp(hit_sp) - sspp(sspp_ids)).^2 );
disp('')
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
disp(['++++ SLIDING WINDOW Ca transient detection algorithm double consistency'])
disp(['++++ win_len1 = ' num2str(win_len1) ', win_len2 = ' num2str(win_len2)])
disp(['Total number of real spikes     : ' num2str(num_sp)])
disp(['Total number of detected spikes : ' num2str(length(sspp))])
disp(['Real spikes detected            : ' num2str(sum(hit_sp))])
disp(['MSE of spike locations          : ' num2str(mse)])
disp(['RMSE of spike locations         : ' num2str(sqrt(mse))])
disp(['Spike detection rate            : ' num2str(hit_rate) '%'])
disp(['False positives                 : ' num2str(false_pos)])
disp(['False positives rate            : ' num2str(false_pos/len) ' Hz'])
disp(' ')

