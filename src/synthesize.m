function x = synthesize(f0, fs, T, c)
% SYNTHESIZE Generates a signal using additive Fourier synthesis.
%   x = SYNTHESIZE(f0, fs, T, c) constructs a waveform by summing multiple 
%   sine waves (harmonics) based on the provided coefficient vector.
%  
%   Inputs:
%       f0 - Fundamental frequency (Hz)
%       fs - Sampling frequency (Hz)
%       T  - Duration of the signal (seconds)
%       c  - Coefficient vector where c(n) is the amplitude of the nth harmonic
%  
%   Output:
%       x  - The synthesized time-domain signal
%  
%   The function implements the following summation:
%   x(t) = \sum_{n=1}^{N} c_n \sin(2\pi n f_0 t)

    % Create the time vector
    t = 0 : 1/fs : T - 1/fs;
    
    % Initialize the output signal with zeros
    x = zeros(1, length(t));
    
    % Additive synthesis loop
    for n = 1 : length(c)
        % Add the nth harmonic if the coefficient is non-zero
        if c(n) ~= 0
            x = x + c(n) * sin(n * 2 * pi * f0 * t);
        end
    end
end
