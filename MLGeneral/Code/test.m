% tester for the eemd funnction also in the present folder.
% uses a sin signal and adds to it a random noise, whose strength may be varied.
% its supposed to print the original signal, the n (n = 6 here) IMFs selected and the residue of the transformation, 
% along with adding both the imfs and residue to the workspace. imfs should be a large matrix and residue should 
% present as a vector.

t = linspace(0, 1, 1000);   % x axis 

noise_strength = 0.2;   % define noise strength
signal = sin(2*pi*t)+noise_strength*randn(size(t));    % sin signal with random noise

L = 200;
r = 0.2;
n = 6;

[imfs, residue] = eemd(signal, L, r, n);
