# FFT_MIDI_Visualizer
Generates two spinning squares whose RGB values are determined by a sum of MIDI input and multi-band FFT amplitude levels

The colors and brightness of these rectangles respond to a combination of frequency-band specific amplitude levels from Bass, Mid, and Treble bands, as well as Midi-input from CC channels 3 through 8. CC channels 3 through 5 control the R, G, and B values for the center rectangle, respectively. CC chanels 6 through 8 control the R, G, and B values for the encircling rectangle, respectively.

In order to make the rectangles audio-responsive, make sure to set your computer's audio input settings to whichever source will be receiving the audio. 
