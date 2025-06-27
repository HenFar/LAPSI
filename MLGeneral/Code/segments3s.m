function segments = segments3s(x, Fs)

    x = x(:);   % must be a column vec
    win_length = 3 * Fs;

    nWin = floor(length(x) / win_length);

    segments = cell(nWin, 1);   % preallocate space

    for k = 1:nWin
        idxStart = (k-1)*win_length + 1;
        idxEnd   = idxStart + win_length - 1;
        segments{k} = x(idxStart : idxEnd);
    end