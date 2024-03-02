function denoisedSignal = denoiseSignalWavelet(inputSignal, waveletName, thresholdType, thresholdValue)
    % Denoise the input signal using wavelet thresholding

    % Perform a single-level wavelet decomposition
    [C, L] = wavedec(inputSignal, 1, waveletName);

    % Set threshold value based on the threshold type
    switch lower(thresholdType)
        case 'soft'
            % Soft thresholding
            thresholdedCoefficients = wthresh(C, 's', thresholdValue);
        case 'hard'
            % Hard thresholding
            thresholdedCoefficients = wthresh(C, 'h', thresholdValue);
        otherwise
            error('Invalid threshold type. Use ''soft'' or ''hard''.');
    end

    % Perform wavelet reconstruction with thresholded coefficients
    denoisedSignal = waverec(thresholdedCoefficients, L, waveletName);
end
