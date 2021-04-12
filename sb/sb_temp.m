%% import dataensemble
% Description:
% 	Processing esemble dataset add labels
% Content:
%	
%
% Author: Artyom Voronin
% Brno, 2021

disp("Starting")
addpath('../utils/');

path2data_converted = '../data/data11/*.mat';
loc_files = fullfile(path2data_converted);
ext_files = ".mat";

% Create and configure Ensemble datastore
datastore = fileEnsembleDatastore(loc_files, ext_files);

datastore.ReadFcn = @readData;
datastore.WriteToMemberFcn = @writeData;


datastore.ConditionVariables = ["FaultCode"; ...
                                "Label"; ...
                                "ThrottleValve1"; ...
                                "ThrottleValve2"; ...
                                "SmallDamper_upper"; ...
                                "LargeDamper_upper"; ...
                                "SmallDamper_bottom"; ...
                                "LargeDamper_bottom";
                                "Settings.Load"];

datastore.IndependentVariables = [
                              "Temp_Cylinder"; ...
                              "Temp_Ambient"; ...
                                ];

datastore.SelectedVariables = ["Label"; ...
                              "Temp_Cylinder"; ...
                              "Temp_Ambient"; ...
                                
                                ];


clear loc_files ext_files path2data_converted
disp("Datastore import - done");


%% Plot Temperature

reset(datastore);
figure
hold on;
labels = [];
temp_cyls = [];
temp_ambs = [];
while hasdata(datastore)
    member = read(datastore);
    label = member.Label{1,1};
    temp_cylinder = member.Temp_Cylinder{1,1}.Data;
    temp_ambient = member.Temp_Ambient{1,1}.Data;
    
    labels = [labels; string(label)];
    temp_cyls = [temp_cyls; temp_cylinder];
    temp_ambs = [temp_ambs; temp_ambient];

    switch label
        case "health"
            plot(temp_cylinder, temp_ambient, 'r+')
        case "valve1"
            plot(temp_cylinder, temp_ambient, 'g+')
        case "valve2"
            plot(temp_cylinder, temp_ambient, 'b+')
        case "damp_small_bot"
            plot(temp_cylinder, temp_ambient, 'k+')
        case "damp_small_up"
            plot(temp_cylinder, temp_ambient, 'y+')
   end
    
end

hold off

temp_features = table(labels, temp_cyls, temp_ambs, 'VariableNames', {'Label', 'Temp_Cylinder', 'Temp_Ambient'});





















