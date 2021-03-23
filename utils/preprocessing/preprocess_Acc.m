function y = preprocess_Acc(x,tx)

Fs = 1/mean(diff(tx)); % Average sample rate
y = lowpass(x,280,Fs,'Steepness',0.9,'StopbandAttenuation',60);
