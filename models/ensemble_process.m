% Import generation data script
%
% Author: Artyom Voronin
% Brno 2021
clc;clear all;close all
%% Loading dataset
location = fullfile(pwd, '../data/data_gen_mdl_equation');
ensemble = simulationEnsembleDatastore(location);

% Select Variables to work with
ensemble.SelectedVariables = ["x"];

% Append data
% ensemble.DataVariables = [ensemble.DataVartiables; "NewVariable"];
% writeToLastMemberRead(ensemble, 'NewVariable', data);

figure
hold on
reset(ensemble);
while hasdata(ensemble)
    data = read(ensemble);
    x_data = data.x{1};
    plot(x_data.Time, x_data.Data)
end
hold off
title("Displacement data")

