function noisySignal = addAWGN(val, snr)
    % Add Gaussian noise to the original signal

    % Check if SNR is provided, otherwise, use a default value
    if nargin < 2
        snr = 0.2; % Default signal-to-noise ratio
    end

    % Generate Gaussian noise with specified SNR
    gaussianNoise = awgn(val, snr, 'measured');

    % Combine the original signal and the Gaussian noise
    noisySignal = val + gaussianNoise;
end
