function [theta12_emd, theta23_emd, theta12_eemd, theta23_eemd] = ...
         thetas(segment, ens, nos)

    %— Run EMD first —
    imfs_emd = emd(segment, 'MaxNumIMF', 3);
    if size(imfs_emd,2) < 3
        theta12_emd = NaN;
        theta23_emd = NaN;
    else
        i1 = imfs_emd(:,1);
        i2 = imfs_emd(:,2);
        i3 = imfs_emd(:,3);

        r12 = dot(i1,i2)/(norm(i1)*norm(i2));
        r23 = dot(i2,i3)/(norm(i2)*norm(i3));
        % clamp just in case of rounding
        r12 = min(1, max(-1, r12));
        r23 = min(1, max(-1, r23));

        % acos in radians → convert to degrees
        theta12_emd = acos(r12) * (180/pi);
        theta23_emd = acos(r23) * (180/pi);
    end

    %— Now run EEMD with the same ensemble & noise settings —
    [imfs_eemd, ~] = eemd(segment, ens, nos, 3);
    if size(imfs_eemd,2) < 3
        theta12_eemd = NaN;
        theta23_eemd = NaN;
    else
        j1 = imfs_eemd(:,1);
        j2 = imfs_eemd(:,2);
        j3 = imfs_eemd(:,3);

        r12e = dot(j1,j2)/(norm(j1)*norm(j2));
        r23e = dot(j2,j3)/(norm(j2)*norm(j3));
        r12e = min(1, max(-1, r12e));
        r23e = min(1, max(-1, r23e));

        theta12_eemd = acos(r12e) * (180/pi);
        theta23_eemd = acos(r23e) * (180/pi);
    end
end
