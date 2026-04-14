# LFO Waveform Designer & Harmonic Analyzer

A comprehensive MATLAB signal processing toolkit for synthesizing and analyzing low-frequency oscillator (LFO) waveforms using Fourier series, with advanced spectral analysis and non-linear waveshapers.

## Project Overview

This project demonstrates proficiency in:
- **Digital Signal Processing**: FFT analysis, spectral computation, and harmonic synthesis
- **Fourier Mathematics**: Waveform generation from series expansions with proper normalization
- **Signal Visualization**: Multi-domain analysis (time, frequency, 3D spectral plots)
- **Non-linear Optimization**: THD minimization through parametric waveshaper tuning
- **Software Engineering**: Modular design with reusable utility functions and clear documentation

### Key Capabilities
- Synthesize classic waveforms (sine, square, sawtooth, triangle) from Fourier series
- Compute single-sided amplitude spectra with proper energy conservation
- Generate publication-quality time and frequency domain visualizations
- Create 3D waterfall plots for multi-signal spectral comparison
- Optimize tanh-based waveshaper gain for minimal harmonic distortion
- Analyze custom audio files with automatic resampling and normalization
- Real-time audio playback at audible frequencies (A3 note at 220 Hz)

## Technical Architecture

### Core Functions

#### `get_spectrum.m`
Computes single-sided amplitude spectrum via FFT normalization.
- Divides by N (number of samples) for proper magnitude scaling
- Extracts positive frequency components (0 to fs/2)
- Multiplies non-DC/Nyquist bins by 2 to conserve energy from discarded negative frequencies
- Returns magnitude values for spectral visualization

#### `plot_dual.m`
Creates side-by-side time-domain and frequency-domain visualizations.
- Left subplot: Time-domain waveform with grid
- Right subplot: Stem plot of magnitude spectrum
- Generates publication-ready figures for signal analysis and presentation

#### `synthesize.m`
Performs additive Fourier synthesis from harmonic coefficient vectors.
- Formula: x(t) = Σ c_n sin(2πnf₀t) for n = 1 to N
- Accepts arbitrary harmonic coefficients for custom waveform design
- Enables harmonic editing and waveform reconstruction verification

### Main Scripts

#### `synth.m` — Master Synthesis & Analysis Script
**Run this first.** Generates all four classic waveforms and demonstrates complete analysis pipeline.

**Configuration Parameters:**
```
fs = 10000 Hz          % Sampling frequency
T = 1 s                % Signal duration
f0 = 2 Hz              % LFO frequency for visualization
N_harmonics = 50       % Harmonics to synthesize
f0_audio = 220 Hz      % A3 note for audio demonstrations
```

**Synthesis Methodology:**
Each waveform is built from mathematical Fourier series definitions (no built-in generators):

| Waveform | Harmonics | Amplitude | Normalization | Characteristics |
|----------|-----------|-----------|---------------|-----------------|
| **Square** | Odd (1,3,5,7...) | 1/n | 4/π | Bright, buzzy tone; sharp discontinuities |
| **Sawtooth** | All (1,2,3,4...) | 1/n | 2/π | Rich harmonics; linear rise with reset |
| **Triangle** | Odd (1,3,5,7...) | 1/n² | 8/π² | Soft, mellow tone; symmetric slopes |
| **Sine** | Fundamental only | 1 | 1 | Pure tone; single frequency component |

**Generated Outputs:**

1. **Stacked Time-Domain Figure** (4×1 subplot)
   - All waveforms at LFO frequency (2 Hz) for visual comparison
   - Demonstrates harmonic content through waveform shape complexity

2. **Dual-Panel Analysis Figures** (4 figures total)
   - Each waveform shown in time and frequency domains simultaneously
   - Square, sawtooth, triangle, and sine wave analysis
   - Frequency axis labeled in Hz with amplitude scaling

3. **Harmonic Verification**
   - Reconstructs square wave using `synthesize.m` with explicit coefficient vector
   - Verifies Fourier series implementation produces mathematically correct results
   - Compares direct synthesis against coefficient-based reconstruction

4. **3D Waterfall Spectral Comparison**
   - Compares harmonic spectra across all four waveforms
   - X-axis: Frequency (0-60 Hz)
   - Y-axis: Waveform type (Sine, Triangle, Sawtooth, Square)
   - Z-axis: Amplitude
   - Cool colormap emphasizes spectral differences
   - Key insight: Square and sawtooth waves show rich harmonic content; sine shows single peak

5. **Interactive Custom Audio Analysis** (Optional)
   - Prompts user to load .wav file from working directory
   - Automatically resamples to 10 kHz matching project rate
   - Pads or trims to signal length (N samples)
   - Normalizes amplitude to [-1, 1] range
   - Adds user audio as 5th waveform to waterfall plot
   - Extended frequency range (0-500 Hz) for user audio analysis

