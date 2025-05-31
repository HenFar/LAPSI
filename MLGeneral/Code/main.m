x = load('ECGs/NSR/16265m.mat');

% Record nsrdb/16265
% Notes
% =====
%  32 M
% =====
% 
% Starting time: [08:04:00.000]
% Length: 25:27:28.000 (11730944 sample intervals)
% Sampling frequency: 128 Hz
% 2 signals
% Group 0, Signal 0:
%  File: 16265.dat
%  Description: ECG1
%  Gain: uncalibrated; assume 200 adu/mV
%  Initial value: -33
%  Storage format: 212
%  I/O: can be unbuffered
%  ADC resolution: 12 bits
%  ADC zero: 0
%  Baseline: 0
%  Checksum: 15756
% Group 0, Signal 1:
%  File: 16265.dat
%  Description: ECG2
%  Gain: uncalibrated; assume 200 adu/mV
%  Initial value: -65
%  Storage format: 212
%  I/O: can be unbuffered
%  ADC resolution: 12 bits
%  ADC zero: 0
%  Baseline: 0
%  Checksum: -21174

data = x.val;
ecg1 = data(1, :);  % first ecg in x
ecg2 = data(2, :);  % second ecg in x
N = length(ecg1);
Fs = 128;   % sampling frequency

t = (0:(N-1))' ./ Fs;   % time axis for plotting

figure;
plot(t, ecg1);

[imfs1emd, residue1emd] = emd(ecg1);
[imfs1eemd, residue1eemd] = eemd(ecg1, 200, 0.2, 3);

[imfs2emd, residue2emd] = emd(ecg2);
[imfs2eemd, residue2eemd] = eemd(ecg2, 200, 0.2, 3);

figure; % plot 1
for k = 1:3
    subplot(4,1,k);
    plot(t, imfs1emd(:,k), 'LineWidth', 1);
    ylabel(sprintf('IMF %d', k));
    grid on;
    if k == 1
        title('Using EMD for 16265-1');
    end
end
% 4th (bottom) row: plot the residual/trend
subplot(4,1,4);
plot(t, residue1emd, 'LineWidth', 1);
ylabel('Residue');
xlabel('Time (s)');
grid on;


figure; % plot 2
for k = 1:3
    subplot(4,1,k);
    plot(t, imfs1eemd(:,k), 'LineWidth', 1);
    ylabel(sprintf('IMF %d', k));
    grid on;
    if k == 1
        title('Using EEMD for 16265-1');
    end
end
% 4th (bottom) row: plot the residual/trend
subplot(4,1,4);
plot(t, residue1eemd, 'LineWidth', 1);
ylabel('Residue');
xlabel('Time (s)');
grid on;

figure; % plot 3
for k = 1:3
    subplot(4,1,k);
    plot(t, imfs2emd(:,k), 'LineWidth', 1);
    ylabel(sprintf('IMF %d', k));
    grid on;
    if k == 1
        title('Using EMD for 16265-2');
    end
end
% 4th (bottom) row: plot the residual/trend
subplot(4,1,4);
plot(t, residue2emd, 'LineWidth', 1);
ylabel('Residue');
xlabel('Time (s)');
grid on;


figure; % plot 4
for k = 1:3
    subplot(4,1,k);
    plot(t, imfs2eemd(:,k), 'LineWidth', 1);
    ylabel(sprintf('IMF %d', k));
    grid on;
    if k == 1
        title('Using EEMD for 16265-2');
    end
end
% 4th (bottom) row: plot the residual/trend
subplot(4,1,4);
plot(t, residue2eemd, 'LineWidth', 1);
ylabel('Residue');
xlabel('Time (s)');
grid on;