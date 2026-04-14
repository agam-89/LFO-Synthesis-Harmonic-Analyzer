# LFO Waveform Designer & Harmonic Analyzer

A comprehensive MATLAB toolkit for synthesizing and analyzing low-frequency oscillator (LFO) waveforms using Fourier series, with advanced signal processing capabilities including spectral analysis and non-linear waveshaping optimization.

## Project Overview

This project provides a suite of tools for:
- **Waveform Synthesis**: Generate square, sawtooth, triangle, and sine waves from Fourier series
- **Spectral Analysis**: Compute and visualize single-sided amplitude spectra
- **Harmonic Visualization**: Interactive waterfall plots comparing harmonic content
- **Non-linear Processing**: Optimize tanh-based waveshaper gain for minimal distortion
- **Audio Demonstration**: Real-time audio output at audible frequencies (A3 note)
- **Custom Signal Analysis**: Load and analyze user-provided .wav files

## Files & Components

### Core Functions

#### `get_spectrum.m`
Computes the single-sided amplitude spectrum of a signal.
- **Purpose**: Calculates the magnitude of positive frequency components via FFT
- **Inputs**: 
  - `x`: Signal data
  - `N`: Number of FFT points
- **Output**: Single-sided magnitude spectrum with energy conservation
- **Key Feature**: Multiplies non-DC and non-Nyquist components by 2 to account for discarded negative frequencies

#### `plot_dual.m`
Generates side-by-side time and frequency domain visualizations.
- **Purpose**: Creates publication-quality subplot figures for waveform analysis
- **Inputs**:
  - `t`: Time vector
  - `x`: Signal data
  - `fs`: Sampling frequency (Hz)
  - `name`: Title string for time-domain plot
- **Outputs**: 
  - Left subplot: Time-domain waveform
  - Right subplot: Magnitude spectrum (stem plot)

#### `synthesize.m`
Performs additive Fourier synthesis using a coefficient vector.
- **Purpose**: Reconstructs waveforms from harmonic coefficients
- **Inputs**:
  - `f0`: Fundamental frequency (Hz)
  - `fs`: Sampling frequency (Hz)
  - `T`: Signal duration (seconds)
  - `c`: Coefficient vector where c(n) is the amplitude of the nth harmonic
- **Output**: Synthesized time-domain signal
- **Formula**: x(t) = Σ c_n sin(2πnf₀t)

### Main Scripts

#### `synth.m` (Run First)
**Master script** that synthesizes LFO waveforms and demonstrates all analysis capabilities.

**Key Parameters**:
- `fs = 10000 Hz`: Sampling frequency
- `T = 1 s`: Signal duration
- `f0 = 2 Hz`: LFO frequency for visualization (kept low for clarity)
- `N_harmonics = 50`: Number of harmonics to sum
- `f0_audio = 220 Hz`: A3 note frequency for audio demos

**Features**:
1. **Fourier Series Synthesis**: Builds four classic waveforms from mathematical definitions
   - **Square Wave**: Odd harmonics only (1/n amplitude falloff)
   - **Sawtooth Wave**: All harmonics (1/n amplitude falloff)
   - **Triangle Wave**: Odd harmonics only (1/n² amplitude falloff with alternating signs)
   - **Sine Wave**: Pure fundamental (no harmonics)

2. **Stacked Time-Domain Visualization**: 4-subplot figure showing all waveforms at LFO frequency

3. **Dual-Panel Analysis**: Four figures with time domain + frequency spectrum for each waveform

4. **Harmonic Editor Demonstration**: Uses `synthesize.m` to reconstruct square wave from explicit coefficient vector

5. **Audio Output**: Real-time `sound()` playback at audible frequency (A3 = 220 Hz)
   - Square wave: Buzzy, harsh tone (strong odd harmonics)
   - Triangle wave: Soft, mellow tone (1/n² harmonic decay)

