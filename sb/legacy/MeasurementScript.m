clear all
close all
clc

devices = daqlist;

%% INIT
dq1 = daq("ni");
dq2 = daq("ni");
dq3 = daq("ni");

flush(dq1);
flush(dq2);
flush(dq3);

% DAQ Settings
dq1.Rate = 1e3;
dq2.Rate = 40e3;
dq3.Rate = 1;

% Measurement Settings 
mDuration = 10; %seconds

% Lever motion
sOffset = 1; % start of the elevation in seconds
eTime = 5; % Time spent in upper position in seconds

%% Analog Input NI 9221
chA1I0 = addinput(dq1,"cDAQ1Mod1","ai0","Voltage");
chA1I1 = addinput(dq1,"cDAQ1Mod1","ai1","Voltage");
chA1I2 = addinput(dq1,"cDAQ1Mod1","ai2","Voltage");
chA1I3 = addinput(dq1,"cDAQ1Mod1","ai3","Voltage");
chA1I4 = addinput(dq1,"cDAQ1Mod1","ai4","Voltage");
chA1I5 = addinput(dq1,"cDAQ1Mod1","ai5","Voltage");

% Channel re-naming
chA1I0.Name = 'FlowExt';
chA1I1.Name = 'FlowShrink';
chA1I2.Name = 'PressureSensor';
chA1I3.Name = 'Accelerometer_Z';
chA1I4.Name = 'Accelerometer_Y';
chA1I5.Name = 'StrainGauge';

%% Analog Input NI 9215
chA2I1 = addinput(dq2,"cDAQ1Mod2","ai0","Voltage");
chA2I2 = addinput(dq2,"cDAQ1Mod2","ai1","Voltage");
chA2I3 = addinput(dq2,"cDAQ1Mod2","ai2","Voltage");

chA2I1.Name = 'Mic_upperBumper';
chA2I2.Name = 'Mic_bottomBumper';
chA2I3.Name = 'Mic_Ambient';


%% Digital Output NI 9474
chDO0 = addoutput(dq1,"cDAQ1Mod3","port0/line0","Digital");
chDO1 = addoutput(dq1,"cDAQ1Mod3","port0/line1","Digital");

%% Digital Input NI 9411
chDI0 = addinput(dq1,"cDAQ1Mod5","port0/line0","Digital");
chDI1 = addinput(dq1,"cDAQ1Mod5","port0/line1","Digital");
 
%Channel re-naming
chDI0.Name = 'ProxSensor_bottomPos';
chDI1.Name = 'ProxSensor_upperPos';
%% Encoder NI 9401
chEnc = addinput(dq1,"cDAQ1Mod4",'ctr0','Position'); 


chEnc.Name = 'Encoder';
chEnc.EncoderType = 'X4';

%% Thermocouple NI9219
chThc1 = addinput(dq3,"cDAQ1Mod6","ai0","Thermocouple"); %Cylinder Temperature
chThc2 = addinput(dq3,"cDAQ1Mod6","ai1","Thermocouple"); %Ambient Temperature

chThc1.Name = 'Cylinder_Temperature';
chThc1.ThermocoupleType = 'T';

chThc2.Name = 'Ambient_Temperature';
chThc2.ThermocoupleType = 'T';
%% External triggering

addtrigger(dq1,'Digital','StartTrigger','cDAQ1/PFI0','External');
addtrigger(dq2,'Digital','StartTrigger','External','cDAQ1/PFI0');

%% Measurement Parameters
clc
%Number of Measurements

N = input('Type in the number of cycles \n');
FaultCode = input('Type in the Faultcode \n');
for i = 1:N
% %     FaultCode = input('Type in the Faultcode \n');

fprintf('Fault code = %d, Cycle %d of %d. running...\n',FaultCode,i,N);

%% Run Measurement
    [data1,data2,data3,outData] = DaqMeasurement(dq1,dq2,dq3,mDuration,sOffset,eTime);

%% Measurement post-Processing
    pTable(i,:) = RawDataProcessing(data1,data2,data3,outData,FaultCode);
    %DisplayData(pTable);
    
end

% Data Save
disp('Measurement finished, saving...')
autoSaveData(pTable);
disp('///////////   DataSaved   /////////////////')