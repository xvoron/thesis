clc; clear all; close all
disp("Starting")
%% Signal Based PM main script
%
% Content:
%   0. Convert data (optionally)
%   1. Import data and create Ensemble Datastore
%   2. Plot data example
%   3. Preprocess data
%       3.1 Preprocessed data example
%   4. Calculate statistic features
%       4.1 Rank features
%   5. Configure training dataset
%   6. Fit classification model
%
% Author: Artyom Voronin
% Brno, 2021
%% 0. Convert data (optionally)
cd ~/MT/sb/  % or cd pwd
addpath('../utils/');
path2data_raw = '../data/data_raw/*.mat';
tic
% reconvert_data(path2data_raw);  % prepare data to ensemble data format
clear path2data_raw
disp("Convert data - done");
toc
%% 1. Import data and create Ensemble Datastore
cd ~/MT/sb/  % or cd pwd
addpath('../utils/');
addpath('../utils/preprocessing/');

path2data_converted = '../data/data11/*.mat';
loc_files = fullfile(path2data_converted);
ext_files = ".mat";

% Create and configure Ensemble datastore
datastore = fileEnsembleDatastore(loc_files, ext_files);

datastore.ReadFcn = @readData;

datastore.DataVariables = ["FlowExtrusion"; ...  
                           "FlowExtrusion_stats"; ...  
                           "FlowContraction"; ...
                           "AirPressure"; ...
                           "AccelerometerMoving_axisY"; ...
                           "AccelerometerMoving_axisZ"; ...
                           "AccelerometerStatic_axisY"; ...
                           "AccelerometerStatic_axisZ"; ...                         
                           "StrainGauge"; ...
                           "ProximitySensor_bottom"; ... 
                           "ProximitySensor_upper"; ...
                           "LeverPosition"; ... 
                           "MIC_uBumper"; ... 
                           "MIC_bBumper"; ...
                           "MIC_Ambient"; ... 
                           "outValveHP"; ... 
                           "outValveWP";...
                           ];

datastore.ConditionVariables = ["FaultCode"; ...
                                "ThrottleValve1"; ...
                                "ThrottleValve2"; ...
                                "SmallDamper_upper"; ...
                                "LargeDamper_upper"; ...
                                "SmallDamper_bottom"; ...
                                "LargeDamper_bottom";
                                "Settings.Load"];

datastore.IndependentVariables = ["Temp_Cylinder"; ...
                                  "Temp_Ambient"; ...
                                  ];

datastore.SelectedVariables = ["FaultCode"; ...
                               "FlowExtrusion"; ... 
                               "FlowExtrusion_stats"; ... 
                               "FlowContraction"; ...
                               "AirPressure"; ...
                               "AccelerometerMoving_axisY"; ...
                               "AccelerometerMoving_axisZ"; ...
                               "AccelerometerStatic_axisY"; ...
                               "AccelerometerStatic_axisZ"; ...                         
                               "StrainGauge"; ...
                               "ProximitySensor_bottom"; ... 
                               "ProximitySensor_upper"; ...
                               "LeverPosition"; ...                               
                               "MIC_uBumper"; ... 
                               "MIC_bBumper"; ...
                               "MIC_Ambient"; ... 
                               "outValveHP"; ... 
                               "outValveWP"];


datastore.WriteToMemberFcn = @writeData;
clear loc_files ext_files path2data_converted
disp("Datastore import - done");
%% 2. Plot data example
% data_train = tall(data);
% Plot example data
% example data plot
reset(datastore);
data_example = read(datastore);
%data_plot(data_example);
%%
figure
hold on
reset(datastore);
while hasdata(datastore)
    member = read(datastore);
    position = member.LeverPosition{1};
    plot(position.Time, position.Data);
end
title('All lever position measured data');
xlabel('t [s]')
ylabel('d [m]')
grid on
hold off


%% 3. Preprocess Data
preprocessFlag = true;
runParallel = true;

if preprocessFlag
    tic
    reset(datastore);
    if runParallel
        n = numpartitions(datastore, gcp);
        parfor ct = 1:n
            subdatastore = partition(datastore, n, ct);
            while hasdata(subdatastore)
                member = read(subdatastore);
                add_data = data_preprocess(member);
                writeToLastMemberRead(subdatastore, add_data);
            end
        end
    else          
        while hasdata(datastore)
            member = read(datastore);
            add_data = data_preprocess(member);
            writeToLastMemberRead(datastore, add_data);
        end
    end
    disp("Preprocessing - done");
    toc
else
    disp("Signals have been preprocessed before"); 
end

%% 3.1 Preprocessed data example
if preprocessFlag
    reset(datastore);
    data_example_preprocessed = read(datastore);
    data_plot_preprocess_compaire(data_example, data_example_preprocessed);
end

clear preprocessFlag
%% 4. Calculate statistic features
% Calculation time: approx 30 min for whole dataset
calculateFlag = false;
runParallel = true;
datastore.SelectedVariables = ["FlowExtrusion"; "FlowContraction"; "AirPressure"; ...
"Accelerometer_axisZ"; "Accelerometer_axisY"; "StrainGauge"; "LeverPosition"];
%datastore.SelectedVariables = ["FlowExtrusion"; "AirPressure"];
feature_variables = append_DataVariables(datastore.SelectedVariables);
datastore.DataVariables = [datastore.DataVariables; feature_variables];
reset(datastore);

if calculateFlag
    tic
    if runParallel
        n = numpartitions(datastore, gcp);
        parfor ct = 1:n
            subdatastore = partition(datastore, n, ct);
            while hasdata(subdatastore)
                member = read(subdatastore);
                statistic_features = feature_extractor(member);
                subdatastore, features_names = add_features_to_datastore(subdatastore, statistic_features);
                writeToLastMemberRead(subdatastore, statistic_features);
            end
        end
        
    else  
        while hasdata(datastore)
            member = read(datastore);
            statistic_features = feature_extractor(member);
            datastore = add_features_to_datastore(datastore, statistic_features);
            writeToLastMemberRead(datastore, statistic_features);
            disp(string(progress(datastore)*100) + "% Done");
        end
    end
    disp("Calculate statistic features - done");
    toc
else
    disp("Statistic features have been calculated before")
end

clear runParallel n calculateFlag

%% 4.1 Rank features
% For rank features we will use Diagnostic Feature Desiger app
addpath('app_sessions/')
reset(datastore)
%datastore.SelectedVariables = [datastore.DataVariables; datastore.ConditionVariables];
diagnosticFeatureDesigner('feature_designer.mat')

%% 5. Configure training dataset
% First add selected features to main dataset table.
disp("Loading preconfigured feature table created by Feature Designer app");
feature_table = load('dataset/feature_table.mat').feature_table;

reset(datastore)
datastore.SelectedVariables = [datastore.DataVariables; datastore.ConditionVariables];
% reset(datastore);
% feature_table = generate_feature_table(datastore);

%% 6. Fit classification model
addpath('models/')

[trained_model, validationAccuracy] = train_kw_ranked_model(feature_table);
disp("Training done");
fprintf("Model validation accuracy is: %2.3f\n", validationAccuracy);
