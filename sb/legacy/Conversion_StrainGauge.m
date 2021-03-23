function [cGaugeData] = Conversion_StrainGauge(GaugeData)
% This function converts the electrical signal to physical quantity for the
%% Flow sensor: 8524-6020-S000S500

measRange = 2e3; %N
voltageRange = 10; %V
convCoefficient = measRange/voltageRange;

cGaugeData = convCoefficient*GaugeData;
end

