function [featureTable,ranking,outputTable] = flow_features_process(inputData)
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
%  FlowContraction_stats/ClearanceFactor
%  FlowContraction_stats/CrestFactor
%  FlowContraction_stats/ImpulseFactor
%  FlowContraction_stats/Kurtosis
%  FlowContraction_stats/Mean
%  FlowContraction_stats/PeakValue
%  FlowContraction_stats/RMS
%  FlowContraction_stats/SINAD
%  FlowContraction_stats/SNR
%  FlowContraction_stats/ShapeFactor
%  FlowContraction_stats/Skewness
%  FlowContraction_stats/Std
%  FlowContraction_stats/THD
%  FlowExtrusion_stats/ClearanceFactor
%  FlowExtrusion_stats/CrestFactor
%  FlowExtrusion_stats/ImpulseFactor
%  FlowExtrusion_stats/Kurtosis
%  FlowExtrusion_stats/Mean
%  FlowExtrusion_stats/PeakValue
%  FlowExtrusion_stats/RMS
%  FlowExtrusion_stats/SINAD
%  FlowExtrusion_stats/SNR
%  FlowExtrusion_stats/ShapeFactor
%  FlowExtrusion_stats/Skewness
%  FlowExtrusion_stats/Std
%  FlowExtrusion_stats/THD
%  FlowContraction_ps_spec/PeakAmp1
%  FlowContraction_ps_spec/PeakAmp2
%  FlowContraction_ps_spec/PeakAmp3
%  FlowContraction_ps_spec/PeakAmp4
%  FlowContraction_ps_spec/PeakAmp5
%  FlowContraction_ps_spec/PeakFreq1
%  FlowContraction_ps_spec/PeakFreq2
%  FlowContraction_ps_spec/PeakFreq3
%  FlowContraction_ps_spec/PeakFreq4
%  FlowContraction_ps_spec/PeakFreq5
%  FlowContraction_ps_spec/BandPower
%  FlowExtrusion_ps_spec/PeakAmp1
%  FlowExtrusion_ps_spec/PeakAmp2
%  FlowExtrusion_ps_spec/PeakAmp3
%  FlowExtrusion_ps_spec/PeakAmp4
%  FlowExtrusion_ps_spec/PeakAmp5
%  FlowExtrusion_ps_spec/PeakFreq1
%  FlowExtrusion_ps_spec/PeakFreq2
%  FlowExtrusion_ps_spec/PeakFreq3
%  FlowExtrusion_ps_spec/PeakFreq4
%  FlowExtrusion_ps_spec/PeakFreq5
%  FlowExtrusion_ps_spec/BandPower
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

% Auto-generated by MATLAB on 03-May-2021 00:41:30

% Create output ensemble.
outputEnsemble = workspaceEnsemble(inputData,'DataVariables',["FlowContraction_stats/ClearanceFactor";"FlowContraction_stats/CrestFactor";"FlowContraction_stats/ImpulseFactor";"FlowContraction_stats/Kurtosis";"FlowContraction_stats/Mean";"FlowContraction_stats/PeakValue";"FlowContraction_stats/RMS";"FlowContraction_stats/SINAD";"FlowContraction_stats/SNR";"FlowContraction_stats/ShapeFactor";"FlowContraction_stats/Skewness";"FlowContraction_stats/Std";"FlowContraction_stats/THD";"FlowExtrusion_stats/ClearanceFactor";"FlowExtrusion_stats/CrestFactor";"FlowExtrusion_stats/ImpulseFactor";"FlowExtrusion_stats/Kurtosis";"FlowExtrusion_stats/Mean";"FlowExtrusion_stats/PeakValue";"FlowExtrusion_stats/RMS";"FlowExtrusion_stats/SINAD";"FlowExtrusion_stats/SNR";"FlowExtrusion_stats/ShapeFactor";"FlowExtrusion_stats/Skewness";"FlowExtrusion_stats/Std";"FlowExtrusion_stats/THD";"FlowContraction_ps_spec/PeakAmp1";"FlowContraction_ps_spec/PeakAmp2";"FlowContraction_ps_spec/PeakAmp3";"FlowContraction_ps_spec/PeakAmp4";"FlowContraction_ps_spec/PeakAmp5";"FlowContraction_ps_spec/PeakFreq1";"FlowContraction_ps_spec/PeakFreq2";"FlowContraction_ps_spec/PeakFreq3";"FlowContraction_ps_spec/PeakFreq4";"FlowContraction_ps_spec/PeakFreq5";"FlowContraction_ps_spec/BandPower";"FlowExtrusion_ps_spec/PeakAmp1";"FlowExtrusion_ps_spec/PeakAmp2";"FlowExtrusion_ps_spec/PeakAmp3";"FlowExtrusion_ps_spec/PeakAmp4";"FlowExtrusion_ps_spec/PeakAmp5";"FlowExtrusion_ps_spec/PeakFreq1";"FlowExtrusion_ps_spec/PeakFreq2";"FlowExtrusion_ps_spec/PeakFreq3";"FlowExtrusion_ps_spec/PeakFreq4";"FlowExtrusion_ps_spec/PeakFreq5";"FlowExtrusion_ps_spec/BandPower"],'ConditionVariables',"Label");


% Gather all features into a table.
featureTable = readFeatureTable(outputEnsemble);

% Feature ranking for FeatureTable1
selectedFeatureNames = ["FlowContraction_stats/ClearanceFactor","FlowContraction_stats/CrestFactor","FlowContraction_stats/ImpulseFactor","FlowContraction_stats/Kurtosis","FlowContraction_stats/Mean","FlowContraction_stats/PeakValue","FlowContraction_stats/RMS","FlowContraction_stats/SINAD","FlowContraction_stats/SNR","FlowContraction_stats/ShapeFactor","FlowContraction_stats/Skewness","FlowContraction_stats/Std","FlowContraction_stats/THD","FlowExtrusion_stats/ClearanceFactor","FlowExtrusion_stats/CrestFactor","FlowExtrusion_stats/ImpulseFactor","FlowExtrusion_stats/Kurtosis","FlowExtrusion_stats/Mean","FlowExtrusion_stats/PeakValue","FlowExtrusion_stats/RMS","FlowExtrusion_stats/SINAD","FlowExtrusion_stats/SNR","FlowExtrusion_stats/ShapeFactor","FlowExtrusion_stats/Skewness","FlowExtrusion_stats/Std","FlowExtrusion_stats/THD","FlowContraction_ps_spec/PeakAmp1","FlowContraction_ps_spec/PeakAmp2","FlowContraction_ps_spec/PeakAmp3","FlowContraction_ps_spec/PeakAmp4","FlowContraction_ps_spec/PeakAmp5","FlowContraction_ps_spec/PeakFreq1","FlowContraction_ps_spec/PeakFreq2","FlowContraction_ps_spec/PeakFreq3","FlowContraction_ps_spec/PeakFreq4","FlowContraction_ps_spec/PeakFreq5","FlowContraction_ps_spec/BandPower","FlowExtrusion_ps_spec/PeakAmp1","FlowExtrusion_ps_spec/PeakAmp2","FlowExtrusion_ps_spec/PeakAmp3","FlowExtrusion_ps_spec/PeakAmp4","FlowExtrusion_ps_spec/PeakAmp5","FlowExtrusion_ps_spec/PeakFreq1","FlowExtrusion_ps_spec/PeakFreq2","FlowExtrusion_ps_spec/PeakFreq3","FlowExtrusion_ps_spec/PeakFreq4","FlowExtrusion_ps_spec/PeakFreq5","FlowExtrusion_ps_spec/BandPower"];

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
