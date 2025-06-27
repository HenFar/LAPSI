function [theta12

% select 3 second intervals from both the nsr and the vf signals, 7338 for
% nsr and 6615 for vf. Note that the signals have different lengths, nsr is
% 30 min long, while vf is longer, at 35 min. Being that the sampling
% frequency is 128 Hz for nsr and 250 Hz for vf, then the following code
% separates them into their respective arrays.

% start with nsr
fs_nsr = 128;   % sampling frequency 128 Hz

