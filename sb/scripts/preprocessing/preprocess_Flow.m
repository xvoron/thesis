function y = preprocess_FlowExtusion(x,tx)
%  Preprocess input x
%    This function expects an input vector x and a vector of time values
%    tx. tx is a numeric vector in units of seconds.
%    Follow the timetable documentation (type 'doc timetable' in
%    command line) to learn how to index into a table variable and its time
%    values so that you can pass them into this function.

% Generated by MATLAB(R) 9.7 and Signal Processing Toolbox 8.3.
% Generated on: 21-Feb-2021 18:53:24

Fs = 1/mean(diff(tx)); % Average sample rate
y = lowpass(x,20,Fs,'Steepness',0.85,'StopbandAttenuation',60);
y = smoothdata(y,'movmean',0.01,'SamplePoints',tx);