6. **3D Waterfall Plot**: Compares harmonic spectra across all four waveforms
   - X-axis: Frequency (Hz, limited to 0-60 Hz)
   - Y-axis: Waveform type (Sine, Triangle, Sawtooth, Square)
   - Z-axis: Amplitude

7. **Interactive Custom Audio Analysis**:
   - Prompts user to load a .wav file
   - Resamples to match project sampling rate (10 kHz)
   - Trims/pads to match signal length
   - Normalizes and adds to waterfall visualization
   - Extended frequency range (0-500 Hz) for user audio

#### `sine_shaper.m`
**Optimization script** for non-linear waveshaping analysis.

**Purpose**: Finds the optimal tanh-based gain parameter (k) that minimizes Total Harmonic Distortion (THD) when converting a triangle wave into a low-distortion sine wave.

**Key Parameters**:
- `k_range = 0.1 : 0.1 : 10`: Gain parameter search range
- `k_opt = 1.4`: Optimal gain value (demonstration)

**Transfer Function**: 
```
y = tanh(k × x) / tanh(k)
```

**Algorithm**:
1. Applies non-linear tanh shaping to triangle wave for each k value
2. Computes FFT spectrum
3. Identifies fundamental frequency and harmonic bins
4. Calculates THD: √(Σ harmonics²) / fundamental
5. Plots THD vs. gain parameter to identify optimal k

**Outputs**:
1. Line plot: THD vs. Gain Parameter (k)
2. Figure demonstrating optimal shaper output at k = 1.4 using `plot_dual()`

**Note**: Requires `x_tri`, `t`, and `fs` from `synth.m` to be pre-computed (run `synth.m` first)

## Usage Instructions

### Basic Workflow

1. **Run the main synthesis script first**:
   ```matlab
   synth
   ```
   This generates all four waveforms and creates multiple visualizations.

2. **Analyze custom audio** (when prompted):
   - Place your .wav file in the MATLAB working directory
   - Enter the filename when prompted
   - Script automatically resamples and adds to waterfall comparison

3. **Optimize waveshaper (optional)**:
   ```matlab
   sine_shaper
   ```
   Requires `synth.m` to have run first (uses `x_tri`, `t`, `fs` from workspace).

### Creating Custom Waveforms

To synthesize your own waveform, define a coefficient vector and call `synthesize()`:

```matlab
% Example: Create a custom waveform with specific harmonics
my_coefficients = zeros(1, 50);
my_coefficients(1) = 1.0;      % Fundamental
my_coefficients(3) = 0.3;      % 3rd harmonic
my_coefficients(5) = 0.1;      % 5th harmonic

x_custom = synthesize(220, 10000, 1, my_coefficients);
```

## Technical Specifications

### Signal Processing
- **FFT Analysis**: Single-sided spectrum computation with proper energy normalization
- **Time Vector**: T × fs samples, no endpoint overlap (0 : 1/fs : T - 1/fs)
- **Spectral Normalization**: Division by N (FFT points) with ×2 factor for positive frequencies

### Audio Processing
- **Sampling Rate**: 10 kHz (standard for LFO analysis; audio demos resynthesized at 220 Hz)
- **Bit Depth**: Default MATLAB precision (double-precision floating-point)
- **Resampling**: Custom audio files automatically resampled to 10 kHz

### Mathematical Foundations

**Fourier Series Normalizations**:
- Square wave: (4/π) × Σ(sin(n2πf₀t)/n) for odd n
- Sawtooth wave: (2/π) × Σ(sin(n2πf₀t)/n) for all n
- Triangle wave: (8/π²) × Σ((-1)^k sin(n2πf₀t)/n²) for odd n

## Features Checklist

- ✅ Fourier series synthesis of classic waveforms
- ✅ Single-sided amplitude spectrum computation
- ✅ Time-domain and frequency-domain visualization
- ✅ 3D waterfall spectral comparison
- ✅ Non-linear tanh waveshaper optimization
- ✅ THD (Total Harmonic Distortion) analysis
- ✅ Real-time audio playback at audible frequencies
- ✅ Interactive custom audio file analysis
- ✅ Additive synthesis with arbitrary coefficient vectors
- ✅ Harmonic editor demonstration

