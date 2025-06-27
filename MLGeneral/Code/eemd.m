function [modes, residue] = eemd(x, L, r, n)
    x = x(:);
    N = numel(x);

    % Normalize input
    sx = std(x);
    if sx < 0.01, sx = 1; end
    x0 = x ./ sx;

    imfAcc = zeros(N, n);
    count = 0;

    parfor k = 1:L
        disp(['Running ensemble #' num2str(k)]);
        wn = randn(N,1) * r;

        imf_p = emd(x0 + wn, 'MaxNumIMF', n);
        if size(imf_p, 2) == n
            imfAcc = imfAcc + imf_p;
            count = count + 1;
        end

        if r > 0 && L > 1
            imf_m = emd(x0 - wn, 'MaxNumIMF', n);
            if size(imf_m, 2) == n
                imfAcc = imfAcc + imf_m;
                count = count + 1;
            end
        end
    end

    % Avoid divide-by-zero
    if count == 0
        modes = NaN(N, n);
        residue = NaN(N, 1);
        return;
    end

    modes = (imfAcc * sx) / count;
    residue = x - sum(modes, 2);
end