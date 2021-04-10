% DATA GENERATION SCRIPT 
% Generate response data from the model. In further steps this dataset can
% be imported as data ensemble format.
% 
% Content:
%   1. Import parameters
%   2. Open model and config output path for data
%   3. Run simulations and save the data
%
% Author: Artyom Voronin
% Brno 2021
%%
bdclose all; clc; clear all; close all;
run ../models/params.m
disp('[INFO] Parameters were loaded');
%%
output_path = '../data/data_gen_mdl_equation_beta';
model = '../models/model_equation';
load_system(model);
open_system(model);
%open_system([model '/Mechanical system']);
runParallel = 0;
processParallel = 0;

%%
% Run using Parallel Computing Toolbox
if runParallel && isempty(gcp('nocreate'))
    parpool([2,6]);
end

% Parameters changing in the time. For system behavior simulation purposes.
beta_values = 0:10:1000;

for i = 1:numel(beta_values)
    tmp = Simulink.SimulationInput(model);
    tmp = setVariable(tmp, 'beta', beta_values(i));
    tmp = setVariable(tmp, 'cycle', i);
    simin(i) = tmp;
end

if ~exist(fullfile(pwd, output_path), 'dir')
    mkdir(fullfile(pwd, output_path))
end

[status,e] = generateSimulationEnsemble(simin, ...
    fullfile(pwd, output_path), 'UseParallel', runParallel);

if status
    disp("[INFO] Data was successfully generated")
else
    warning("Fault in data generation")
end
