function [theta12_emd, theta23_emd, theta12_eemd, theta23_eemd, imfs_emd, imfs_eemd] = thetas_with_imfs(segment, ens, nos)
    % Normalize segment
    segment = segment(:);
    sx = std(segment);
    if sx < 0.01, sx = 1; end
    segment = segment / sx;

    % Run EMD
    imfs_emd = emd(segment, 'MaxNumIMF', 3);
    if size(imfs_emd, 2) < 3
        theta12_emd = NaN;
        theta23_emd = NaN;
    else
        i1 = imfs_emd(:,1);
        i2 = imfs_emd(:,2);
        i3 = imfs_emd(:,3);

        r12 = dot(i1,i2)/(norm(i1)*norm(i2));
        r23 = dot(i2,i3)/(norm(i2)*norm(i3));

        theta12_emd = acos(min(1,max(-1,r12))) * (180/pi);
        theta23_emd = acos(min(1,max(-1,r23))) * (180/pi);
    end

    % Run EEMD
    [imfs_eemd, ~] = eemd(segment, ens, nos, 3);
    if size(imfs_eemd, 2) < 3 || any(isnan(imfs_eemd(:)))
        theta12_eemd = NaN;
        theta23_eemd = NaN;
    else
        j1 = imfs_eemd(:,1);
        j2 = imfs_eemd(:,2);
        j3 = imfs_eemd(:,3);

        r12e = dot(j1,j2)/(norm(j1)*norm(j2));
        r23e = dot(j2,j3)/(norm(j2)*norm(j3));

        theta12_eemd = acos(min(1,max(-1,r12e))) * (180/pi);
        theta23_eemd = acos(min(1,max(-1,r23e))) * (180/pi);
    end
end
