%% Process signals
% Description:
% 	Script contain basic signal process
% Content:
%	*
%
% Author: Artyom Voronin
% Brno, 2021
clc; clear all; close all;
addpath('../utils/');


data = load('data/identification_data.mat');

dt = 0.001;
min_time = 0;
max_time = 10;

data = resample_data(data, dt, min_time, max_time);

u = [data.i_u.Data];
y = [data.i_dx.Data];

z = iddata(y, u, dt, 'TimeUnit', 's');

Orders = [ones(1,1), 2*ones(1,1), ones(1,1)];
sys = nlarx(z, Orders);
sys2 = nlarx(z, Orders);
compare(z, sys, sys2);
