clear all
close all
clc

%% INIT
dq1 = daq("ni");
flush(dq1);
% DAQ Settings
dq1.Rate = 1e3;

%% Analog Input NI 9221
chA1I0 = addinput(dq1,"cDAQ1Mod1","ai0","Voltage");
% Channel re-naming
chA1I0.Name = 'FlowExt';

%% Encoder NI 9401
chEnc = addinput(dq1,"cDAQ1Mod5",'ctr0','Position'); 
%chEnc = addinput(dq1,"cDAQ1Mod5",'ctr0','EdgeCount'); 
chEnc.Name = 'Encoder';

start(dq1,'Duration',seconds(10))
data1 = read(dq1,seconds(10));

stop(dq1)

t = seconds(data1.Time);
enc = data1.Encoder;

%% Parameters
counterBits = 32;
resolution = 7.8125e-6;

%% Conversion
% Convert data unsigned to signed 
signedThreshold = 2^(counterBits - 1);
enc(enc>signedThreshold) = -(enc(enc > signedThreshold) - 2^counterBits);

plot(t,enc)