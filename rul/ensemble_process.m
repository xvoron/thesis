% Import generation data script
%
% Author: Artyom Voronin
% Brno 2021
clc;clear all;close all
%% Loading dataset
location = fullfile(pwd, '../data/data_gen_mdl_equation_beta');
ensemble = simulationEnsembleDatastore(location);



% 
% % Select Variables to work with
% ensemble.DataVariables = ["LeverPosition"; ...
%     ];
%ensemble.IndependentVariables = ["Cycle"];
%append_time(ensemble);


%% Functions
function plot_ensemble(ensemble)
figure
hold on
reset(ensemble);
i = 1;
legendText = {};
while hasdata(ensemble)
    data = read(ensemble);
    x_data = data.LeverPosition{1,1};
    plot(x_data.Time, x_data.Data)
    legendText{i} = sprintf('cycle #%d', data.Cycle);
    legend(legendText);
    if i > 10
        break;
    else
        i = i+1;
    end
end

hold off
title("Displacement data")
end


function [] = append_time(ensemble)
ensemble.IndependentVariables = [ensemble.IndependentVariables; "Time"];
reset(ensemble);
while hasdata(ensemble)
    data = read(ensemble);
    writeToLastMemberRead(ensemble, "Time", data.Cycle{1,1}.Data);
end
end


function [] = verify_cycles(ensemble)
ensemble.SelectedVariables = ["Cycle"];

reset(ensemble);
while hasdata(ensemble)
    data = read(ensemble);
    disp(data.Cycle);
end

end
