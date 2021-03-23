%title Signal preprocessing for PM

= Contents =
    - [[#Basic preprocessing|Basic preprocessing]]
    - [[#Filtering|Filtering]]
    - [[#Time-Domain|Time-Domain]]
        - [[#Time-Domain#Nonlinear features|Nonlinear features]]
    - [[#Frequency-Domain|Frequency-Domain]]
    - [[#Time-Frequency|Time-Frequency]]
        - [[#Time-Frequency#Time-Frequency Moments|Time-Frequency Moments]]

= Basic preprocessing =
- Data cleaning: *fillmissing*, *filloutliers*
- Smoothing data: *smoothdata*, *movmean*
- Detrend: *detrend*
- Scaling, normalizing: *rescale*
- Discard some parts of the signal

more: Preprocessing Data

= Filtering =
- *filter*, *designfilt*
- Wavelet Toolbox
- *emd* ??

= Time-Domain =
- *tsa*: remove noise, good for vibration data
- *tsadifference*: remove the regular signal from time-synchronous averaged
  signal.
- *tsaregular*: isolate the knowing signal
- *ordertrack*: use order analysis
- *rpmtrack*: RPM profile from vibration signal
- *envspectrum*: compute an envelope spectrum
- *skewness*: ?? threshold values
- *kurtosis*: ?? 
- *peak2peak*: difference between maximum an minimum values
- *envelope*: signal envelope (neco jako obalka)
- *dtw*: distance between 2 signals
- *rainflow*: ???

== Nonlinear features ==
- *lyapunovExponent*: rate of separation of nearby phase-space
  trajectories
- *approximateEntropy*: amount of regularity or irregularity in signal
- *correlationDimention*: measure of the dimensionality of the phase space
  occupied by the signal

All this computation relies on the *phaseSpaceReconstruction* function.

= Frequency-Domain =

- *pspectrum*: power spectrum might be useful for vibration.
{{{matlab
acc_data = data.acc{1};
[pdata, fpdata] = pspectrum(acc_data, ???);
pdata = 10*log10(pdata);    % Convert to dB
}}}

- *envspectrum*: compute an envelope spectrum
- *orderspectrum*: compute an average order-magnitude spectrum
- *modalfrf*: estimate frequency response function of a signal
- *meanfreq*: mean frequency of the power spectrum of a signal
- *powerbw*: 3dB power bandwidth of a signal
- *findpeaks*: Values and location of local  maxima in a signal

more: Vibration Analysis


= Time-Frequency =
Frequency changing in time. Analyzing changing performance of the system !!!

- *spectogram*: compute the power spectrum using fft
- *hht*: Hilbert spectrum of a signal. (Mixture of signals) 
- *emd*: empirical mode decomposition. (separate a mixture of signals)
- *kurtogram*: compute time-localized spectral kurtosis. (have no idea what
  is it :)
- *pkurtosis*: Something with Gaussian noise.
- *pentropy*: spectral entropy

== Time-Frequency Moments ==
For non stationary signals (signals that change frequencies in time).
- *tfsmoment*: conditional spectral moment
- *tftmoment*: conditional temporal moment
- *tfmoment*: joint tf moment
- *instfreq*: instantaneous frequency as a function of time

