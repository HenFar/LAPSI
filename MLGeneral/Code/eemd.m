function [modes, residue] = eemd(x, L, r, n)
%EEMD   1-D ensemble EMD: returns modes as N×n so plotting works
%
% [modes, residue] = eemd(x, L, r, n)
%   x  – input (N×1)
%   L  – ensemble size
%   r  – noise std factor
%   n  – number of IMFs
%
% modes   – N×n (each column is one averaged IMF)
% residue – N×1 (x minus sum of columns of modes)

    x = x(:);
    N = numel(x);

    % normalize
    sx = std(x);
    if sx < 0.01, sx = 1; end
    x0 = x ./ sx;

    % accumulator for N×n
    imfAcc = zeros(N, n);

    parfor k = 1:L
        disp(['Running ensemble #' num2str(k)]);
        wn = randn(N,1) * r;

        % +noise
        imf_p = emd(x0 + wn, 'MaxNumIMF', n);  % N×n
        imfAcc = imfAcc + imf_p;

        % –noise (if desired)
        if r > 0 && L > 1
            imf_m = emd(x0 - wn, 'MaxNumIMF', n);
            imfAcc = imfAcc + imf_m;
        end
    end

    % average and restore amplitude
    modes = (imfAcc .* sx) ./ (2 * L);  % N×n

    % residual = original minus sum across IMFs
    residue = x - sum(modes, 2);        % N×1
end
