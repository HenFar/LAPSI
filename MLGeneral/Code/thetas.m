function [theta12_emd, theta23_emd, theta12_eemd, theta23_eemd] = thetas(segment)

    %— Run EMD first —
    x_emd = emd(segment);
    [~, nIMF_EMD] = size(x_emd);
    if nIMF_EMD < 3
        % Not enough IMFs to compute theta12/theta23
        theta12_emd = NaN;
        theta23_emd = NaN;
    else
        imf1_emd = x_emd(:,1);
        imf2_emd = x_emd(:,2);
        imf3_emd = x_emd(:,3);

        % Norms
        n1_emd = norm(imf1_emd);
        n2_emd = norm(imf2_emd);
        n3_emd = norm(imf3_emd);

        % Inner products
        ip12_emd = dot(imf1_emd, imf2_emd);
        ip23_emd = dot(imf2_emd, imf3_emd);

        % Cosine‐values (clamped to [–1, 1])
        r12_emd = ip12_emd / (n1_emd * n2_emd);
        r12_emd = min(1, max(-1, r12_emd));
        r23_emd = ip23_emd / (n2_emd * n3_emd);
        r23_emd = min(1, max(-1, r23_emd));

        % Angles
        theta12_emd = acos(r12_emd);
        theta23_emd = acos(r23_emd);
    end

    %— Now run EEMD —
    %   (Assuming you want 200 ensembles, noise = 0.2, and 3 siftings)
    x_eemd = eemd2(segment, 30, 0.2, 3);
    [~, nIMF_EEMD] = size(x_eemd);
    if nIMF_EEMD < 3
        theta12_eemd = NaN;
        theta23_eemd = NaN;
    else
        imf1_eemd = x_eemd(:,1);
        imf2_eemd = x_eemd(:,2);
        imf3_eemd = x_eemd(:,3);

        n1_eemd = norm(imf1_eemd);
        n2_eemd = norm(imf2_eemd);
        n3_eemd = norm(imf3_eemd);

        ip12_eemd = dot(imf1_eemd, imf2_eemd);
        ip23_eemd = dot(imf2_eemd, imf3_eemd);

        r12_eemd = ip12_eemd / (n1_eemd * n2_eemd);
        r12_eemd = min(1, max(-1, r12_eemd));
        r23_eemd = ip23_eemd / (n2_eemd * n3_eemd);
        r23_eemd = min(1, max(-1, r23_eemd));

        theta12_eemd = acos(r12_eemd);
        theta23_eemd = acos(r23_eemd);
    end
end