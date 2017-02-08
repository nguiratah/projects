% -------------------------------------------------------------------------
% Communications and Signal Processing Group
% Department of Electrical and Electronic Engineering
% Imperial College London, 2012
%
% Supervisor  : Dr Pier Luigi Dragotti
% Author      : Jon Onativia
%
% File        : real_data.m
% -------------------------------------------------------------------------
% Ca transient detection with double consistency
% -> big window and K estimation
% -> small window and fixed K
% Spikes detected from the union of the histograms

clear all
close all
clc

load('data/real_data.mat', 'sp', 'original_signal', 'original_t', 'T_s', 'tau')

f_s = 1 / T_s;
T   = T_s;
len = original_t(end) - original_t(1);

t_k1     = [];
a_k1     = [];
win_idx1 = [];
t_k2     = [];
a_k2     = [];
win_idx2 = [];

% First iteration, big window size and K estimated from S matrix
win_len1 = 32;
[t_k1, a_k1, win_idx1] = ca_detect_sliding_emom(original_signal, ...
                                                  original_t, ...
                                                  win_len1, ...
                                                  tau, ...
                                                  T, ...
                                                  'estimate');
% [t_k1, a_k1, win_idx1, ~] = ca_detect_K_sliding_window(original_signal, ...
%                                                       original_t, ...
%                                                       win_len1, ...
%                                                       tau);
t_k = t_k1;

