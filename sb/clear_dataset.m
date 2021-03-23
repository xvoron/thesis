%% dataesemble_process
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

path = '../data/data11/*.mat';

files = dir(path);

for k = 1:(numel(files))
    data = load(files(k).folder + "/" + string(files(k).name)).data;
    data = removevars(data, {'FlowExtrusion_stats_1'});
    save(files(k).folder + "/" + files(k).name, 'data')
    clear data
    k
end

%% Removing some stats variable:
% data.FlowExtusion_stats = removevars(data, {'Mean'});
% Remove candidats
%FlowExtrusion_stats/Std
%LeverPosition_stats/THD
%FlowExtrusion_stats/PeakValue
%FlowExtrusion_stats/RMS
%LeverPosition_stats/Skewness
%LeverPosition_stats/ShapeFactor
%LeverPosition_stats/SINAD
%LeverPosition_stats/RMS
%LeverPosition_stats/SNR
%FlowContraction_stats/ClearanceFactor
%FlowExtrusion_stats/ShapeFactor
%FlowContraction_stats/ShapeFactor
%FlowExtrusion_ps_spec/PeakAmp1
%LeverPosition_stats/CrestFactor
%LeverPosition_stats/ImpulseFactor
%FlowContraction_stats/SINAD
%LeverPosition_stats/Std
%LeverPosition_stats/Kurtosis
%LeverPosition_stats/ClearanceFactor
%FlowContraction_stats/ImpulseFactor
%FlowExtrusion_stats/CrestFactor
%FlowContraction_stats/Mean
%LeverPosition_stats/PeakValue
%FlowExtrusion_stats/Mean
%FlowContraction_stats/SNR
%FlowContraction_stats/THD
%FlowExtrusion_stats/Kurtosis
%FlowExtrusion_stats/ImpulseFactor
%FlowExtrusion_stats/ClearanceFactor
%FlowContraction_stats/Kurtosis
%FlowContraction_stats/Skewness
%FlowExtrusion_stats/Skewness
%FlowContraction_stats/CrestFactor
%FlowExtrusion_stats/THD
%FlowExtrusion_ps_spec/PeakFreq1

