function [y,ty] = preprocess_position(x,tx)
%  Preprocess input x
%    This function expects an input vector x and a vector of time values
%    tx. tx is a numeric vector in units of seconds.
%    Follow the timetable documentation (type 'doc timetable' in
%    command line) to learn how to index into a table variable and its time
%    values so that you can pass them into this function.

% Generated by MATLAB(R) 9.7 and Signal Processing Toolbox 8.3.
% Generated on: 09-Mar-2021 21:26:06

%targetSampleRate = 500;
%[y,ty] = resample(x,tx,targetSampleRate);
y = x;
ty = tx;
y = smoothdata(y,'movmean',0.01,'SamplePoints',ty);