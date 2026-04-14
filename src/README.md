# Source Code Structure Documentation

## Overview
This README provides an overview of the source code structure for the LFO Synthesis Harmonic Analyzer project, detailing the functionalities of the MATLAB files included in the repository.

## Source Code Structure
The project includes the following primary MATLAB files:

1. **synth.m**:  
   - **Purpose**: This is the main synthesis function that orchestrates the overall synthesis process. It initializes parameters, triggers the synthesis algorithm, and calls other necessary functions.  
   - **Execution Order**: Run this file first to begin the synthesis process.

2. **sine_shaper.m**:  
   - **Purpose**: This function transforms the raw signals into sine waves, shaping them according to the parameters specified in the `synth.m` file.  
   - **Execution Order**: Called by `synth.m` to prepare the shaped waves for further processing.

3. **get_spectrum.m**:  
   - **Purpose**: Computes the frequency spectrum of the synthesized signal, facilitating analysis of its frequency components.  
   - **Execution Order**: Invoked within `synth.m` after the shaping process to analyze the shaped signals.

4. **plot_dual.m**:  
   - **Purpose**: Visualizes the synthesized signals and their frequency spectrum in a dual plot layout for clearer analysis.  
   - **Execution Order**: Called in `synth.m` after `get_spectrum.m` to provide visual feedback of the synthesis results.

5. **synthesize.m**:  
   - **Purpose**: This helper function focuses on the actual synthesis of the waveforms based on provided parameters and settings. It serves as a dedicated computation segment within the overall process.  
   - **Execution Order**: Used within `synth.m` as part of the synthesis workflow.

## Execution Order Summary
The typical execution order of the files is as follows:
1. `synth.m` 
   - Calls `sine_shaper.m` 
   - Calls `synthesize.m` 
   - Calls `get_spectrum.m` 
   - Calls `plot_dual.m`

By following this execution order, users can ensure they effectively navigate the functionalities of the LFO Synthesis Harmonic Analyzer code.