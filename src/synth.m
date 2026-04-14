%% LFO Waveform Designer & Harmonic Analyzer
% Synthesizes LFO waveforms from Fourier series, analyzes their harmonic
% content, and demonstrates audio output at audible frequencies.
% Run this script first before running sine_shaper.m

%% Parameters
fs = 10000;         % sampling frequency (Hz)
T = 1;              % signal duration (seconds)
f0 = 2;             % LFO frequency for plots (Hz) — kept low for visibility
N_harmonics = 50;   % number of harmonics to sum
t = 0:1/fs:T-1/fs;  % time vector — T*fs samples, no endpoint overlap
f0_audio = 220;     % A3 note frequency for audio demos (Hz)

%% Waveform Synthesis at LFO Frequency (f0 = 2Hz)
% All four waveforms built from Fourier series — no built-in generators used

% Square wave — odd harmonics only, amplitude falls as 1/n
x_square = zeros(1,length(t));
for k = 0:49
    n = 2*k + 1;    % odd harmonic indices: 1, 3, 5, 7...
    x_square = x_square + (1/n) * sin(n*2*pi*f0*t);
end
x_square = (4/pi)*x_square;    % Fourier normalization constant

% Sawtooth wave — all harmonics, amplitude falls as 1/n
x_saw = zeros(1,length(t));
for n = 1:N_harmonics
    x_saw = x_saw + (1/n)*sin(n*2*pi*f0*t);
end
x_saw = (2/pi)*x_saw;          % Fourier normalization constant

% Triangle wave — odd harmonics only, amplitude falls as 1/n^2, signs alternate
x_tri = zeros(1,length(t));
for k = 0:49
    n = 2*k + 1;  % odd harmonic indices
    x_tri = x_tri + ((-1)^k/n^2) * sin(n*2*pi*f0*t);  % (-1)^k gives alternating signs
end
x_tri = (8/pi^2)*x_tri;        % Fourier normalization constant

% Sine wave — trivially just the fundamental, no summation needed
x_sine = sin(2*pi*f0*t);

%% Visualization — Time Domain (all four waveforms stacked)
subplot(4, 1, 1);
plot(t, x_square);
title('square');
grid on;
subplot(4, 1, 2);
plot(t, x_saw);
title('sawtooth');
grid on;
subplot(4, 1, 3);
plot(t, x_tri);
title('triangle');
grid on;
subplot(4, 1, 4);
plot(t, x_sine);
title('sine');
grid on;
xlabel('Time (s)');

%% Visualization — Dual Panel (time domain + spectrum per waveform)
% Each waveform gets its own figure with time domain on left, spectrum on right
figure;
plot_dual(t, x_square, fs, 'square wave');
figure;
plot_dual(t, x_saw, fs, 'sawtooth wave');
figure;
plot_dual(t, x_tri, fs, 'triangle wave');
figure;
plot_dual(t, x_sine, fs, 'sine wave');

%% Harmonic Editor — Coefficient Vector Demo
% Rebuilds square wave using synthesize.m with an explicit coefficient vector
% Verifies that synthesize.m reproduces Phase 1 results exactly
c_square = zeros(1,50);        % coefficient vector — index n holds amplitude of nth harmonic
for k = 0:49
    n = 2*k + 1;
    c_square(n) = 1/n;         % odd harmonics only, 1/n falloff
end
c_square = c_square*(4/pi);    % apply normalization

x_test = synthesize(f0, fs, T, c_square);
figure;
plot_dual(t, x_test, fs, 'square via synthesize');

%% Audio Demo at A3 (f0_audio = 220Hz)
% Resynthesizes waveforms at audible frequency so harmonic content can be heard
% Note: run each sound() call separately to avoid overlap

% Square wave audio — buzzy, harsh tone due to strong odd harmonics
x_square_audio = zeros(1, length(t));
for k = 0:49
    n = 2*k + 1;
    x_square_audio = x_square_audio + (1/n) * sin(n * 2*pi*f0_audio*t);
end
x_square_audio = (4/pi) * x_square_audio;
sound(x_square_audio, fs);

% Triangle wave audio — softer, mellower tone due to 1/n^2 harmonic falloff
x_tri_audio = zeros(1, length(t));
for k = 0:49
    n = 2*k + 1;
    x_tri_audio = x_tri_audio + ((-1)^k/n^2) * sin(n*2*pi*f0_audio*t);
end
x_tri_audio = (8/pi^2) * x_tri_audio;
sound(x_tri_audio, fs);

%% Waterfall Plot
clear W;

N = length(t);
if mod(N, 2) ~= 0
    N = N - 1;
end


f_axis = (0:N/2) * fs / N;
W(1,:) = get_spectrum(x_sine(1:N), N);
W(2,:) = get_spectrum(x_tri(1:N), N);
W(3,:) = get_spectrum(x_saw(1:N), N);
W(4,:) = get_spectrum(x_square(1:N), N);

figure;
waterfall(f_axis, 1:4, W);
xlim([0 60]);
xlabel('Frequency (Hz)');
ylabel('Waveform');
zlabel('Amplitude');
title('Harmonic spectrum — all waveforms');
yticks(1:4);
yticklabels({'Sine', 'Triangle', 'Sawtooth', 'Square'});
gridx on;
colormap cool;


%% Interactive — load your own audio file and add to waterfall
% Place any .wav file in your MATLAB folder and enter its name when prompted
user_file = input('Enter a .wav filename to analyze (or press Enter to skip): ', 's');
if ~isempty(user_file)
    % read the audio file
    [x_user, fs_user] = audioread(user_file);
    % if stereo, take left channel only
    x_user = x_user(:, 1)';
    x_user = resample(x_user, fs, fs_user);
    x_user = x_user / max(abs(x_user));
    % trim or pad to match length of other signals
    if length(x_user) > N
        x_user = x_user(1:N);
    else
        x_user = [x_user, zeros(1, N - length(x_user))];
    end
    % normalize spectrum so it's visible next to synthesized waveforms
    user_spec = get_spectrum(x_user, N);
    user_spec = user_spec / max(user_spec);
    W(5,:) = user_spec;
    figure;
    waterfall(f_axis, 1:5, W);
    xlim([0 500]);
xlabel('Frequency (Hz)');
ylabel('Waveform');
zlabel('Amplitude');
title('Harmonic spectrum — all waveforms + your audio');
yticks(1:5);
yticklabels({'Sine', 'Triangle', 'Sawtooth', 'Square', 'Your file'});
gridx on;
else
    disp('No file entered, skipping audio comparison.');
end
