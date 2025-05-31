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
nsr1 = data(1, :);  % first ecg in nsr1
N = length(nsr1);
Fs = 128;   % sampling frequency

t = (0:(N-1))' ./ Fs;   % time axis for plotting

figure;
plot(t, nsr1);

[imfs, residue] = emd(nsr1);

figure; plot(imfs(:, 1)'); title('imf1');   % number of imf may be changed

% here we can simply add a for and plot as many imfs as we like or even
% make this a proper function and then systematically apply it to our 
% mit-bih signals, but now im sleepy :|
