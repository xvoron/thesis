%title Signal based PM
:matlab:sbpm:pm:

= Contents =
    - [[#Matlab info|Matlab info]]
    - [[#Features|Features]]
        - [[#Features#matlab|matlab]]

= Matlab info =
[[../fdi_pm/fdi_pm.md|FDI_PM]]

= Features =
1. Pressure mean
2. Pressure RMS
3. Proximity upper std
4. Strain gauge skewness
5. Lever position shape-factor


Shape-factor = rms/mean



= TODO =
* [ ] Preprocess all data


= matlab =

Usefull code:
{{{matlab
%Compute the FFT of the Time synchronous average of the vibration signal
dt = seconds(dt);
tp = seconds(data.TachoPulses{1});
vibrationTSA = tsa(y,tp);
np = numel(vibrationTSA);
f = fft(vibrationTSA.tsa.*hamming(np))/np;
frTSA = f(1:floor(np/2)+1);
wTSA = (0:np/2)/np*(2*pi/dt);
mTSA = abs(frTSA);

%Peak frequency
[~,idx] = max(mTSA);
PeakFreq = wTSA(idx);

%Power above 30Hz
HighFreqPower = sum(mTSA(wTSA > 30).^2);

%Envelope of TSA
M_env = envspectrum(vibrationTSA);

%Envelope power
EnvPower = sum(M_env.^2);

%Frequency with maximum spectral kurtosis
[~,~,~,fc] = kurtogram(y.Data,1/dt,8);
PeakSpecKurtosis = fc;
}}}


= Features =
One-way ANOVA:
| Feature                         | ANOVA    |
|---------------------------------|----------|
| FlowExtrusion_stats/SINAD       | 138.0057 |
| FlowExtrusion_stats/SNR         | 136.4267 |
| FlowContraction_stats/Std       | 118.4493 |
| FlowContraction_stats/RMS       | 117.5115 |
| FlowContraction_stats/PeakValue | 110.8327 |
| FlowExtrusion_ps_spec/BandPower | 106.7830 |
| LeverPosition_stats/Mean        | 105.6006 |

Kruskal-Wallis
| Feature                             | Kruskal-Wallis |
|-------------------------------------|----------------|
| LeverPosition_stats/THD             | 301.3332       |
| LeverPosition_stats/PeakValue       | 292.4824       |
| LeveFlowExtrusion_stats/SNR         | 239.3494       |
| LeveLeverPosition_stats/Skewness    | 239.3162       |
| LeveFlowExtrusion_stats/SINAD       | 239.2682       |
| LeveFlowExtrusion_ps_spec/BandPower | 235.9301       |
