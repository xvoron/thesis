
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
datastore.WriteToMemberFcn = @writeData;

clear loc_files ext_files path2data_converted
disp("Datastore import - done");
