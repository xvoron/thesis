function [data1,data2,data3,outData] = DaqMeasurement(dq1,dq2,dq3,mDuration,sOffset,eTime)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% Data preparation for valve control

vecLength = dq1.Rate*mDuration; 
sElevate = vecLength*sOffset/mDuration;
eElevate = vecLength*(sOffset + eTime)/mDuration;

%% 
outValveWP = zeros(vecLength,1);
outValveWP(sElevate:eElevate) = 1;

outValveHP = not(outValveWP);

outData = [outValveHP,outValveWP];
%% Data Aquisition
% 
start(dq2,'Duration',seconds(mDuration))
% start(dq2);

while ~dq2.WaitingForDigitalTrigger 
    pause(0.1)
end


% start(dq1,'Duration',seconds(mDuration))
start(dq1);
write(dq1,outData)

while dq1.Running || dq2.Running 
    pause(1)
end

data1 = read(dq1,seconds(mDuration));
data2 = read(dq2,seconds(mDuration));



% start(dq3)


stop(dq1)
stop(dq2)
% stop(dq3) 
data3 = read(dq3); %ps
end

