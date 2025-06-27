function [t12_emd_all_nsr_deg, t23_emd_all_nsr_deg, t12_eemd_all_nsr_deg, t23_eemd_all_nsr_deg, ...
          t12_emd_all_vf_deg,  t23_emd_all_vf_deg,  t12_eemd_all_vf_deg,  t23_eemd_all_vf_deg] = ...
         loopAllThetas(nsrFolder, Fs_nsr, vfFolder, Fs_vf)

    nsrFiles = dir(fullfile(nsrFolder, '*.mat'));
    vfFiles  = dir(fullfile(vfFolder, '*.mat'));

    disp("NSR folder contents:");
    disp({ nsrFiles.name }');
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

    % --- NSR processing ---
    for kFile = 1:numel(nsrFiles)
        fn = fullfile(nsrFiles(kFile).folder, nsrFiles(kFile).name);
        data = load(fn);
        ecg = double(data.val(2, :));

        [b,a] = butter(4, [0.5 40] / (Fs_nsr / 2));
        ecg = filtfilt(b, a, ecg(:));

        segments = segments3s(ecg, Fs_nsr);
        for k = 1:numel(segments)
            s = segments{k};
            
            % entropy check
            % H = mean(pentropy(s, Fs_nsr));
            % if H < 0.4 || H > 0.7
            %     continue;
            % end

            [t12e, t23e, t12ee, t23ee] = thetas(s, 300, 0.15);

            if all(~isnan([t12e t23e t12ee t23ee]))
                t12_emd_all_nsr(end+1, 1)  = t12e;
                t23_emd_all_nsr(end+1, 1)  = t23e;
                t12_eemd_all_nsr(end+1, 1) = t12ee;
                t23_eemd_all_nsr(end+1, 1) = t23ee;
            end
        end
    end

    % --- VF processing ---
    for kFile = 1:numel(vfFiles)
        fn = fullfile(vfFiles(kFile).folder, vfFiles(kFile).name);
        data = load(fn);
        ecg = double(data.val(2, :));

        % Optional resampling to 360 Hz if needed
        if Fs_vf ~= 360
            ecg = resample(ecg, 360, Fs_vf);
            Fs_vf = 360;
        end

        [b,a] = butter(4, [0.5 40] / (Fs_vf / 2));
        ecg = filtfilt(b, a, ecg(:));

        segments = segments3s(ecg, Fs_vf);
        for k = 1:numel(segments)
            s = segments{k};

            % entropy check
            % H = mean(pentropy(s, Fs_nsr));
            % if H < 0.75 || H > 0.95
            %     continue;
            % end

            [t12e, t23e, t12ee, t23ee] = thetas(s, 300, 0.15);

            if all(~isnan([t12e t23e t12ee t23ee]))
                t12_emd_all_vf(end+1, 1)  = t12e;
                t23_emd_all_vf(end+1, 1)  = t23e;
                t12_eemd_all_vf(end+1, 1) = t12ee;
                t23_eemd_all_vf(end+1, 1) = t23ee;
            end
        end
    end

    % Final assignment
    t12_emd_all_nsr_deg  = t12_emd_all_nsr;
    t23_emd_all_nsr_deg  = t23_emd_all_nsr;
    t12_eemd_all_nsr_deg = t12_eemd_all_nsr;
    t23_eemd_all_nsr_deg = t23_eemd_all_nsr;

    t12_emd_all_vf_deg   = t12_emd_all_vf;
    t23_emd_all_vf_deg   = t23_emd_all_vf;
    t12_eemd_all_vf_deg  = t12_eemd_all_vf;
    t23_eemd_all_vf_deg  = t23_eemd_all_vf;
end