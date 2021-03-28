clc; clear all; close all;
member = load('../data/data11/data11_1_1.mat');
names = member.data.Properties.VariableNames;

for i = 1:length(names)
    names_array(i) = string(names{1,i});
end


