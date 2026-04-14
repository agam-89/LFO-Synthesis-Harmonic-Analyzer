function X = get_spectrum(x, N)
% GET_SPECTRUM Computes the single-sided amplitude spectrum of a signal.
%   X = GET_SPECTRUM(x, N) takes a signal 'x' and the number of FFT points 'N',
%   returning the magnitude of the positive frequency components.
%  
%   Process:
%   1. Computes the FFT and normalizes by the number of samples (1/N).
%   2. Extracts the first N/2 + 1 points to represent positive frequencies.
%   3. Multiplies non-DC and non-Nyquist components by 2 to conserve energy.

    % Magnitude of normalized FFT
    X = abs(fft(x)/N); 
    
    % Extract positive frequencies (single-sided)
    X = X(1 : N/2+1); 
    
    % Multiply by 2 to account for discarded negative frequencies
    X(2:end-1) = 2 * X(2:end-1); 
end
