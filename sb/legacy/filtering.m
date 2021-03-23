clear all
close all
clc

load('enc.mat')
resolution = 7.8125e-6;

cDist = enc * resolution*4*2;

subplot(2,1,1)
plot(cDist)
hold on

Fs = 1000;                            % Sampling Frequency (Hz)
Fn = Fs/2;                          % Nyquist Frequency (Hz)
Fco = 100;                            % Cutoff Frequency (Hz)
Wp = Fco/Fn;                        % Normalised Cutoff Frequency (rad)
Ws = 1.05*Wp;                        % Stopband Frequency (rad)
Rp =  1;                            % Passband Ripple (dB)
Rs = 3;                            % Stopband Ripple (dB)
[n,Wn]  = buttord(Wp,Ws,Rp,Rs);     % Calculate Filter Order
[b,a]   = butter(n,Wn);             % Calculate Filter Coefficients

fDist = filter(b,a,cDist);
plot(fDist)

dDist = diff(fDist)/(1/Fs)
subplot(2,1,2)
plot(dDist)
ylabel('v [m/s]')
xlabel('t [s]')

t = 0:0.001:10;
vec = [t(1:10000);cDist'];