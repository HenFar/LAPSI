function [imfs1emd, residue1emd, imfs2emd, residue2emd, imfs1eemd, residue1eemd, imfs2eemd, residue2eemd] = ecg_plots(loc, file_name)

% Function that plots all important (for us) signals for each ECG, 
% the imfs and residues for both EMD and EEMD.
% loc - location of the .mat file.
% file_name - name of the signal for printing.

x = load(loc);
data = x.val;
ecg1 = data(1, :);
ecg2 = data(2, :);

% page 5 plots

N = length(ecg1);
Fs = 360;
t = (0:(N-1))' ./ Fs;

figure;
plot(t, ecg1); title(sprintf('ECG %s-1', file_name));
figure;
plot(t, ecg2); title(sprintf('ECG %s-2', file_name));

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
        title(sprintf('Using EMD for %s-1', file_name));
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
        title(sprintf('Using EEMD for %s-1', file_name));
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
        title(sprintf('Using EMD for %s-2', file_name));
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
        title(sprintf('Using EEMD for %s-2', file_name));
    end
end
% 4th (bottom) row: plot the residual/trend
subplot(4,1,4);
plot(t, residue2eemd, 'LineWidth', 1);
ylabel('Residue');
xlabel('Time (s)');
grid on;

