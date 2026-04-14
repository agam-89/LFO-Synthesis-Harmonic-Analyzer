% batch_analysis.m

% This MATLAB script demonstrates how to batch analyze multiple .wav audio files,
% process them with get_spectrum.m, and generate comparative visualizations.

% Clear workspace and command window
clear; clc;

% Folder containing .wav files
folderPath = 'path_to_your_wav_files';

% Get a list of all .wav files in the folder
wavFiles = dir(fullfile(folderPath, '*.wav'));

% Preallocate arrays for storing spectra
spectra = cell(length(wavFiles), 1);

% Loop through each .wav file
for i = 1:length(wavFiles)
    % Read the .wav file
    [audioData, sampleRate] = audioread(fullfile(folderPath, wavFiles(i).name));
    
    % Process with get_spectrum (assumed to be a user-defined function)
    spectra{i} = get_spectrum(audioData, sampleRate);
end

% Generate comparative visualizations
figure;
hold on;

% Loop through the spectra to plot
for i = 1:length(spectra)
    plot(spectra{i}.frequency, spectra{i}.magnitude, 'DisplayName', wavFiles(i).name);
end

% Label axes and add legend
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Comparative Spectra of Audio Files');
grid on;
legend('show');
hold off;
