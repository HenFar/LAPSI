function [t12_emd, t23_emd, t12_eemd, t23_eemd] = ecg_thetas(loc, Fs)

x = load(loc);
data = x.val;
ecg = data(2, :);  % using ecg2, following the instructions from the paper

segments = segments3s(ecg, Fs); % define the segments

l = numel(segments);

t12_emd = zeros(l, 1);
t23_emd = zeros(l, 1);
t12_eemd = zeros(l, 1);
t23_eemd = zeros(l, 1);

for k = 1:l
    s = segments{k};
    [theta12_emd, theta23_emd, theta12_eemd, theta23_eemd] = thetas(s);
    
    t12_emd(k) = theta12_emd;
    t23_emd(k) = theta23_emd;
    t12_eemd(k) = theta12_eemd;
    t23_eemd(k) = theta23_eemd;
end

