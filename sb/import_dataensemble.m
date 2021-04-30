%% import dataensemble
% Description:
% 	Processing esemble dataset add labels
% Content:
%	
%
% Author: Artyom Voronin
% Brno, 2021

disp("Starting")
addpath('../utils/');
addpath('../utils/preprocessing/');

path2data_converted = '../data/data_full/*.mat';
loc_files = fullfile(path2data_converted);
ext_files = ".mat";

% Create and configure Ensemble datastore
datastore = fileEnsembleDatastore(loc_files, ext_files);

datastore.ReadFcn = @readData;

datastore.DataVariables = ["FlowExtrusion"; ...  
                           "FlowContraction"; ...
                           "AirPressure"; ...
                           "AccelerometerMoving_axisY"; ...
                           "AccelerometerMoving_axisZ"; ...
                           "AccelerometerStatic_axisY"; ...
                           "AccelerometerStatic_axisZ"; ...                         
                           "StrainGauge"; ...
                           "ProximitySensor_bottom"; ... 
                           "ProximitySensor_upper"; ...
                           "LeverPosition"; ...
                           "LeverVelocity"; ...
                           "MIC_uBumper"; ... 
                           "MIC_bBumper"; ...
                           "MIC_Ambient"; ... 
                           "outValveHP"; ... 
                           "outValveWP";...
                           ];

datastore.ConditionVariables = ["FaultCode"; ...
                                "Label"; ...
                                ];

datastore.IndependentVariables = ["Temp_Cylinder"; ...
                                  "Temp_Ambient"; ...
                                  "ThrottleValve1"; ...
                                  "ThrottleValve2"; ...
                                  "SmallDamper_upper"; ...
                                  "LargeDamper_upper"; ...
                                  "SmallDamper_bottom"; ...
                                  "LargeDamper_bottom";
                                  "Settings.Load"];

datastore.SelectedVariables = ["Label"; ...
                               "FaultCode"; ...
                               "FlowExtrusion"; ... 
                               "FlowContraction"; ...
                               "AirPressure"; ...
                               "AccelerometerMoving_axisY"; ...
                               "AccelerometerMoving_axisZ"; ...
                               "AccelerometerStatic_axisY"; ...
                               "AccelerometerStatic_axisZ"; ...                         
                               "StrainGauge"; ...
                               "ProximitySensor_bottom"; ... 
                               "ProximitySensor_upper"; ...
                               "LeverPosition"; ...
                               "LeverVelocity"; ...
                               "MIC_uBumper"; ... 
                               "MIC_bBumper"; ...
                               "MIC_Ambient"; ...
                               "ThrottleValve1"; ...
                               "ThrottleValve2"; ...
                               "SmallDamper_upper"; ...
                               "LargeDamper_upper"; ...
                               "SmallDamper_bottom"; ...
                               "LargeDamper_bottom";
                               "Settings.Load"; ...
                               "outValveHP"; ... 
                               "outValveWP";...
                                ];


datastore.WriteToMemberFcn = @writeData;
clear loc_files ext_files path2data_converted
disp("Datastore import - done");
