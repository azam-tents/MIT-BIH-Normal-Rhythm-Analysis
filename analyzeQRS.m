function qrsFeatures = analyzeQRS(val, threshold)
    % ANALYZEQRS analyzes the QRS complexes in an ECG signal.
    %   qrsFeatures = ANALYZEQRS(val, threshold) analyzes the QRS
    %   complexes in the input ECG signal using a specified threshold for
    %   R-wave detection. It returns a structure qrsFeatures containing
    %   information about the detected QRS complexes, including QRS duration,
    %   amplitude, and slope.

    % Find R-peaks
    [~, r_peaks] = findpeaks(val, 'MinPeakHeight', threshold);

    % Initialize QRS features structure
    qrsFeatures = struct('QRSStart', {}, 'QRSEnd', {}, 'QRSDuration', {}, ...
                         'QRSAmplitude', {}, 'QRSSlope', {});

    % QRS complex analysis
    for i = 1:length(r_peaks)-1
        qrsFeatures(i).QRSStart = r_peaks(i);
        qrsFeatures(i).QRSEnd = r_peaks(i+1);

        % Extract the QRS complex
        qrs_complex = val(qrsFeatures(i).QRSStart:qrsFeatures(i).QRSEnd);

        % Measure QRS duration
        qrsFeatures(i).QRSDuration = qrsFeatures(i).QRSEnd - qrsFeatures(i).QRSStart;

        % Measure QRS amplitude
        qrsFeatures(i).QRSAmplitude = max(qrs_complex) - min(qrs_complex);

        % Measure QRS slope (approximated as change in amplitude over duration)
        qrsFeatures(i).QRSSlope = qrsFeatures(i).QRSAmplitude / qrsFeatures(i).QRSDuration;
    end
end
