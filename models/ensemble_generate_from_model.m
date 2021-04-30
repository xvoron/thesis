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
run params.m
disp('[INFO] Parameters were loaded');
%%
output_path = '../data/data_gen_mdl_air_leak';
model = 'model_equation_simply_valves';

generate_ensemble(model, output_path)
air_leak = 1;

function [] = generate_ensemble(model, output_path)

load_system(model);
open_system(model);
%open_system([model '/Mechanical system']);
runParallel = 0;
processParallel = 0;

% Run using Parallel Computing Toolbox
if runParallel && isempty(gcp('nocreate'))
    parpool([2,6]);
end

% Parameters changing in the time. For system behavior simulation purposes.
no_impact = linspace(1e-10, 1e-9, 10);
low_impact = linspace(1e-9, 1e-8, 10);
impact = linspace(1e-8, 1e-7, 20);
big_impact = linspace(1e-7, 1e-6, 30);

C_leak_values = [no_impact low_impact impact big_impact];


for i = 1:numel(C_leak_values)
    tmp = Simulink.SimulationInput(model);
    tmp = setVariable(tmp, 'C_leak', C_leak_values(i));
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

end
