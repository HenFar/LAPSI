function [AVG_IMFs, residue] = eemd(x, L, r, n)

% function for the implementation of an EEMD (Ensemble Empirical Mode
% Decomposition) in MATLAB. 
% the function requires an initial signal x, an ensemble size L and the 
% chosen ratio for the white guassian noise's standard deviation relative 
% to the x signal's.

% x - original signal
% L - ensemble size, i.e. number of emds averaged
% r - ratio of the wgn noise's standard deviation
% n - number of IMFs plotted

% add white gaussian noise to the signal.
% the strength of the noise much be such that its std is 0.1-0.3 of the 
% signal's.

sigma_x = std(x);   % signal std
V = (r*sigma_x)^2;  % noise variance
P = 10*log10(V);    % variance in dBW

w = wgn(length(x), 1, P);   % wgn noise

h = x + w';

[imf0, ~] = emd(h);

sz = size(imf0, 2); % amount of columns, i.e. number of modes

IMFs = zeros(length(x), sz, L);  % matrix for IMF storage

for k = 1:L
    w_k = wgn(length(x), 1, P);
    h_k = x + w_k';
    [imf_k, ~] = emd(h_k);  % in the imf_k matrix, each col is an imf
    num_modes = size(imf_k, 2); % number of modes
    if num_modes < sz
        imf_k(:, num_modes + 1:sz) = 0; % if there are less modes than imf0
    elseif num_modes > sz
        imf_k = imf_k(:, 1:sz); % if there are more modes than imf0
        n = sz; % fix n for plotting
    end
    IMFs(:,:,k) = imf_k;    % append to storage
end

% with the imfs determined and stored, we have now got to average all
% the equal modes.
% for that we'll have to sum all values of a certain part of the imf
% and average them, so as to provide a final complete signal.

AVG_IMFs = zeros(length(x), sz);    % storage for averaged IMFs

for i = 1:sz    % for cycle for each frequency mode, 1, 2, 3, ..., sz
    avg = mean(IMFs(:, i, :), 3);
    AVG_IMFs(:, i) = avg;
end

residue = x(:) - sum(AVG_IMFs, 2);

% should add an automatic print for the first 3 IMFs and residue

t = linspace(0, 1, length(x));

figure, plot(t, x); % plot original ecg signal
title('ECG');

legendList = {'IMF1', 'IMF2', 'IMF3', 'IMF4', 'IMF5', 'IMF6', 'IMF7', 'IMF8'};

for k = 1:n     % plot number of IMFs requested by variable n
    figure, plot(t, AVG_IMFs(:, k));
    title(sprintf('%s', legendList{k}));
end

figure, plot(t, residue);   % plot residue for the whole eemd
title('residue');
