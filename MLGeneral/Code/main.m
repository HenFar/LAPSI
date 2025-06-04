% page 5 plots
ecg_plots('ECGs/NSR/117m.mat', '(NSR)117')  % plots NSR
ecg_plots('ECGs/VF/418m.mat', '(VF)418')    % plots VF

[t12_emd_all_nsr_deg, t23_emd_all_nsr_deg, t12_eemd_all_nsr_deg, t23_eemd_all_nsr_deg, ...
    t12_emd_all_vf_deg, t23_emd_all_vf_deg, t12_eemd_all_vf_deg, t23_eemd_all_vf_deg] = ...
    loopAllThetas('Project/ECGs/NSR', 360, 'Project/ECGs/VF', 360);

edges = 40:1:130;

figure('Position',[100 100 1000 700]);

% --- 2a) θ12 via plain EMD (NSR vs VF) ---
subplot(2,2,1);
h1 = histogram(t12_emd_all_nsr_deg, edges, 'Normalization','probability');
hold on;
h2 = histogram(t12_emd_all_vf_deg,  edges, 'Normalization','probability');
hold off;

% Make bars semi‐transparent so overlap is visible
h1.FaceAlpha = 0.5;
h2.FaceAlpha = 0.5;

xlabel('\theta_{12} (°)');
ylabel('Probability');
legend('NSR','VF');
title('EMD: \theta_{12} distribution');



% --- 2b) θ12 via EEMD (NSR vs VF) ---
subplot(2,2,2);
h3 = histogram(t12_eemd_all_nsr_deg, edges, 'Normalization','probability');
hold on;
h4 = histogram(t12_eemd_all_vf_deg,  edges, 'Normalization','probability');
hold off;

h3.FaceAlpha = 0.5;
h4.FaceAlpha = 0.5;

xlabel('\theta_{12} (°)');
ylabel('Probability');
legend('NSR','VF');
title('EEMD: \theta_{12} distribution');

% --- 2c) θ23 via plain EMD (NSR vs VF) ---
subplot(2,2,3);
h5 = histogram(t23_emd_all_nsr_deg, edges, 'Normalization','probability');
hold on;
h6 = histogram(t23_emd_all_vf_deg,  edges, 'Normalization','probability');
hold off;

h5.FaceAlpha = 0.5;
h6.FaceAlpha = 0.5;

xlabel('\theta_{23} (°)');
ylabel('Probability');
legend('NSR','VF');
title('EMD: \theta_{23} distribution');

% --- 2d) θ23 via EEMD (NSR vs VF) ---
subplot(2,2,4);
h7 = histogram(t23_eemd_all_nsr_deg, edges, 'Normalization','probability');
hold on;
h8 = histogram(t23_eemd_all_vf_deg,  edges, 'Normalization','probability');
hold off;

h7.FaceAlpha = 0.5;
h8.FaceAlpha = 0.5;

xlabel('\theta_{23} (°)');
ylabel('Probability');
legend('NSR','VF');
title('EEMD: \theta_{23} distribution');