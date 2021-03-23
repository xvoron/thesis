function [pTable] = RawDataProcessing(dSource1, dSource2, dSource3,outSignal, FaultCode)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


%% Extract time vector
t1 = dSource1.Time;
t2 = dSource2.Time;
t3 = dSource3.Time;


%% Post-Processing

% Flow Sensors
cFlowExt = Conversion_Flow(dSource1.FlowExt);
cFlowShrink = Conversion_Flow(dSource1.FlowShrink);

% Pressure Sensor
cAirPressure = Conversion_AirPressure(dSource1.PressureSensor);

% Accelerometer
cAccZ = Conversion_Acc(dSource1.Accelerometer_Z);
cAccY = Conversion_Acc(dSource1.Accelerometer_Y);

% Strain Gauge
cStrainGauge = Conversion_StrainGauge(dSource1.StrainGauge);

% Proximity Sensors
proxSens_bottom = dSource1.ProxSensor_bottomPos;
proxSens_upper = dSource1.ProxSensor_upperPos;

% Encoder
cEncoder = Conversion_Enc(dSource1.Encoder);

% Microphone
Mic_uBumper = dSource2.Mic_upperBumper;
Mic_bBumper = dSource2.Mic_bottomBumper;
Mic_Ambient = dSource2.Mic_Ambient;

% Thermocouple

Temp_Cylinder = dSource3.Cylinder_Temperature;
Temp_Ambient = dSource3.Ambient_Temperature;

% Control Signal
outValveHP = outSignal(:,1);
outValveWP = outSignal(:,2);

%% Convert arrays of data to time-table

% Flow Sensors
cFlowExt_tt =  array2timetable(cFlowExt,'RowTimes',t1,'VariableNames',{'Data'});
cFlowShrink_tt =  array2timetable(cFlowShrink,'RowTimes',t1,'VariableNames',{'Data'});

% Pressure Sensor
cAirPressure_tt =  array2timetable(cAirPressure,'RowTimes',t1,'VariableNames',{'Data'});

% Accelerometer
cAccZ_tt =  array2timetable(cAccZ,'RowTimes',t1,'VariableNames',{'Data'});
cAccY_tt =  array2timetable(cAccY,'RowTimes',t1,'VariableNames',{'Data'});

% Strain Gauge
cStrainGauge_tt =  array2timetable(cStrainGauge,'RowTimes',t1,'VariableNames',{'Data'});

% Proximity Sensors
proxSens_bottom_tt =  array2timetable(proxSens_bottom,'RowTimes',t1,'VariableNames',{'Data'});
proxSens_upper = array2timetable(proxSens_upper,'RowTimes',t1,'VariableNames',{'Data'});

% Encoder
cEncoder_tt =  array2timetable(cEncoder,'RowTimes',t1,'VariableNames',{'Data'});

% Microphone
Mic_uBumper_tt=  array2timetable(Mic_uBumper,'RowTimes',t2,'VariableNames',{'Data'});
Mic_bBumper_tt = array2timetable(Mic_bBumper,'RowTimes',t2,'VariableNames',{'Data'});
Mic_Ambient_tt = array2timetable(Mic_Ambient,'RowTimes',t2,'VariableNames',{'Data'});

% Temperature 
Temp_Cylinder_tt = array2timetable(Temp_Cylinder,'RowTimes',t3,'VariableNames',{'Data'});
Temp_Ambient_tt = array2timetable(Temp_Ambient,'RowTimes',t3,'VariableNames',{'Data'});

% Control Output
outValveHP_tt = array2timetable(outValveHP,'RowTimes',t1,'VariableNames',{'Data'});
outValveWP_tt = array2timetable(outValveWP,'RowTimes',t1,'VariableNames',{'Data'});
%% Save data to table
pTable = table({cFlowExt_tt},{cFlowShrink_tt},{cAirPressure_tt},{cAccZ_tt},{cAccY_tt},{cStrainGauge_tt},...
{proxSens_bottom_tt},{proxSens_upper},{cEncoder_tt},{Mic_uBumper_tt},{Mic_bBumper_tt},{Mic_Ambient_tt},...
{Temp_Cylinder_tt}, {Temp_Ambient_tt},{outValveHP_tt},{outValveWP_tt},{FaultCode},'VariableNames',{'FlowExtrusion','FlowContraction','AirPressure',...
'Accelerometer_axisZ', 'Accelerometer_axisY','StrainGauge','ProximitySensor_bottom','ProximitySensor_upper','LeverPosition',...
'MIC_uBumper','MIC_bBumper','MIC_Ambient','Temp_Cylinder','Temp_Ambient','outValveHP','outValveWP','FaultCode'});

end

