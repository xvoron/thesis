function [cPos] = Conversion_Enc(RawData)
% This function converts the electrical signal to physical quantity for the
%% Linear Encoder: RLS LA11 SQ C 08B B A 10D F 00

%% Parameters
counterBits = 32;
resolution = 7.8125e-6;

%% Conversion
% Convert data unsigned to signed 
signedThreshold = 2^(counterBits - 1);
RawData(RawData>signedThreshold) = -(RawData(RawData > signedThreshold) - 2^counterBits);

% Convert tick -> cm
cPos = RawData * resolution;

end