% Second iteration, small window and fixed K
win_len2 = 8;
if win_len2 > 0
    K_fix    = 1;
    [t_k2, a_k2, win_idx2] = ca_detect_sliding_emom(original_signal, ...
                                                      original_t, ...
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
hist_t     = (original_t(1) : T_h : original_t(end))';
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
ap   = retrieve_amplitudes(original_signal, original_t, sp, 7*T_s, .5);
aapp = retrieve_amplitudes(original_signal, original_t, sspp, 7*T_s, .5);

% Remove spikes with an amplitude smaller than a threshold
max_amp = max(original_signal);
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

%% Plot the detected spikes
close all
plot_figs = true;
if plot_figs
    
    close all
    
    t1 = 32;
    t2 = 62;
    dt = original_t(end) - original_t(1);
    
    figure
    stem(sp, max_detect*ones(length(sp),1), '.b', 'LineWidth', 2, 'Marker', 'none')
    hold on
    plot(hist_t, hist_sp, 'r')
    axis([t1 t2 -0.1*max_detect 2*max_detect])
    hdl = xlabel('Time (s)');
    set(hdl, 'FontSize', 16)
%     hdl = ylabel('# of spikes detected');
%     set(hdl, 'FontSize', 16)
    hdl = legend('Original spikes', 'Locations histogram');
    set(hdl, 'FontSize', 14)
    set(gcf, 'Position',[50 50 560 210])

    idx1_0     = min(win_idx1);
    idx1_end   = max(win_idx1);
    idx1_delta = idx1_end - idx1_0;
    orig_t_k = [sp(:).'; sp(:).'];
    orig_i   = repmat([idx1_0; idx1_end], 1, length(sp));
    figure
    set(gcf, 'Position', [50 400 560 280])
    h1 = stem(sp, idx1_end*ones(size(sp)), 'b', 'Marker', 'none');
%     h1 = plot(orig_i(:,1), orig_t_k(:,1), 'b');
    hold on
%     for ith = 2:length(orig_i)
%         plot(orig_i(:,ith), orig_t_k(:,ith), 'b');
%     end
    h2 = scatter(t_k1, win_idx1, 16, 'r', 'filled');
    axis([t1 t2 t1/dt*idx1_delta t2/dt*idx1_delta])
%     hdl = title(['Exp decaying recovery. Sliding window length = ' num2str(win_len1)]);
%     set(hdl, 'FontSize', 16)
    hdl = ylabel('i-th window');
    set(hdl, 'FontSize', 16)
    hdl = xlabel('Time (s)');
    set(hdl, 'FontSize', 16)
    hdl = legend([h1, h2], 'Original spikes', 'Detected locations', 'Location', 'SouthEast');
    set(hdl, 'FontSize', 14)
    
    if win_len2 > 0
        idx2_0     = min(win_idx2);
        idx2_end   = max(win_idx2);
        idx2_delta = idx2_end - idx2_0;
        orig_t_k = [sp(:).'; sp(:).'];
        orig_i   = repmat([idx2_0; idx2_end], 1, length(sp));
        figure
        set(gcf, 'Position', [650 400 560 280])
%         h1 = plot(orig_i(:,1), orig_t_k(:,1), 'b');
        h1 = stem(sp, idx2_end*ones(size(sp)), 'b', 'Marker', 'none');
        hold on
%         for ith = 2:length(orig_i)
%             plot(orig_i(:,ith), orig_t_k(:,ith), 'b');
%         end
        h2 = scatter(t_k2, win_idx2, 16, 'r', 'filled');
%         hold on
%         scatter(win_idx2, t_k2, 16, 'r', 'filled', 'LineWidth', 2)
        axis([t1 t2 t1/dt*idx2_delta t2/dt*idx2_delta])
%         hdl = title(['Exp decaying recovery. Sliding window length = ' num2str(win_len2)]);
%         set(hdl, 'FontSize', 16)
        hdl = ylabel('i-th window');
        set(hdl, 'FontSize', 16)
        hdl = xlabel('Time (s)');
        set(hdl, 'FontSize', 16)
        hdl = legend([h1, h2], 'Original spikes', 'Detected locations', 'Location', 'SouthEast');
        set(hdl, 'FontSize', 14)
    end
    
    i0 = find(original_t<t1, 1, 'last');
    iL = find(original_t<t2, 1, 'last');
    ii = find(original_t<35, 1, 'last');
    sub_sp = sp(sp<original_t(iL));
    sub_ap = ap(sp<original_t(iL));
    sub_sspp = sspp(sspp<original_t(iL));
    sub_aapp = aapp(sspp<original_t(iL));
    figure
    plot(original_t(i0:iL), original_signal(i0:iL), 'k')
    hold on
    %stem(sub_sp, sub_ap, 'fill', '^b', 'LineWidth', 2)
    %stem(sub_sspp, sub_aapp, 'r', 'LineWidth', 2)
    stem(sub_sp, 0.17*ones(size(sub_sp)), 'fill', '^b', 'LineWidth', 2)
    stem(sub_sspp, 0.16*ones(size(sub_sspp)), 'r', 'LineWidth', 2)
    plot([original_t(ii) original_t(ii)+win_len1*T_s], [0.25 0.25], '+-k', 'LineWidth', 2)
    plot([original_t(ii) original_t(ii)+win_len2*T_s], [0.32 0.32], '+-k', 'LineWidth', 2)
    axis([original_t(i0) original_t(iL) 0 0.4])
    %     title('\Delta [Ca^{2+}]')
    hdl = xlabel('Time (s)');
    set(hdl, 'FontSize', 16)
    hdl = legend('Fluorescence signal', 'Original spikes', 'Detected spikes');
    set(hdl, 'FontSize', 14)
    set(gcf, 'Position',[650 50 560 210])
    
%     figure
%     plot(original_t(i0:iL), original_signal(i0:iL), 'k', 'LineWidth', 2)
%     axis([original_t(i0) original_t(iL) 0 0.46])
%     set(gcf, 'Position',[50 50 1200*560/1200 300*560/1200])
    
    % Plot the signal and spikes in time
    if false
        width = 256;
        for i0 = 1 : width : length(original_t) - width + 1
            iL = i0 + width - 1;

            figure
            plot(original_t(i0:iL), original_signal(i0:iL), 'b')

            hold on

            sub_sp = sp(sp<original_t(iL));
            sub_ap = ap(sp<original_t(iL));
            stem(sub_sp, sub_ap, 'fill', 'g', 'LineWidth', 2)

            sub_sspp = sspp(sspp<original_t(iL));
            sub_aapp = aapp(sspp<original_t(iL));
            stem(sub_sspp, sub_aapp, 'fill', 'xr', 'LineWidth', 2)

            legend('Original signal', 'Original spikes', 'Detected spikes')
            title('\Delta [Ca^{2+}]')
            xlabel('time (s)')
            set(gcf, 'Position',[50 50 1200*560/1200 300*560/1200])
            axis([original_t(i0) original_t(iL) 0 0.21])
        end
    end
end

