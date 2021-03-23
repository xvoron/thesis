clc;clear all;close all;
addpath('../utils/');
run params.m;
data1 = load('data/data11_1_1.mat');
data2 = load('data/data11_1_2.mat');
data3 = load('data/data11_1_3.mat');

[f_code1,i_in_u1,i_out_x1,i_out_dx1,i_out_f1]=extract_signals4identification(data1);
[f_code2,i_in_u2,i_out_x2,i_out_dx2,i_out_f2]=extract_signals4identification(data2);
[f_code3,i_in_u3,i_out_x3,i_out_dx3,i_out_f3]=extract_signals4identification(data3);

clear data1 data2 data3
