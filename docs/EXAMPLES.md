# Example Workflows for LFO Synthesis Harmonic Analyzer

## Basic Workflow
1. Clone the repository:  
   `git clone https://github.com/agam-89/LFO-Synthesis-Harmonic-Analyzer`

2. Navigate into the directory:  
   `cd LFO-Synthesis-Harmonic-Analyzer`

3. Initialize the analyzer with default settings:  
   `analyzer.init()`

4. Start the analysis:  
   `analyzer.start()`

5. View results in the terminal or output file.

## Custom Waveform Synthesis with Specific Harmonics
1. Define a custom waveform:  
   ```python
   custom_wave = analyzer.create_waveform(shape='sawtooth', harmonics=[1, 0.5, 0.25]) 
   ```

2. Set the frequency and amplitude:  
   ```python
   custom_wave.set_frequency(440)  # 440 Hz
   custom_wave.set_amplitude(0.5)  
   ```

3. Start synthesis:  
   `custom_wave.synthesize()`

## Loading and Analyzing Custom .wav Files
1. Load a custom .wav file:  
   ```python
   analyzer.load_wave_file('path/to/your/file.wav')
   ```

2. Analyze the loaded file:  
   `analyzer.analyze()`

## Modifying Parameters
1. Access parameters:
   ```python
   params = analyzer.get_parameters()
   ```

2. Modify specific parameters:
   ```python
   params['sample_rate'] = 44100  # Change sample rate
   params['duration'] = 5.0  # Set duration to 5 seconds
   ```

3. Apply changes:  
   `analyzer.apply_parameters(params)`

---
These examples should help you get started with using the LFO Synthesis Harmonic Analyzer effectively.