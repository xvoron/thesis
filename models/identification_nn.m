clc;clear all;close all;
%run params.m;
%
data1 = load('data/data11_1_1.mat');
data2 = load('data/data11_1_2.mat');
data3 = load('data/data11_1_3.mat');

[f_code1,t1,i_in_u1_1,i_in_u1_2,i_out_x1,i_out_dx1,i_out_f1]=extract_signals4identification(data1);
[f_code2,t2,i_in_u2_1,i_in_u2_2,i_out_x2,i_out_dx2,i_out_f2]=extract_signals4identification(data2);
[f_code3,t3,i_in_u3_1,i_in_u3_2,i_out_x3,i_out_dx3,i_out_f3]=extract_signals4identification(data3);

clear data1 data2 data3

nn_u1_1 = nn_refactor(i_in_u1_1);
nn_u2_1 = nn_refactor(i_in_u2_1);
nn_u3_1 = nn_refactor(i_in_u3_1);

nn_u1_2 = nn_refactor(i_in_u1_2);
nn_u2_2 = nn_refactor(i_in_u2_2);
nn_u3_2 = nn_refactor(i_in_u3_2);

nn_x1 = nn_refactor(i_out_x1);
nn_x2 = nn_refactor(i_out_x2);
nn_x3 = nn_refactor(i_out_x3);

nn_dx1 = nn_refactor(i_out_dx1);
nn_dx2 = nn_refactor(i_out_dx2);
nn_dx3 = nn_refactor(i_out_dx3);

nn_f1 = nn_refactor(i_out_f1);
nn_f2 = nn_refactor(i_out_f2);
nn_f3 = nn_refactor(i_out_f3);

function data = nn_refactor(data)
    data = data(:,2);
end