## Output Visualizations

This section contains screenshots of the key output plots generated by the scripts.

### Figure 1: Stacked Time-Domain Waveforms
Generated by `synth.m` - Shows all four waveforms at LFO frequency (2 Hz) in a 4×1 subplot layout.

![Stacked Time-Domain Waveforms](screenshots/01_stacked_waveforms.png)

**Description**: 
- Subplot 1: Square wave with sharp transitions
- Subplot 2: Sawtooth wave with linear rise and sharp fall
- Subplot 3: Triangle wave with symmetric linear slopes
- Subplot 4: Pure sine wave (smooth oscillation)

---

### Figure 2: Square Wave Analysis
Generated by `plot_dual()` call in `synth.m` - Time domain (left) and magnitude spectrum (right).

![Square Wave Time and Frequency Domain](screenshots/02_square_wave_dual.png)

**Description**: 
- Left: Square wave time-domain signal showing sharp edges
- Right: Magnitude spectrum showing odd harmonics (1, 3, 5, 7...) with 1/n amplitude decay

---

### Figure 3: Sawtooth Wave Analysis
Generated by `plot_dual()` call in `synth.m` - Time domain (left) and magnitude spectrum (right).

![Sawtooth Wave Time and Frequency Domain](screenshots/03_sawtooth_wave_dual.png)

**Description**: 
- Left: Sawtooth wave time-domain signal with linear rise and sharp reset
- Right: Magnitude spectrum showing all harmonics with 1/n amplitude falloff

---

### Figure 4: Triangle Wave Analysis
Generated by `plot_dual()` call in `synth.m` - Time domain (left) and magnitude spectrum (right).

![Triangle Wave Time and Frequency Domain](screenshots/04_triangle_wave_dual.png)

**Description**: 
- Left: Triangle wave time-domain signal with symmetric slopes
- Right: Magnitude spectrum showing odd harmonics with 1/n² amplitude decay (softer content)

---

### Figure 5: Sine Wave Analysis
Generated by `plot_dual()` call in `synth.m` - Time domain (left) and magnitude spectrum (right).

![Sine Wave Time and Frequency Domain](screenshots/05_sine_wave_dual.png)

**Description**: 
- Left: Pure sine wave (fundamental frequency only)
- Right: Magnitude spectrum showing single peak at fundamental frequency (no harmonics)

---

### Figure 6: Square Wave via Synthesize
Generated by `synthesize.m` with explicit coefficient vector - Demonstrates harmonic editor functionality.

![Square Wave via Synthesize](screenshots/06_square_synthesize_dual.png)

**Description**: 
- Verifies that `synthesize.m` reproduces square wave exactly using coefficient vector approach
- Left: Time-domain reconstruction from Fourier coefficients
- Right: Magnitude spectrum matching Figure 2

---

### Figure 7: 3D Waterfall Spectrum Comparison
Generated by `synth.m` - Compares harmonic content across all four waveforms.

![3D Waterfall Spectrum](screenshots/07_waterfall_all_waveforms.png)

**Description**: 
- X-axis: Frequency (0-60 Hz)
- Y-axis: Waveform type (1: Sine, 2: Triangle, 3: Sawtooth, 4: Square)
- Z-axis: Amplitude
- Cool colormap gradient shows spectral richness
- Key insight: Square wave has strongest harmonics, sine wave has none

---

### Figure 8: Custom Audio Waterfall (Optional)
Generated by `synth.m` interactive section - User-provided .wav file added to comparison.

![3D Waterfall with Custom Audio](screenshots/08_waterfall_with_custom_audio.png)

