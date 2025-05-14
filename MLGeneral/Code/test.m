t = linspace(0, 1, 1000);
signal = sin(2*pi*t)+0.3*randn(size(t));

[imfs, ort, nb_iter] = emd(signal);
figure, plot(t, signal);
legend('signal'); title('main signal');

figure, plot(t, imfs(1:3,:)');
legend('IMF1', 'IMF2', 'IMF3'); title('First 3 IMFs');