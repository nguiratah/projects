% -------------------------------------------------------------------------
% Communications and Signal Processing Group
% Department of Electrical and Electronic Engineering
% Imperial College London, 2012
%
% Supervisor  : Dr Pier Luigi Dragotti
% Author      : Jon Onativia
%
% File        : fig9.m
% -------------------------------------------------------------------------
% Figure 9 of the journal paper. Plot the results of the performance tests
% with surrogate data.


load('data/thousand_spikes_lambda_049.mat', 'sp')
len = sp(end)-sp(1);

load('results/surrogate_Ts_1472e-4_its_100.mat', 'SNRs', 'success_rates', 'false_pos', 'std_locs');
SNR_1472  = SNRs;
succ_rate_1472 = mean(success_rates);
fp_1472        = mean(false_pos) / len;
rmse_1472 = mean(std_locs);
load('results/surrogate_Ts_736e-4_its_100.mat', 'SNRs', 'success_rates', 'false_pos', 'std_locs');
SNR_736       = SNRs;
succ_rate_736 = mean(success_rates);
fp_736        = mean(false_pos) / len;
rmse_736      = mean(std_locs);
load('results/surrogate_Ts_368e-4_its_100.mat', 'SNRs', 'success_rates', 'false_pos', 'std_locs');
SNR_368       = SNRs;
succ_rate_368 = mean(success_rates);
fp_368        = mean(false_pos) / len;
rmse_368      = mean(std_locs);

line_width = 2;
font_size  = 16;

figure
set(gcf, 'Position', [50 50 320 240])
plot(SNR_1472, succ_rate_1472, '-^r', 'LineWidth', line_width)
hold on
plot(SNR_736, succ_rate_736, '-ob', 'LineWidth', line_width)
plot(SNR_368, succ_rate_368, '-xk', 'LineWidth', line_width)
axis([SNR_1472(1) SNR_1472(end) 75 100])
hdl = xlabel('SNR (dB)');
set(hdl, 'FontSize', font_size)
hdl = ylabel('%');
set(hdl, 'FontSize', font_size)
hdl = legend('T_{res} = 147.2ms', ...
    'T_{res} = 73.6ms', ...
    'T_{res} = 36.8ms', ...
    'Location', 'SouthEast');
set(hdl, 'FontSize', font_size)
% hdl = title('Success rate');
% set(hdl, 'FontSize', font_size)

figure
set(gcf, 'Position', [450 50 320 240])
plot(SNR_1472, fp_1472, '-^r', 'LineWidth', line_width)
hold on
plot(SNR_736, fp_736, '-ob', 'LineWidth', line_width)
plot(SNR_368, fp_368, '-xk', 'LineWidth', line_width) 
axis([SNR_1472(1) SNR_1472(end) 0 .15])
hdl = xlabel('SNR (dB)');
set(hdl, 'FontSize', font_size)
hdl = ylabel('Hz');
set(hdl, 'FontSize', font_size)
hdl = legend('T_{res} = 147.2ms', ...
    'T_{res} = 73.6ms', ...
    'T_{res} = 36.8ms', ...
    'Location', 'NorthEast');
set(hdl, 'FontSize', font_size)
% hdl = title('False positives');
% set(hdl, 'FontSize', font_size)

figure
set(gcf, 'Position', [850 50 320 240])
plot(SNR_1472, rmse_1472, '-^r', 'LineWidth', line_width)
hold on
plot(SNR_736, rmse_736, '-ob', 'LineWidth', line_width)
plot(SNR_368, rmse_368, '-xk', 'LineWidth', line_width)
axis([SNR_1472(1)-.1 SNR_1472(end) 0 .13])
hdl = xlabel('SNR (dB)');
set(hdl, 'FontSize', font_size)
hdl = legend('T_{res} = 147.2ms', ...
    'T_{res} = 73.6ms', ...
    'T_{res} = 36.8ms', ...
    'Location', 'NorthEast');
set(hdl, 'FontSize', font_size)
hdl = ylabel('seconds');
set(hdl, 'FontSize', font_size)
% hdl = title('Locations precision - standard deviation');
% set(hdl, 'FontSize', font_size)
