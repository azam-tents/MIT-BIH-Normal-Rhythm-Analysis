function filteredSignal = removeAWGN(noisySignal, originalSignal, snrThreshold)
    % Remove Gaussian noise from the noisy signal based on SNR threshold

    % Calculate the original signal without noise
    noise = noisySignal - originalSignal;

    % Calculate the SNR of the noise
    actualSnr = snr(originalSignal, noise);

    % If the actual SNR is below the threshold, filter out the noise
    if actualSnr < snrThreshold
        filteredSignal = originalSignal;
    else
        filteredSignal = noisySignal;
    end
end