**Description**: 
- X-axis: Frequency (0-500 Hz, extended range)
- Y-axis: Waveform type (1: Sine, 2: Triangle, 3: Sawtooth, 4: Square, 5: Your file)
- Z-axis: Amplitude (normalized)
- Allows direct comparison of custom audio against synthesized waveforms

---

### Figure 9: THD Optimization Curve
Generated by `sine_shaper.m` - Shows Total Harmonic Distortion vs. gain parameter (k).

![THD vs Gain Parameter](screenshots/09_thd_optimization.png)

**Description**: 
- X-axis: Gain parameter (k) ranging from 0.1 to 10
- Y-axis: THD (Total Harmonic Distortion) percentage
- Curve shows optimal gain value for minimum distortion
- Minimum typically occurs around k = 1.4
- Demonstrates non-linear waveshaper optimization

---

### Figure 10: Optimal Shaper Output (k = 1.4)
Generated by `sine_shaper.m` - Shows optimal waveshaper result with minimum THD.

![Optimal Tanh Waveshaper Output](screenshots/10_optimal_shaper_dual.png)

**Description**: 
- Left: Triangle wave after tanh shaping at k = 1.4 (converted to low-distortion approximation of sine)
- Right: Magnitude spectrum showing reduced harmonic content compared to raw triangle wave
- Demonstrates effectiveness of non-linear waveshaping for waveform conversion

---

## Screenshot Organization Guide

Create a folder named `screenshots/` in your project directory and organize images as follows:

```
project_root/
├── synth.m
├── sine_shaper.m
├── get_spectrum.m
├── plot_dual.m
├── synthesize.m
├── README.md
└── screenshots/
    ├── 01_stacked_waveforms.png
    ├── 02_square_wave_dual.png
    ├── 03_sawtooth_wave_dual.png
    ├── 04_triangle_wave_dual.png
    ├── 05_sine_wave_dual.png
    ├── 06_square_synthesize_dual.png
    ├── 07_waterfall_all_waveforms.png
    ├── 08_waterfall_with_custom_audio.png
    ├── 09_thd_optimization.png
    └── 10_optimal_shaper_dual.png
```

## How to Capture Screenshots

1. **Run `synth.m`**:
   - Each `figure` command creates a new window
   - Use MATLAB's built-in screenshot tool: **File > Export As**
   - Save as PNG with high resolution (150-300 DPI)

2. **Run `sine_shaper.m`**:
   - First figure: THD optimization curve
   - Second figure: Optimal shaper output at k = 1.4
   - Export using same method

3. **Save to `screenshots/` folder**:
   - Use consistent naming convention (01_, 02_, etc.)
   - Keep filenames descriptive and lowercase with underscores

## Dependencies

- **MATLAB** (tested on R2020b and later)
- **Signal Processing Toolbox** (for `fft`, `resample` if using custom audio)
- **Audio I/O capability** (for `sound()` playback and `audioread()`)

## Example Outputs

The project generates:
1. **1 stacked time-domain figure** (4 waveforms in synth.m)
2. **5 dual-panel figures** (time + spectrum for each waveform, plus synthesize demo)
3. **2 waterfall plots** (base comparison, optional user audio)
4. **2 waveshaper plots** (THD curve + optimal output)
5. **Audio playback** (square and triangle waves at A3)

**Total: 10+ figures with accompanying audio demonstrations**

## Future Enhancement Ideas

- GPU acceleration for large FFT computations
- Advanced waveshaper designs (soft-clipping, polynomial shaping)
- Real-time parameter sweeping with animation
- Frequency response analysis (Bode plots)
- Multi-band THD measurement
- Export synthesized waveforms as .wav files

## Author Notes

This project demonstrates fundamental signal processing concepts:
- Fourier analysis and synthesis
- Spectral visualization techniques
- Non-linear system optimization
- Harmonic analysis and THD measurement
- DSP best practices (proper normalization, aliasing prevention)

---

**Version**: 1.0  
**Last Updated**: 2026-04-14  
**Created for**: Signal Processing & Harmonic Analysis Education
