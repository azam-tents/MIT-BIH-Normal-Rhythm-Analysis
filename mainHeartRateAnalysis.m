function AFHeartRateAnalysis()
    % Load the data from '16265m.mat' file
    load('16265m')

    % Plot the loaded data
    plot(val)

    % Find peaks in the data with a minimum peak height of 400
    peaks = findpeaks(val, 'MinPeakHeight', 400);

    % Calculate the duration of the data in seconds
    durationInSeconds = 1; % Adjust this based on your actual data duration

    % Calculate the number of detected peaks
    numPeaks = length(peaks);
    % Calculate the heart rate in beats per minute
    heartRateBPM = (numPeaks / durationInSeconds) ;
    % Read the sampling frequency from the info file
    infoFileName = '16265m.info';
    fid = fopen(infoFileName, 'rt');
    fgetl(fid); % Skip the first line
    fgetl(fid); % Skip the second line
    fgetl(fid); % Skip the third line
    
    % Read the fourth line to get the sampling frequency
    freqLine = fgetl(fid);
    fclose(fid);

    % Extract the sampling frequency from the line
    freq = sscanf(freqLine, 'Sampling frequency: %f Hz  Sampling interval: %f sec');
    
    % Display the sampling frequency
    fprintf('Sampling Frequency: %.2f Hz\n', freq(1));

    % Display the results
    fprintf('Number of Peaks: %d\n', numPeaks);
    fprintf('Estimated Heart Rate: %.2f beats per minute\n', heartRateBPM);
end
