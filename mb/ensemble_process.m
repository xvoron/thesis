% Import generation data script
%
% Author: Artyom Voronin
% Brno 2021
clc;clear all;close all
%% Loading dataset
location = fullfile(pwd, '../data/data_gen_mdl_air_leak');
ensemble = simulationEnsembleDatastore(location);

% Select Variables to work with

% Append data
%ensemble.DataVariables = [ensemble.DataVariables; "Cycle"];
% writeToLastMemberRead(ensemble, 'NewVariable', data);
ensemble.SelectedVariables = ["FlowContraction"; "Cycle"; "Label"];


% figure
% hold on
% reset(ensemble);
% while hasdata(ensemble)
%     data = read(ensemble);
%     x_data = data.FlowContraction{1,1};
%     plot(x_data.Time, x_data.Data)
%     disp(data.Cycle{1,1}.Data);
% end
% hold off
% title("Displacement data")

%%
if 0
% Append data
ensemble.DataVariables = [ensemble.DataVariables; "Label"];
% writeToLastMemberRead(ensemble, 'NewVariable', data);

reset(ensemble);
i = 1;
while hasdata(ensemble)
    data = read(ensemble);
    cycle = data.Cycle{1,1}.Data;
    writeToLastMemberRead(ensemble, "Label", cycle);
    i = i + 1;
end
end
