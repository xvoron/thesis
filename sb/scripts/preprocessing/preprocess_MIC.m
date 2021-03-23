function [y,ty] = preprocess_MIC(x,tx)
targetSampleRate = 1e+03;
[y,ty] = resample(x,tx,targetSampleRate);
Fs = 1/mean(diff(ty)); % Average sample rate
y = lowpass(y,30,Fs,'Steepness',0.85,'StopbandAttenuation',60);
y = detrend(y,'linear');
y = smoothdata(y,'movmean','SamplePoints',ty);
