% custom_waveform_example.m
% This script demonstrates how to create custom waveforms using the synthesize.m function.
% We will implement multiple examples with different harmonic coefficients.

%% Example 1: Simple Sine Wave
harmonics1 = [1];  % Only the fundamental frequency
frequency1 = 440;  % Frequency in Hz
sample_rate1 = 44100;  % Sample rate in Hz
duration1 = 2; % Duration in seconds

waveform1 = synthesize(harmonics1, frequency1, sample_rate1, duration1);

figure;
plot(waveform1);
title('Simple Sine Wave');
xlabel('Samples');
ylabel('Amplitude');

%% Example 2: Square Wave
harmonics2 = [1, 3, 5];  % Fundamental and odd harmonics
frequency2 = 440;
duration2 = 2;
waveform2 = synthesize(harmonics2, frequency2, sample_rate1, duration2);

figure;
plot(waveform2);
title('Square Wave');
xlabel('Samples');
ylabel('Amplitude');

%% Example 3: Sawtooth Wave
harmonics3 = [1, 2, 3, 4, 5];  % Fundamental and first five harmonics
frequency3 = 440;
duration3 = 2;
waveform3 = synthesize(harmonics3, frequency3, sample_rate1, duration3);

figure;
plot(waveform3);
title('Sawtooth Wave');
xlabel('Samples');
ylabel('Amplitude');

%% Example 4: Custom Harmonic Set
harmonics4 = [1, 0.5, 0.33];  % Custom decaying harmonics
frequency4 = 440;
duration4 = 2;
waveform4 = synthesize(harmonics4, frequency4, sample_rate1, duration4);

figure;
plot(waveform4);
title('Custom Harmonic Set');
xlabel('Samples');
ylabel('Amplitude');

%% Summary of Waveforms
% This script showcases four different types of waveforms that can be generated
% using the synthesize function with varying harmonic coefficients. 
% Experiment with different harmonic values to create unique sounds!