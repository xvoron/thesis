function [cData] = Conversion_Acc(RawData)
% This function converts the electrical signal to physical quantity for the
%% 3-axis Accelerometer: 824-4030-006-120

% Accelerometer Parameters
ZeroOffset = 2.5; %V
Sensitivity = 333; %mv/g
g = 9.81;

cData = (RawData - ZeroOffset)*1000/Sensitivity;
end

