function [cPressureData] = Conversion_AirPressure(PressureData)
% This function converts the electrical signal to physical quantity for the
%% Pressure sensor: 
p1 = 6.25;
p2 = -2.5;

cPressureData = p1*PressureData + p2;
end

