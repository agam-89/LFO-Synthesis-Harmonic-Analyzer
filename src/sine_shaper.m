%% Sine-Shaping Optimizer: THD vs. Gain (k)
% This script analyzes a non-linear tanh-based waveshaper to find the 
% optimal gain 'k' that converts a triangle wave into a low-distortion sine wave.
%
% The transfer function used is: y = tanh(k * x) / tanh(k).

% Define range for the gain parameter k
k_range = 0.1 : 0.1 : 10;
thd_values = zeros(1, length(k_range));

for i = 1:length(k_range)
    k = k_range(i);
    
    % Apply non-linear tanh shaping
    y = tanh(k * x_tri) / tanh(k);
    
    % Compute spectrum for THD analysis
    Y = abs(fft(y) / length(y));
    Y = Y(1 : length(y)/2 + 1);
    Y(2:end-1) = 2 * Y(2:end-1);
    
    % Identify fundamental frequency and harmonics
    % Note: Assumes specific bin mapping based on synth.m parameters
    fundamental = Y(3); 
    harmonics = Y([2, 4:end]);  
    
    % Calculate THD: sqrt(sum(harmonics^2)) / fundamental
    thd_values(i) = sqrt(sum(harmonics.^2)) / fundamental;
end

%% Visualization of Results
figure;
plot(k_range, thd_values, 'LineWidth', 1.5);
xlabel('Gain Parameter (k)');
ylabel('Total Harmonic Distortion (THD)');
title('THD Optimization for Tanh Waveshaper');
grid on;

% Demonstrate optimal result at k = 1.4
k_opt = 1.4;
y_optimal = tanh(k_opt * x_tri) / tanh(k_opt);
figure;
plot_dual(t, y_optimal, fs, 'Optimal Shaper (k=1.4)');
