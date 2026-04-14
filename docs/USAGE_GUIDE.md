# Usage Guide

This guide provides step-by-step instructions on how to use the scripts in the `LFO-Synthesis-Harmonic-Analyzer` repository: `synth.m`, `sine_shaper.m`, and `synthesize.m` for creating custom waveforms.

## Running `synth.m`

1. **Open terminal** and navigate to the directory where the `synth.m` file is located.
   ```bash
   cd path/to/LFO-Synthesis-Harmonic-Analyzer
   ```

2. **Run the script** by typing the following command:
   ```matlab
   synth
   ```
   - This will initiate the synthesis process and you can follow any prompts shown in the command window.

## Running `sine_shaper.m`

1. **Ensure you are in the correct directory** where `sine_shaper.m` is located.
2. Call the script in MATLAB:
   ```matlab
   sine_shaper
   ```
   - Adjust parameters as needed depending on the specific configurations you are working with.

## Creating Custom Waveforms with `synthesize.m`

1. **Prepare your parameters.** Before running the script, define the frequency, amplitude, and duration for your waveform.
   ```matlab
   frequency = 440;  % Frequency in Hz
   amplitude = 1;    % Peak amplitude
   duration = 2;     % Duration in seconds
   ```

2. **Call the `synthesize` function: **
   ```matlab
   synthesized_waveform = synthesize(frequency, amplitude, duration);
   ```

3. **Play the waveform** to listen to your custom sound:
   ```matlab
   sound(synthesized_waveform, 44100);
   ```

4. **Plot the waveform** to visualize it:
   ```matlab
   plot(synthesized_waveform);
   title('Custom Waveform');
   xlabel('Sample');
   ylabel('Amplitude');
   ```

## Conclusion

Utilize the above scripts to enhance your sound synthesis and create unique audio experiences there in `LFO-Synthesis-Harmonic-Analyzer`. For more information, refer to the repository documentation or contact the authors directly if you have further questions.