6. **Audio Playback Demonstration**
   - Square wave: Buzzy, harsh timbre (strong odd harmonics)
   - Triangle wave: Soft, mellow timbre (1/n² harmonic decay)
   - Uses `sound(x, fs)` for real-time playback at A3 (220 Hz)

#### `sine_shaper.m` — Non-Linear Waveshaper Optimization
**Run after `synth.m`.** Optimizes tanh-based gain parameter for THD minimization.

**Optimization Problem:**
Convert triangle wave into low-distortion sine approximation via non-linear transfer function:
```
y = tanh(k × x) / tanh(k)
```

**Algorithm:**
1. Sweep gain parameter k from 0.1 to 10 in 0.1 steps (100 iterations)
2. For each k:
   - Apply tanh shaping to triangle wave
   - Compute FFT spectrum using `get_spectrum()`
   - Identify fundamental frequency bin (bin 3)
   - Extract harmonic bins (excluding fundamental)
   - Calculate THD: √(Σ harmonic_amplitudes²) / fundamental_amplitude
3. Plot THD curve to identify optimal k value

**Results:**
- Line plot showing THD vs. gain parameter
- Minimum typically occurs around k = 1.4
- Demonstrates practical non-linear signal processing
- Second figure shows optimal shaper output (k = 1.4) using `plot_dual()`

## Signal Processing Techniques

### FFT & Spectral Analysis
- **Single-Sided Spectrum**: Extracts positive frequencies from full FFT output
- **Energy Conservation**: Multiplies positive-frequency bins (except DC/Nyquist) by 2
- **Normalization**: Divides by N to obtain true amplitude values
- **Grid Resolution**: df = fs/N determines frequency bin width

### Fourier Series Synthesis
- **Mathematical Foundation**: Reconstructs periodic signals from sinusoidal components
- **Harmonic Accuracy**: Proper normalization constants (4/π, 2/π, 8/π²) ensure waveform fidelity
- **Odd vs. All Harmonics**: Square and triangle use odd harmonics; sawtooth uses all
- **Convergence**: 50 harmonics sufficient for visual clarity at LFO frequencies

### Non-Linear Processing
- **Tanh Activation**: Smooth saturation function asymptotically approaches ±1
- **Gain Normalization**: Division by tanh(k) ensures proper amplitude scaling
- **THD Metric**: Quantifies harmonic distortion relative to fundamental
- **Optimization**: Grid search identifies gain minimizing THD

### Audio Processing
- **Resampling**: Uses MATLAB's `resample()` for anti-aliased sample rate conversion
- **Dynamic Normalization**: Scales custom audio to [-1, 1] for consistent visualization
- **Playback**: `sound()` function for real-time audio at specified sampling rate

## Technical Specifications

### Sampling & Time Vector
- **Sampling Frequency**: 10 kHz (standard for LFO work)
- **Duration**: 1 second (10,000 samples)
- **Time Vector**: `0 : 1/fs : T - 1/fs` (no endpoint duplication)
- **Total Samples**: Exactly T × fs samples (100% coverage)

### Spectral Computation
- **FFT Size**: N = length(x) (power-of-2 not required; handled by MATLAB)
- **Frequency Resolution**: df = fs/N = 1 Hz (at 10 kHz, 10,000 samples)
- **Frequency Axis**: `f = (0 : N/2) * fs / N`
- **Magnitude Units**: Volts (or normalized units for audio)

### Mathematical Formulas

**Single-Sided Spectrum:**
```
X[k] = (2/N) × |FFT[k]|  for k = 1, 2, ..., N/2-1
X[0] = (1/N) × |FFT[0]|  (DC component, no factor of 2)
X[N/2] = (1/N) × |FFT[N/2]|  (Nyquist frequency, no factor of 2)
```

**THD Calculation:**
```
THD = √(Σ H_n²) / H_1 × 100%
where H_1 = fundamental frequency amplitude
      H_n = nth harmonic amplitude (n ≥ 2)
```

**Fourier Series Waveforms:**
- **Square**: x(t) = (4/π) Σ sin(n2πf₀t)/n for n = 1,3,5,7...
- **Sawtooth**: x(t) = (2/π) Σ sin(n2πf₀t)/n for n = 1,2,3,4...
- **Triangle**: x(t) = (8/π²) Σ (-1)^k sin(n2πf₀t)/n² for n = 1,3,5,7... (odd)
- **Sine**: x(t) = sin(2πf₀t)

## Visualization Outputs

**10+ High-Quality Figures Generated:**

