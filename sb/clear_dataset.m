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
    data = removevars(data, {'FlowExtrusion_ps_spec'});
    save(files(k).folder + "/" + files(k).name, 'data')
    clear data
    k
end
