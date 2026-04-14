function plot_dual(t, x, fs, name)
% PLOT_DUAL Generates a side-by-side Time and Frequency domain visualization.
%   PLOT_DUAL(t, x, fs, name) plots the time-domain waveform and its 
%   corresponding single-sided magnitude spectrum.
%  
%   Inputs:
%       t    - Time vector
%       x    - Signal data
%       fs   - Sampling frequency (Hz)
%       name - Title string for the time-domain plot

    % Subplot 1: Time Domain
    subplot(1, 2, 1);
    plot(t, x);
    title(name);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;

    % Spectrum Calculation
    N = length(x);
    X = abs(fft(x)/N);
    X = X(1 : N/2 + 1);
    X(2:end-1) = 2 * X(2:end-1); % Conserve energy
    f = (0 : N/2) * fs / N;      % Frequency axis in Hz

    % Subplot 2: Frequency Domain
    subplot(1, 2, 2);
    stem(f, X, 'Marker', 'none'); % Stem plot is standard for discrete harmonics
    title('Magnitude Spectrum');
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    grid on;
end
