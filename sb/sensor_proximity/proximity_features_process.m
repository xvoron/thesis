function [featureTable,ranking,outputTable] = proximity_features_process(inputData)
%DIAGNOSTICFEATURES recreates results in Diagnostic Feature Designer.
%
% Input:
%  inputData: A table or a cell array of tables/matrices containing the
%  data as those imported into the app.
%
% Output:
%  featureTable: A table containing all features and condition variables.
%  ranking: A table containing ranking scores for selected features.
%  outputTable: A table containing the computation results.
%
% This function computes features:
%  ProximitySensor_bottom_stats/ClearanceFactor
%  ProximitySensor_bottom_stats/CrestFactor
%  ProximitySensor_bottom_stats/ImpulseFactor
%  ProximitySensor_bottom_stats/Kurtosis
%  ProximitySensor_bottom_stats/Mean
%  ProximitySensor_bottom_stats/PeakValue
%  ProximitySensor_bottom_stats/RMS
%  ProximitySensor_bottom_stats/SINAD
%  ProximitySensor_bottom_stats/SNR
%  ProximitySensor_bottom_stats/ShapeFactor
%  ProximitySensor_bottom_stats/Skewness
%  ProximitySensor_bottom_stats/Std
%  ProximitySensor_bottom_stats/THD
%  ProximitySensor_upper_stats/ClearanceFactor
%  ProximitySensor_upper_stats/CrestFactor
%  ProximitySensor_upper_stats/ImpulseFactor
%  ProximitySensor_upper_stats/Kurtosis
%  ProximitySensor_upper_stats/Mean
%  ProximitySensor_upper_stats/PeakValue
%  ProximitySensor_upper_stats/RMS
%  ProximitySensor_upper_stats/SINAD
%  ProximitySensor_upper_stats/SNR
%  ProximitySensor_upper_stats/ShapeFactor
%  ProximitySensor_upper_stats/Skewness
%  ProximitySensor_upper_stats/Std
%  ProximitySensor_upper_stats/THD
%
% This function ranks computed feautres using algorithms:
%  Kruskal-Wallis
%
% Organization of the function:
% 1. Compute signals/spectra/features
% 2. Extract computed features into a table
% 3. Rank features
%
% Modify the function to add or remove data processing, feature generation
% or ranking operations.

% Auto-generated by MATLAB on 03-May-2021 21:12:04

% Create output ensemble.
outputEnsemble = workspaceEnsemble(inputData,'DataVariables',["ProximitySensor_bottom_stats/ClearanceFactor";"ProximitySensor_bottom_stats/CrestFactor";"ProximitySensor_bottom_stats/ImpulseFactor";"ProximitySensor_bottom_stats/Kurtosis";"ProximitySensor_bottom_stats/Mean";"ProximitySensor_bottom_stats/PeakValue";"ProximitySensor_bottom_stats/RMS";"ProximitySensor_bottom_stats/SINAD";"ProximitySensor_bottom_stats/SNR";"ProximitySensor_bottom_stats/ShapeFactor";"ProximitySensor_bottom_stats/Skewness";"ProximitySensor_bottom_stats/Std";"ProximitySensor_bottom_stats/THD";"ProximitySensor_upper_stats/ClearanceFactor";"ProximitySensor_upper_stats/CrestFactor";"ProximitySensor_upper_stats/ImpulseFactor";"ProximitySensor_upper_stats/Kurtosis";"ProximitySensor_upper_stats/Mean";"ProximitySensor_upper_stats/PeakValue";"ProximitySensor_upper_stats/RMS";"ProximitySensor_upper_stats/SINAD";"ProximitySensor_upper_stats/SNR";"ProximitySensor_upper_stats/ShapeFactor";"ProximitySensor_upper_stats/Skewness";"ProximitySensor_upper_stats/Std";"ProximitySensor_upper_stats/THD"],'ConditionVariables',"Label");


% Gather all features into a table.
featureTable = readFeatureTable(outputEnsemble);

% Feature ranking for FeatureTable1
selectedFeatureNames = ["ProximitySensor_bottom_stats/ClearanceFactor","ProximitySensor_bottom_stats/CrestFactor","ProximitySensor_bottom_stats/ImpulseFactor","ProximitySensor_bottom_stats/Kurtosis","ProximitySensor_bottom_stats/Mean","ProximitySensor_bottom_stats/PeakValue","ProximitySensor_bottom_stats/RMS","ProximitySensor_bottom_stats/SINAD","ProximitySensor_bottom_stats/SNR","ProximitySensor_bottom_stats/ShapeFactor","ProximitySensor_bottom_stats/Skewness","ProximitySensor_bottom_stats/Std","ProximitySensor_bottom_stats/THD","ProximitySensor_upper_stats/ClearanceFactor","ProximitySensor_upper_stats/CrestFactor","ProximitySensor_upper_stats/ImpulseFactor","ProximitySensor_upper_stats/Kurtosis","ProximitySensor_upper_stats/Mean","ProximitySensor_upper_stats/PeakValue","ProximitySensor_upper_stats/RMS","ProximitySensor_upper_stats/SINAD","ProximitySensor_upper_stats/SNR","ProximitySensor_upper_stats/ShapeFactor","ProximitySensor_upper_stats/Skewness","ProximitySensor_upper_stats/Std","ProximitySensor_upper_stats/THD"];

% Get selected features and labels for classification ranking
selectedFeatureValues = featureTable{:,selectedFeatureNames};
label = featureTable{:,"Label"};

% Convert label to numeric values
if iscategorical(label)
    label = string(label);
end
group = grp2idx(label);

% Initialize an empty matrix to store ranking scores
score = zeros(numel(selectedFeatureNames),0);

% Initialize a string array to store ranking method names
methodList = strings(0);

%% Kruskal-Wallis
% Normalize features using minmax.
fNorm = (selectedFeatureValues-min(selectedFeatureValues,[],1))./(max(selectedFeatureValues,[],1)-min(selectedFeatureValues,[],1));

% Compute ranking score using Kruskal-Wallis.
numFeatures = size(fNorm,2);
z = zeros(numFeatures,1);
for k=1:numFeatures
    [~,tbl] = kruskalwallis(fNorm(:,k),group,'off');
    % Get test statistics from the Kruskal-Wallis test.
    stats = tbl{2,5};
    if ~isempty(stats)
        z(k) = stats;
    end
end

% Append new score and method name.
score = [score,z];
methodList = [methodList,"Kruskal-Wallis"];


%% Create ranking result table
featureColumn = table(selectedFeatureNames(:),'VariableNames',{'Features'});
ranking = [featureColumn array2table(score,'VariableNames',methodList)];
ranking = sortrows(ranking,'Kruskal-Wallis','descend');

% Set SelectedVariables to select variables to read from the ensemble.
outputEnsemble.SelectedVariables = unique([outputEnsemble.DataVariables;outputEnsemble.ConditionVariables;outputEnsemble.IndependentVariables],'stable');

% Gather results into a table.
outputTable = readall(outputEnsemble);
end