function [cflowData] = Conversion_Flow(flowData)
% This function converts the electrical signal to physical quantity for the
%% Flow sensor: SMT-8m-A-PS-24V-E-0.3-M8D

max_VoltRange = 10; %V
max_FlowRange = 50; %l/min

cflowData = flowData*(max_FlowRange/max_VoltRange);

end

