%title Signal based PM
:matlab:sbpm:pm:

= Contents =
    - [[#Matlab info|Matlab info]]
    - [[#Features|Features]]
        - [[#Features#matlab|matlab]]

= Preprocessing =
Preprocessing signals?
Preprocess signals but without fanatismus :)
[[../doc/notes/signal_process.md]]


= FaultCodes Notes =

XXX FaultCode: 1100818
SmallDamper_bottom = 8
Anomalie ve vrchnim damperu. Urcite to bude nejaky problem

* What to do with data?
- Nothing for that but it must be solved in near feature !


= Features =
Shape-factor = rms/mean

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



= Sensors =
- [[../doc/sensors/sensors]]: All sensors comparison table

== Microphones ==
Cheapest sensor
* [ ] Time domain:
* [ ] Frequency domain:
* [ ] Time-Frequency domain ???
=== Features ===

KW:
MIC_bBumper_stats/Mean
MIC_bBumper_stats/RMS
MIC_Ambient_stats/SINAD

ANOVA:
MIC_uBumper_stats/Mean
MIC_bBumper_stats/Mean
MIC_bBumper_stat/THD


== Position/Velocity ==
KW:
LeverVelocity_ps_spec/PeakAmp6
LeverVelocity_ps_spec/PeakAmp7
LeverVelocity_ps_spec/PeakAmp8
LeverVelocity_ps_spec/PeakAmp9
LeverVelocity_ps_spec/PeakFreq3





