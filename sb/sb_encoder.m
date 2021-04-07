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

path2data_converted = '../data/data11/*.mat';
loc_files = fullfile(path2data_converted);
ext_files = ".mat";

% Create and configure Ensemble datastore
datastore = fileEnsembleDatastore(loc_files, ext_files);

datastore.ReadFcn = @readData;
datastore.WriteToMemberFcn = @writeData;

datastore.DataVariables = [
                           "LeverPosition"; ...
                           "LeverPosition_stats"; ...
                           "LeverPosition_nonlin"; ...
                           "LeverPosition_ps"; ...
                           "LeverPosition_ps_spec"; ...
                           "LeverVelocity"; ...
                           "LeverVelocity_ps"; ...
                           "LeverVelocity_ps_spec"; ...
                           "LeverVelocity_stats"; ...
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
                               "LeverPosition"; ...
                               "LeverPosition_stats"; ...
                               "LeverPosition_nonlin"; ...
                               "LeverPosition_ps"; ...
                               "LeverPosition_ps_spec"; ...
                               "LeverVelocity"; ...
                               "LeverVelocity_ps"; ...
                               "LeverVelocity_ps_spec"; ...
                               "LeverVelocity_stats"; ...
                                ];


clear loc_files ext_files path2data_converted
disp("Datastore import - done");