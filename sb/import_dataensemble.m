%% import dataensemble
% Description:
% 	Processing esemble dataset add labels
% Content:
%	
%
% Author: Artyom Voronin
% Brno, 2021
clc; clear all; close all;

disp("Starting")
addpath('../utils/');
addpath('../utils/preprocessing/');

path2data_converted = '../data/data11/*.mat';
loc_files = fullfile(path2data_converted);
ext_files = ".mat";

% Create and configure Ensemble datastore
datastore = fileEnsembleDatastore(loc_files, ext_files);

datastore.ReadFcn = @readData;

datastore.DataVariables = ["FlowExtrusion"; ...  
                           "FlowExtrusion_stats"; ...  
                           "FlowExtrusion_ps"; ...  
                           "FlowExtrusion_ps_spec"; ...  
                           "FlowContraction"; ...
                           "FlowContraction_stats"; ...
                           "AirPressure"; ...
                           "AccelerometerMoving_axisY"; ...
                           "AccelerometerMoving_axisZ"; ...
                           "AccelerometerStatic_axisY"; ...
                           "AccelerometerStatic_axisZ"; ...                         
                           "StrainGauge"; ...
                           "ProximitySensor_bottom"; ... 
                           "ProximitySensor_upper"; ...
                           "LeverPosition"; ... 
                           "LeverPosition_stats"; ... 
                           "MIC_uBumper"; ... 
                           "MIC_bBumper"; ...
                           "MIC_Ambient"; ... 
                           "outValveHP"; ... 
                           "outValveWP";...
                           ];

datastore.ConditionVariables = ["FaultCode"; ...
                                "Label"; ...
                                "ThrottleValve1"; ...
                                "ThrottleValve2"; ...
                                "SmallDamper_upper"; ...
                                "LargeDamper_upper"; ...
                                "SmallDamper_bottom"; ...
                                "LargeDamper_bottom";
                                "Settings.Load"];

datastore.IndependentVariables = ["Temp_Cylinder"; ...
                                  "Temp_Ambient"; ...
                                  ];

datastore.SelectedVariables = ["Label"; ...
                               "FlowExtrusion"; ... 
                               "FlowExtrusion_stats"; ... 
                               "FlowExtrusion_ps"; ...  
                               "FlowExtrusion_ps_spec"; ...  
                               "FlowContraction"; ...
                               "FlowContraction_stats"; ...
                               "AirPressure"; ...
                               "AccelerometerMoving_axisY"; ...
                               "AccelerometerMoving_axisZ"; ...
                               "AccelerometerStatic_axisY"; ...
                               "AccelerometerStatic_axisZ"; ...                         
                               "StrainGauge"; ...
                               "ProximitySensor_bottom"; ... 
                               "ProximitySensor_upper"; ...
                               "LeverPosition"; ...                               
                               "LeverPosition_stats"; ... 
                               "MIC_uBumper"; ... 
                               "MIC_bBumper"; ...
                               "MIC_Ambient"; ...
                                ];


datastore.WriteToMemberFcn = @writeData;
clear loc_files ext_files path2data_converted
disp("Datastore import - done");