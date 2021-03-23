% Model Based Predictive Maintenance
%            _                       
%  _ __ ___ | |__    _ __  _ __ ___  
% | '_ ` _ \| '_ \  | '_ \| '_ ` _ \ 
% | | | | | | |_) | | |_) | | | | | |
% |_| |_| |_|_.__/  | .__/|_| |_| |_|
%                   |_|              
% 
%
% Description:
% 
% Table of Content:
%   1.0 
%
% Author: Artyom Voronin
% Brno, 2021

clc; clear all; close all;
data = load('identification_data.mat');

data_res = resample_data(data, 0.001, data.i_x.Time(1), data.i_x.Time(end));