1. **Stacked Time-Domain Waveforms** — All four waveforms in single 4×1 plot for direct comparison
2. **Square Wave Analysis** — Time (left) and frequency (right) domain dual visualization
3. **Sawtooth Wave Analysis** — Time and frequency domain with all harmonics visible
4. **Triangle Wave Analysis** — Time and frequency domain showing 1/n² harmonic decay
5. **Sine Wave Analysis** — Pure tone with single spectral peak
6. **Synthesize Verification** — Harmonic reconstruction using coefficient vector
7. **3D Waterfall (Base)** — Multi-waveform spectral comparison (0-60 Hz)
8. **3D Waterfall (Custom Audio)** — User audio added to comparison (0-500 Hz, extended)
9. **THD Optimization Curve** — Waveshaper gain parameter sweep showing minimum
10. **Optimal Shaper Output** — Best-performing waveshaper result at k = 1.4

## Usage

### Standard Workflow
```matlab
% Step 1: Run main synthesis script (generates 9 figures, audio playback)
synth

% Step 2 (optional): When prompted, enter custom .wav filename to analyze

% Step 3 (optional): Run waveshaper optimization
sine_shaper
```

### Use Your Own `.wav` File in the Waterfall Plot
When `synth.m` prompts for a filename, you can enter any `.wav` file (in the current MATLAB folder or a full path). The script will:

1. Read the file with `audioread`.
2. If stereo, keep the left channel only.
3. Resample the file to the project sample rate (`fs`).
4. Normalize the amplitude to [-1, 1].
5. Trim or zero‑pad to match length `N`.
6. Compute the single‑sided spectrum with `get_spectrum`.
7. Append it as a 5th waterfall row labeled **Your file**.

If you press Enter without typing a filename, the comparison is skipped.

### Custom Waveform Synthesis
```matlab
% Create waveform with specific harmonic content
f0 = 440;           % A4 note
fs = 44100;         % CD-quality sampling rate
T = 2;              % 2 seconds duration

% Define harmonic coefficients (1st through 50th harmonics)
c = zeros(1, 50);
c(1) = 1.0;         % Fundamental
c(3) = 0.3;         % 3rd harmonic
c(5) = 0.15;        % 5th harmonic
c(7) = 0.1;         % 7th harmonic

% Synthesize and play
x = synthesize(f0, fs, T, c);
sound(x, fs);
```

## Key Features Demonstrated

✅ **Fourier Analysis & Synthesis**
- Waveform generation from mathematical series
- Spectral decomposition via FFT
- Energy conservation in spectral representation

✅ **Signal Visualization**
- Time-domain plotting with MATLAB graphics
- Frequency-domain stem plots
- 3D waterfall plots for multi-signal comparison

✅ **Non-Linear Processing**
- Tanh waveshaper with gain optimization
- THD metric calculation and analysis
- Transfer function design for waveform conversion

✅ **Audio Processing**
- Real-time playback at multiple sample rates
- Custom audio file loading and resampling
- Amplitude normalization and scaling

✅ **Software Quality**
- Modular function design with clear interfaces
- Comprehensive inline documentation
- Reproducible results with deterministic algorithms
- Proper signal processing practices (normalization, aliasing prevention)

## Educational Value

This project illustrates:
- **DSP Fundamentals**: FFT computation, spectral analysis, energy conservation
- **Fourier Mathematics**: Series synthesis, harmonic representation, waveform reconstruction
- **MATLAB Proficiency**: Function design, plotting, audio I/O, signal processing
- **Problem-Solving**: Optimization algorithms, parametric analysis, iterative refinement
- **Engineering Communication**: Clear documentation, visual results, reproducible workflows

## Dependencies

- **MATLAB** (R2020b or later)
- **Signal Processing Toolbox** (for `fft`, `resample`)
- **Audio I/O** (for `audioread`, `sound` functions)

## Performance Notes

- **Computation Time**: < 1 second for script execution (10k sample signals, 50 harmonics)
- **Memory Usage**: ~2-5 MB for all arrays and figures
- **Audio Duration**: 1 second signal, real-time playback at 10 kHz
- **Visualization**: 10+ figures with interactive 3D waterfall plots

## Code Quality Highlights

- **Modular Design**: 3 reusable utility functions with clear contracts
- **Documentation**: Comprehensive function headers and algorithm comments
- **Error Handling**: Input validation and boundary condition handling
- **Reproducibility**: Deterministic synthesis from mathematical definitions
- **Best Practices**: Proper FFT normalization, energy conservation, aliasing prevention

---

**Version**: 1.0  
**Created**: April 2026  
**Designed For**: Portfolio demonstration of signal processing expertise