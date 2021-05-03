function [featureTable,ranking,outputTable] = strain_features_process(inputData)
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
%  StrainGauge_stats/ClearanceFactor
%  StrainGauge_stats/CrestFactor
%  StrainGauge_stats/ImpulseFactor
%  StrainGauge_stats/Kurtosis
%  StrainGauge_stats/Mean
%  StrainGauge_stats/PeakValue
%  StrainGauge_stats/RMS
%  StrainGauge_stats/SINAD
%  StrainGauge_stats/SNR
%  StrainGauge_stats/ShapeFactor
%  StrainGauge_stats/Skewness
%  StrainGauge_stats/Std
%  StrainGauge_stats/THD
%  StrainGauge_ps_spec/BandPower
%  StrainGauge_ps_spec/PeakAmp1
%  StrainGauge_ps_spec/PeakAmp10
%  StrainGauge_ps_spec/PeakAmp2
%  StrainGauge_ps_spec/PeakAmp3
%  StrainGauge_ps_spec/PeakAmp4
%  StrainGauge_ps_spec/PeakAmp5
%  StrainGauge_ps_spec/PeakAmp6
%  StrainGauge_ps_spec/PeakAmp7
%  StrainGauge_ps_spec/PeakAmp8
%  StrainGauge_ps_spec/PeakAmp9
%  StrainGauge_ps_spec/PeakFreq1
%  StrainGauge_ps_spec/PeakFreq10
%  StrainGauge_ps_spec/PeakFreq2
%  StrainGauge_ps_spec/PeakFreq3
%  StrainGauge_ps_spec/PeakFreq4
%  StrainGauge_ps_spec/PeakFreq5
%  StrainGauge_ps_spec/PeakFreq6
%  StrainGauge_ps_spec/PeakFreq7
%  StrainGauge_ps_spec/PeakFreq8
%  StrainGauge_ps_spec/PeakFreq9
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

% Auto-generated by MATLAB on 03-May-2021 21:32:44

% Create output ensemble.
outputEnsemble = workspaceEnsemble(inputData,'DataVariables',["StrainGauge_stats/ClearanceFactor";"StrainGauge_stats/CrestFactor";"StrainGauge_stats/ImpulseFactor";"StrainGauge_stats/Kurtosis";"StrainGauge_stats/Mean";"StrainGauge_stats/PeakValue";"StrainGauge_stats/RMS";"StrainGauge_stats/SINAD";"StrainGauge_stats/SNR";"StrainGauge_stats/ShapeFactor";"StrainGauge_stats/Skewness";"StrainGauge_stats/Std";"StrainGauge_stats/THD";"StrainGauge_ps_spec/BandPower";"StrainGauge_ps_spec/PeakAmp1";"StrainGauge_ps_spec/PeakAmp10";"StrainGauge_ps_spec/PeakAmp2";"StrainGauge_ps_spec/PeakAmp3";"StrainGauge_ps_spec/PeakAmp4";"StrainGauge_ps_spec/PeakAmp5";"StrainGauge_ps_spec/PeakAmp6";"StrainGauge_ps_spec/PeakAmp7";"StrainGauge_ps_spec/PeakAmp8";"StrainGauge_ps_spec/PeakAmp9";"StrainGauge_ps_spec/PeakFreq1";"StrainGauge_ps_spec/PeakFreq10";"StrainGauge_ps_spec/PeakFreq2";"StrainGauge_ps_spec/PeakFreq3";"StrainGauge_ps_spec/PeakFreq4";"StrainGauge_ps_spec/PeakFreq5";"StrainGauge_ps_spec/PeakFreq6";"StrainGauge_ps_spec/PeakFreq7";"StrainGauge_ps_spec/PeakFreq8";"StrainGauge_ps_spec/PeakFreq9"],'ConditionVariables',"Label");


% Gather all features into a table.
featureTable = readFeatureTable(outputEnsemble);

% Feature ranking for FeatureTable1
selectedFeatureNames = ["StrainGauge_stats/ClearanceFactor","StrainGauge_stats/CrestFactor","StrainGauge_stats/ImpulseFactor","StrainGauge_stats/Kurtosis","StrainGauge_stats/Mean","StrainGauge_stats/PeakValue","StrainGauge_stats/RMS","StrainGauge_stats/SINAD","StrainGauge_stats/SNR","StrainGauge_stats/ShapeFactor","StrainGauge_stats/Skewness","StrainGauge_stats/Std","StrainGauge_stats/THD","StrainGauge_ps_spec/BandPower","StrainGauge_ps_spec/PeakAmp1","StrainGauge_ps_spec/PeakAmp10","StrainGauge_ps_spec/PeakAmp2","StrainGauge_ps_spec/PeakAmp3","StrainGauge_ps_spec/PeakAmp4","StrainGauge_ps_spec/PeakAmp5","StrainGauge_ps_spec/PeakAmp6","StrainGauge_ps_spec/PeakAmp7","StrainGauge_ps_spec/PeakAmp8","StrainGauge_ps_spec/PeakAmp9","StrainGauge_ps_spec/PeakFreq1","StrainGauge_ps_spec/PeakFreq10","StrainGauge_ps_spec/PeakFreq2","StrainGauge_ps_spec/PeakFreq3","StrainGauge_ps_spec/PeakFreq4","StrainGauge_ps_spec/PeakFreq5","StrainGauge_ps_spec/PeakFreq6","StrainGauge_ps_spec/PeakFreq7","StrainGauge_ps_spec/PeakFreq8","StrainGauge_ps_spec/PeakFreq9"];

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

% Weight score by correlation importance.
z = correlationWeightedScore(fNorm,z,1);

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
