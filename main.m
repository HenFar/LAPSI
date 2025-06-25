% page 5 plots
ecg_plots('ECGs/NSR/117m.mat', '(NSR)117')  % plots NSR
ecg_plots('ECGs/VF/418m.mat', '(VF)418')    % plots VF

[t12_emd_all_nsr_deg, t23_emd_all_nsr_deg, t12_eemd_all_nsr_deg, t23_eemd_all_nsr_deg, ...
    t12_emd_all_vf_deg, t23_emd_all_vf_deg, t12_eemd_all_vf_deg, t23_eemd_all_vf_deg] = ...
    loopAllThetas('Project/ECGs/NSR', 360, 'Project/ECGs/VF', 250);

fprintf('NSR-EMD points = %d, NSR-EEMD = %d\n', ...
        numel(t12_emd_all_nsr_deg), numel(t12_eemd_all_nsr_deg));
fprintf('VF-EMD points  = %d, VF-EEMD  = %d\n', ...
        numel(t12_emd_all_vf_deg),  numel(t12_eemd_all_vf_deg));


edges = 40:1:130;

x_pdf = linspace(min(edges), max(edges), 1000);

figure('Position',[100 100 1000 700]);

% emd t12
subplot(2,2,1);
h1 = histogram(t12_emd_all_nsr_deg, edges, 'Normalization','probability');
hold on;
h2 = histogram(t12_emd_all_vf_deg,  edges, 'Normalization','probability');


% Make bars semi‐transparent so overlap is visible
h1.FaceAlpha = 0.5;
h2.FaceAlpha = 0.5;

mu_nsr = mean(t12_emd_all_nsr_deg);
sigma_nsr = std(t12_emd_all_nsr_deg);
mu_vf  = mean(t12_emd_all_vf_deg);
sigma_vf = std(t12_emd_all_vf_deg);

% Compute Normal‐PDFs
y_nsr = normpdf(x_pdf, mu_nsr, sigma_nsr);
y_vf  = normpdf(x_pdf, mu_vf,  sigma_vf);

% Overlay the curves
plot(x_pdf, y_nsr, 'b--', 'LineWidth', 2);
plot(x_pdf, y_vf,  'r--', 'LineWidth', 2);

hold off;

xlabel('\theta_{12} (°)');
ylabel('Probability');
legend('NSR','VF');
title('EMD: \theta_{12} distribution');



% eemd t12
subplot(2,2,2);
h3 = histogram(t12_eemd_all_nsr_deg, edges, 'Normalization','probability');
hold on;
h4 = histogram(t12_eemd_all_vf_deg,  edges, 'Normalization','probability');

h3.FaceAlpha = 0.5;
h4.FaceAlpha = 0.5;

mu_nsr = mean(t12_eemd_all_nsr_deg);
sigma_nsr = std(t12_eemd_all_nsr_deg);
mu_vf  = mean(t12_eemd_all_vf_deg);
sigma_vf = std(t12_eemd_all_vf_deg);

% Compute Normal‐PDFs
y_nsr = normpdf(x_pdf, mu_nsr, sigma_nsr);
y_vf  = normpdf(x_pdf, mu_vf,  sigma_vf);

% Overlay the curves
plot(x_pdf, y_nsr, 'b--', 'LineWidth', 2);
plot(x_pdf, y_vf,  'r--', 'LineWidth', 2);

hold off;

xlabel('\theta_{12} (°)');
ylabel('Probability');
legend('NSR','VF');
title('EEMD: \theta_{12} distribution');

% emd t23
subplot(2,2,3);
h5 = histogram(t23_emd_all_nsr_deg, edges, 'Normalization','probability');
hold on;
h6 = histogram(t23_emd_all_vf_deg,  edges, 'Normalization','probability');

h5.FaceAlpha = 0.5;
h6.FaceAlpha = 0.5;

mu_nsr = mean(t23_emd_all_nsr_deg);
sigma_nsr = std(t23_emd_all_nsr_deg);
mu_vf  = mean(t23_emd_all_vf_deg);
sigma_vf = std(t23_emd_all_vf_deg);

% Compute Normal‐PDFs
y_nsr = normpdf(x_pdf, mu_nsr, sigma_nsr);
y_vf  = normpdf(x_pdf, mu_vf,  sigma_vf);

% Overlay the curves
plot(x_pdf, y_nsr, 'b--', 'LineWidth', 2);
plot(x_pdf, y_vf,  'r--', 'LineWidth', 2);

hold off;

xlabel('\theta_{23} (°)');
ylabel('Probability');
legend('NSR','VF');
title('EMD: \theta_{23} distribution');

% eemd t23
subplot(2,2,4);
h7 = histogram(t23_eemd_all_nsr_deg, edges, 'Normalization','probability');
hold on;
h8 = histogram(t23_eemd_all_vf_deg,  edges, 'Normalization','probability');

h7.FaceAlpha = 0.5;
h8.FaceAlpha = 0.5;

mu_nsr = mean(t23_eemd_all_nsr_deg);
sigma_nsr = std(t23_eemd_all_nsr_deg);
mu_vf  = mean(t23_eemd_all_vf_deg);
sigma_vf = std(t23_eemd_all_vf_deg);

% Compute Normal‐PDFs
y_nsr = normpdf(x_pdf, mu_nsr, sigma_nsr);
y_vf  = normpdf(x_pdf, mu_vf,  sigma_vf);

% Overlay the curves
plot(x_pdf, y_nsr, 'b--', 'LineWidth', 2);
plot(x_pdf, y_vf,  'r--', 'LineWidth', 2);

hold off;

xlabel('\theta_{23} (°)');
ylabel('Probability');
legend('NSR','VF');
title('EEMD: \theta_{23} distribution');


% --- 3) Scatter: θ12 vs θ23 for EMD (left) and EEMD (right) ---
figure('Units','normalized','Position',[.1 .1 .8 .4]);

% (a) EMD scatter
subplot(1,2,1); hold on;
scatter(t12_emd_all_nsr_deg, t23_emd_all_nsr_deg, 20, 'b', 'filled');
scatter(t12_emd_all_vf_deg,  t23_emd_all_vf_deg,  20, 'r', 'filled');
xlabel('\theta_{12} (°)'); ylabel('\theta_{23} (°)');
title('EMD: \theta_{12} vs \theta_{23}');
legend('NSR','VF','Location','best'); grid on; hold off;

% (b) EEMD scatter
subplot(1,2,2); hold on;
scatter(t12_eemd_all_nsr_deg, t23_eemd_all_nsr_deg, 20, 'b', 'filled');
scatter(t12_eemd_all_vf_deg,  t23_eemd_all_vf_deg,  20, 'r', 'filled');
xlabel('\theta_{12} (°)'); ylabel('\theta_{23} (°)');
title('EEMD: \theta_{12} vs \theta_{23}');
legend('NSR','VF','Location','best'); grid on; hold off;