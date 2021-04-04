clc;clear all;close all;
addpath('../utils/');
addpath('../');
%run params.m;
data1 = load('data/data11_1_1.mat');


[f_code1,t,i_in_u1_1,i_in_u1_2,i_out_x1,i_out_dx1,i_out_f1]=extract_signals4identification(data1);

u1 = i_in_u1_1(:,2);
u2 = i_in_u1_2(:,2);

i_u = u2 - u1;
x = i_out_x1(:,2);
clear data1
Ts = 1e-3;

data_x = iddata(x, i_u, Ts);

figure
plot(data_x)

opt = oeOptions('Focus','simulation');
LinearModel = oe(data_x,[3 2 2],opt);
compare(data_x, LinearModel)
getpvec(LinearModel)
NonlinearModel = nlhw(data_x, LinearModel, [], 'saturation');
compare(data_x, NonlinearModel)

polydata(NonlinearModel.LinearModel)
getpvec(NonlinearModel.LinearModel)
getcov(NonlinearModel.LinearModel)

%% 
dx = i_out_dx1(:,2);
data_dx = iddata(dx, i_u, Ts);

figure
plot(data_dx)

opt = oeOptions('Focus','simulation');
LinearModel = oe(data_dx,[3 2 2],opt);
compare(data_dx, LinearModel)

NonlinearModel = nlhw(data_dx, LinearModel, [], 'saturation');
compare(data_dx, NonlinearModel)


