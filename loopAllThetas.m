function [t12_emd_all_nsr_deg, t23_emd_all_nsr_deg, t12_eemd_all_nsr_deg, t23_eemd_all_nsr_deg, ...
    t12_emd_all_vf_deg, t23_emd_all_vf_deg, t12_eemd_all_vf_deg, t23_eemd_all_vf_deg] = ...
    loopAllThetas(nsrFolder, Fs_nsr, vfFolder, Fs_vf)

nsrFiles = dir(fullfile(nsrFolder, '*.mat'));
vfFiles  = dir(fullfile(vfFolder,  '*.mat'));

disp("NSR folder contents:");
disp({ nsrFiles.name }');   % prints a column of all .mat names
disp("VF folder contents:");
disp({ vfFiles.name }');

t12_emd_all_nsr = [];
t23_emd_all_nsr = [];
t12_eemd_all_nsr = [];
t23_eemd_all_nsr = [];
t12_emd_all_vf = [];
t23_emd_all_vf = [];
t12_eemd_all_vf = [];
t23_eemd_all_vf = [];


for kFile = 1:numel(nsrFiles)
    fn = fullfile(nsrFiles(kFile).folder, nsrFiles(kFile).name);
    data = load(fn);
    [b,a] = butter(4, [0.5 40]/(Fs_nsr/2));    % butterworth filter for nsr
    ecg = filtfilt(b, a, double(data.val(2,:)));
    ecg = ecg(:);

    segments = segments3s(ecg, Fs_nsr);
    nSeg = numel(segments);

    for k = 1:nSeg
       s = segments{k};
       [t12e, t23e, t12ee, t23ee] = thetas(s, 200, 0.2);

        t12_emd_all_nsr(end+1, 1) = t12e;
        t23_emd_all_nsr(end+1, 1) = t23e;
        t12_eemd_all_nsr(end+1, 1) = t12ee;
        t23_eemd_all_nsr(end+1, 1) = t23ee;
    end
end

for kFile = 1:numel(vfFiles)
    fn = fullfile(vfFiles(kFile).folder, vfFiles(kFile).name);
    data = load(fn);
    [b,a] = butter(4, [0.5 40]/(Fs_vf/2));    % butterworth filter for nsr
    ecg = filtfilt(b, a, double(data.val(2,:)));
    ecg = ecg(:);

    segments = segments3s(ecg, Fs_vf);
    nSeg = numel(segments);

    for k = 1:nSeg
       s = segments{k};
       [t12e, t23e, t12ee, t23ee] = thetas(s, 200, 0.2);

        t12_emd_all_vf(end+1, 1) = t12e;
        t23_emd_all_vf(end+1, 1) = t23e;
        t12_eemd_all_vf(end+1, 1) = t12ee;
        t23_eemd_all_vf(end+1, 1) = t23ee;
    end
end

t12_emd_all_nsr_deg  = t12_emd_all_nsr;
t23_emd_all_nsr_deg  = t23_emd_all_nsr;
t12_eemd_all_nsr_deg = t12_eemd_all_nsr;
t23_eemd_all_nsr_deg = t23_eemd_all_nsr;

t12_emd_all_vf_deg   = t12_emd_all_vf;
t23_emd_all_vf_deg   = t23_emd_all_vf;
t12_eemd_all_vf_deg  = t12_eemd_all_vf;
t23_eemd_all_vf_deg  = t23_eemd_all_vf;

end