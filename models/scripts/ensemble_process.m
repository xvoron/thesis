% Import generation data script
%
% Author: Artyom Voronin
% Brno 2021
clc;clear all;close all
%% Loading dataset
location = fullfile(pwd, '../data/data_gen_mdl_equation_beta');
ensemble = simulationEnsembleDatastore(location);

% Select Variables to work with

% Append data
%ensemble.DataVariables = [ensemble.DataVariables; "Cycle"];
% writeToLastMemberRead(ensemble, 'NewVariable', data);
ensemble.SelectedVariables = ["LeverPosition"; "Cycle"];


figure
hold on
reset(ensemble);
while hasdata(ensemble)
    data = read(ensemble);
    x_data = data.LeverPosition{1,1};
    plot(x_data.Time, x_data.Data)
    disp(data.Cycle);
end
hold off
title("Displacement data")

%%
if 0
% Append data
ensemble.DataVariables = [ensemble.DataVariables; "Cycle"];
% writeToLastMemberRead(ensemble, 'NewVariable', data);

reset(ensemble);
i = 1;
while hasdata(ensemble)
    data = read(ensemble);
    writeToLastMemberRead(ensemble, "Cycle", i);
    i = i + 1;
end
end
