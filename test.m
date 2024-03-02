% ---------------------------------------------------------------------------
% Adding noise to signal

% Load the data from '16265m.mat' file
load('16265m')

% Plot the original signal
subplot(2,1 , 1);
plot(val);
title('Original Signal');

% Add Gaussian noise with mean 0 and standard deviation 1
noisySignal = addGaussianNoise(val, 4, 1);

% Plot the noisy signal
subplot(2, 1, 2);
plot(noisySignal);
title('Noisy Signal');

% Adjust the figure layout
sgtitle('Comparison of Original and Noisy Signals'); % Add a common title



% -------------------------------------------------------------------------------
% reomve AWGN observing FFT spectrum


% Load the data from '04015m.mat' file
load('16265m')

% Plot the original signal
subplot(2, 3, 1);
plot(val);
title('Original Signal');

% Compute the frequency spectrum of the original signal
subplot(2, 3, 4);
analyzeFrequencySpectrum(val, 'Original Signal');

% Add Gaussian noise to the original signal
noisySignal = addAWGN(val, 0.2);

% Plot the noisy signal
subplot(2, 3, 2);
plot(noisySignal);
title('Noisy Signal');

% Compute the frequency spectrum of the noisy signal
subplot(2, 3, 5);
analyzeFrequencySpectrum(noisySignal, 'Noisy Signal');

% Specify SNR threshold
snrThreshold = 5; % Adjust based on your requirements

% Use the filter function to remove noise based on SNR threshold
filteredSignal = removeAWGN(noisySignal, val, snrThreshold);

% Plot the filtered signal
subplot(2, 3, 3);
plot(filteredSignal);
title('Filtered Signal');

% Compute the frequency spectrum of the filtered signal
subplot(2, 3, 6);
analyzeFrequencySpectrum(filteredSignal, 'Filtered Signal');

% Adjust the figure layout
suptitle('Comparison of Original, Noisy, and Filtered Signals');

% Function to analyze frequency spectrum
function analyzeFrequencySpectrum(signal, titleText)
    Fs = 128; % Set the sampling frequency (adjust as needed)
    L = length(signal);
    f = Fs * (0:(L/2)) / L;
    Y = fft(signal);
    P2 = abs(Y / L);
    P1 = P2(1:L/2 + 1);
    P1(2:end-1) = 2 * P1(2:end-1);
    plot(f, P1);
    title(['Frequency Spectrum of ' titleText]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
end


% -----------------------------------------------------------------------------------------------

% wavelet denoising
% Load the data from '04015m.mat' file
load('04015m')

% Add Gaussian noise to the original signal
noisySignal = addAWGN(val, 0.2);

% Specify denoising parameters
waveletName = 'db1';      % Choose a wavelet (e.g., 'db1' for Daubechies wavelet)
thresholdType = 'soft';    % Choose threshold type ('soft' or 'hard')
thresholdValue = 0.1;      % Adjust the threshold value based on your requirements

% Denoise the signal using the wavelet function
denoisedSignal = denoiseSignalWavelet(noisySignal, waveletName, thresholdType, thresholdValue);

% Plot the original, noisy, and denoised signals
figure;
subplot(3, 1, 1);
plot(val);
title('Original Signal');

subplot(3, 1, 2);
plot(noisySignal);
title('Noisy Signal');

subplot(3, 1, 3);
plot(denoisedSignal);
title('Denoised Signal');

% Adjust the figure layout
suptitle('Comparison of Original, Noisy, and Denoised Signals');

% -------------------------------------------------------------------------------------
% QRS feature decomposing
% Load ECG data (replace 'ecg_data.mat' with your file)
load('16265m.mat');


% Set the threshold for R-wave detection
threshold = 350;  % Adjust this threshold based on your signal characteristics

% Call the function
qrsFeatures = analyzeQRS(val, threshold);

% Display results
disp('QRS Features:');
disp('-------------------------------------------');
disp('  Start    |    End     | Duration | Amplitude |   Slope   ');
disp('-------------------------------------------');
for i = 1:length(qrsFeatures)
    fprintf('%8d | %8d | %8d | %9.4f | %9.4f\n', ...
        qrsFeatures(i).QRSStart, qrsFeatures(i).QRSEnd, ...
        qrsFeatures(i).QRSDuration, qrsFeatures(i).QRSAmplitude, qrsFeatures(i).QRSSlope);
end
disp('-------------------------------------------');

% Display results
disp('QRS Features:');
disp(qrsFeatures);

% Plot the original ECG signal with detected R-peaks
figure;
plot(val);
hold on;
plot([qrsFeatures.QRSStart], val([qrsFeatures.QRSStart]), 'r.', 'MarkerSize', 10);
hold off;
legend('ECG Signal', 'R-peaks');
title('ECG Signal with Detected R-peaks');
xlabel('Sample Points');
ylabel('Amplitude');




