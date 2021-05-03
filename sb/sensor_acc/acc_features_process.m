function [featureTable,ranking,outputTable] = acc_features_process(inputData)
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
%  AccelerometerMoving_axisY_stats/ClearanceFactor
%  AccelerometerMoving_axisY_stats/CrestFactor
%  AccelerometerMoving_axisY_stats/ImpulseFactor
%  AccelerometerMoving_axisY_stats/Kurtosis
%  AccelerometerMoving_axisY_stats/Mean
%  AccelerometerMoving_axisY_stats/PeakValue
%  AccelerometerMoving_axisY_stats/RMS
%  AccelerometerMoving_axisY_stats/SINAD
%  AccelerometerMoving_axisY_stats/SNR
%  AccelerometerMoving_axisY_stats/ShapeFactor
%  AccelerometerMoving_axisY_stats/Skewness
%  AccelerometerMoving_axisY_stats/Std
%  AccelerometerMoving_axisY_stats/THD
%  AccelerometerMoving_axisZ_stats/ClearanceFactor
%  AccelerometerMoving_axisZ_stats/CrestFactor
%  AccelerometerMoving_axisZ_stats/ImpulseFactor
%  AccelerometerMoving_axisZ_stats/Kurtosis
%  AccelerometerMoving_axisZ_stats/Mean
%  AccelerometerMoving_axisZ_stats/PeakValue
%  AccelerometerMoving_axisZ_stats/RMS
%  AccelerometerMoving_axisZ_stats/SINAD
%  AccelerometerMoving_axisZ_stats/SNR
%  AccelerometerMoving_axisZ_stats/ShapeFactor
%  AccelerometerMoving_axisZ_stats/Skewness
%  AccelerometerMoving_axisZ_stats/Std
%  AccelerometerMoving_axisZ_stats/THD
%  AccelerometerStatic_axisY_stats/ClearanceFactor
%  AccelerometerStatic_axisY_stats/CrestFactor
%  AccelerometerStatic_axisY_stats/ImpulseFactor
%  AccelerometerStatic_axisY_stats/Kurtosis
%  AccelerometerStatic_axisY_stats/Mean
%  AccelerometerStatic_axisY_stats/PeakValue
%  AccelerometerStatic_axisY_stats/RMS
%  AccelerometerStatic_axisY_stats/SINAD
%  AccelerometerStatic_axisY_stats/SNR
%  AccelerometerStatic_axisY_stats/ShapeFactor
%  AccelerometerStatic_axisY_stats/Skewness
%  AccelerometerStatic_axisY_stats/Std
%  AccelerometerStatic_axisY_stats/THD
%  AccelerometerStatic_axisZ_stats/ClearanceFactor
%  AccelerometerStatic_axisZ_stats/CrestFactor
%  AccelerometerStatic_axisZ_stats/ImpulseFactor
%  AccelerometerStatic_axisZ_stats/Kurtosis
%  AccelerometerStatic_axisZ_stats/Mean
%  AccelerometerStatic_axisZ_stats/PeakValue
%  AccelerometerStatic_axisZ_stats/RMS
%  AccelerometerStatic_axisZ_stats/SINAD
%  AccelerometerStatic_axisZ_stats/SNR
%  AccelerometerStatic_axisZ_stats/ShapeFactor
%  AccelerometerStatic_axisZ_stats/Skewness
%  AccelerometerStatic_axisZ_stats/Std
%  AccelerometerStatic_axisZ_stats/THD
%  AccelerometerMoving_axisY_ps_spec/BandPower
%  AccelerometerMoving_axisY_ps_spec/PeakAmp1
%  AccelerometerMoving_axisY_ps_spec/PeakAmp10
%  AccelerometerMoving_axisY_ps_spec/PeakAmp2
%  AccelerometerMoving_axisY_ps_spec/PeakAmp3
%  AccelerometerMoving_axisY_ps_spec/PeakAmp4
%  AccelerometerMoving_axisY_ps_spec/PeakAmp5
%  AccelerometerMoving_axisY_ps_spec/PeakAmp6
%  AccelerometerMoving_axisY_ps_spec/PeakAmp7
%  AccelerometerMoving_axisY_ps_spec/PeakAmp8
%  AccelerometerMoving_axisY_ps_spec/PeakAmp9
%  AccelerometerMoving_axisY_ps_spec/PeakFreq1
%  AccelerometerMoving_axisY_ps_spec/PeakFreq10
%  AccelerometerMoving_axisY_ps_spec/PeakFreq2
%  AccelerometerMoving_axisY_ps_spec/PeakFreq3
%  AccelerometerMoving_axisY_ps_spec/PeakFreq4
%  AccelerometerMoving_axisY_ps_spec/PeakFreq5
%  AccelerometerMoving_axisY_ps_spec/PeakFreq6
%  AccelerometerMoving_axisY_ps_spec/PeakFreq7
%  AccelerometerMoving_axisY_ps_spec/PeakFreq8
%  AccelerometerMoving_axisY_ps_spec/PeakFreq9
%  AccelerometerMoving_axisZ_ps_spec/BandPower
%  AccelerometerMoving_axisZ_ps_spec/PeakAmp10
%  AccelerometerMoving_axisZ_ps_spec/PeakAmp1
%  AccelerometerMoving_axisZ_ps_spec/PeakAmp2
%  AccelerometerMoving_axisZ_ps_spec/PeakAmp3
%  AccelerometerMoving_axisZ_ps_spec/PeakAmp4
%  AccelerometerMoving_axisZ_ps_spec/PeakAmp5
%  AccelerometerMoving_axisZ_ps_spec/PeakAmp6
%  AccelerometerMoving_axisZ_ps_spec/PeakAmp7
%  AccelerometerMoving_axisZ_ps_spec/PeakAmp8
%  AccelerometerMoving_axisZ_ps_spec/PeakAmp9
%  AccelerometerMoving_axisZ_ps_spec/PeakFreq10
%  AccelerometerMoving_axisZ_ps_spec/PeakFreq1
%  AccelerometerMoving_axisZ_ps_spec/PeakFreq2
%  AccelerometerMoving_axisZ_ps_spec/PeakFreq3
%  AccelerometerMoving_axisZ_ps_spec/PeakFreq4
%  AccelerometerMoving_axisZ_ps_spec/PeakFreq5
%  AccelerometerMoving_axisZ_ps_spec/PeakFreq6
%  AccelerometerMoving_axisZ_ps_spec/PeakFreq7
%  AccelerometerMoving_axisZ_ps_spec/PeakFreq8
%  AccelerometerMoving_axisZ_ps_spec/PeakFreq9
%  AccelerometerStatic_axisY_ps_spec/BandPower
%  AccelerometerStatic_axisY_ps_spec/PeakAmp10
%  AccelerometerStatic_axisY_ps_spec/PeakAmp1
%  AccelerometerStatic_axisY_ps_spec/PeakAmp2
%  AccelerometerStatic_axisY_ps_spec/PeakAmp3
%  AccelerometerStatic_axisY_ps_spec/PeakAmp4
%  AccelerometerStatic_axisY_ps_spec/PeakAmp5
%  AccelerometerStatic_axisY_ps_spec/PeakAmp6
%  AccelerometerStatic_axisY_ps_spec/PeakAmp7
%  AccelerometerStatic_axisY_ps_spec/PeakAmp8
%  AccelerometerStatic_axisY_ps_spec/PeakAmp9
%  AccelerometerStatic_axisY_ps_spec/PeakFreq10
%  AccelerometerStatic_axisY_ps_spec/PeakFreq1
%  AccelerometerStatic_axisY_ps_spec/PeakFreq2
%  AccelerometerStatic_axisY_ps_spec/PeakFreq3
%  AccelerometerStatic_axisY_ps_spec/PeakFreq4
%  AccelerometerStatic_axisY_ps_spec/PeakFreq5
%  AccelerometerStatic_axisY_ps_spec/PeakFreq6
%  AccelerometerStatic_axisY_ps_spec/PeakFreq7
%  AccelerometerStatic_axisY_ps_spec/PeakFreq8
%  AccelerometerStatic_axisY_ps_spec/PeakFreq9
%  AccelerometerStatic_axisZ_ps_spec/BandPower
%  AccelerometerStatic_axisZ_ps_spec/PeakAmp10
%  AccelerometerStatic_axisZ_ps_spec/PeakAmp1
%  AccelerometerStatic_axisZ_ps_spec/PeakAmp2
%  AccelerometerStatic_axisZ_ps_spec/PeakAmp3
%  AccelerometerStatic_axisZ_ps_spec/PeakAmp4
%  AccelerometerStatic_axisZ_ps_spec/PeakAmp5
%  AccelerometerStatic_axisZ_ps_spec/PeakAmp6
%  AccelerometerStatic_axisZ_ps_spec/PeakAmp7
%  AccelerometerStatic_axisZ_ps_spec/PeakAmp8
%  AccelerometerStatic_axisZ_ps_spec/PeakAmp9
%  AccelerometerStatic_axisZ_ps_spec/PeakFreq10
%  AccelerometerStatic_axisZ_ps_spec/PeakFreq1
%  AccelerometerStatic_axisZ_ps_spec/PeakFreq2
%  AccelerometerStatic_axisZ_ps_spec/PeakFreq3
%  AccelerometerStatic_axisZ_ps_spec/PeakFreq4
%  AccelerometerStatic_axisZ_ps_spec/PeakFreq5
%  AccelerometerStatic_axisZ_ps_spec/PeakFreq6
%  AccelerometerStatic_axisZ_ps_spec/PeakFreq7
%  AccelerometerStatic_axisZ_ps_spec/PeakFreq8
%  AccelerometerStatic_axisZ_ps_spec/PeakFreq9
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

% Auto-generated by MATLAB on 03-May-2021 19:25:29

% Create output ensemble.
outputEnsemble = workspaceEnsemble(inputData,'DataVariables',["AccelerometerMoving_axisY_stats/ClearanceFactor";"AccelerometerMoving_axisY_stats/CrestFactor";"AccelerometerMoving_axisY_stats/ImpulseFactor";"AccelerometerMoving_axisY_stats/Kurtosis";"AccelerometerMoving_axisY_stats/Mean";"AccelerometerMoving_axisY_stats/PeakValue";"AccelerometerMoving_axisY_stats/RMS";"AccelerometerMoving_axisY_stats/SINAD";"AccelerometerMoving_axisY_stats/SNR";"AccelerometerMoving_axisY_stats/ShapeFactor";"AccelerometerMoving_axisY_stats/Skewness";"AccelerometerMoving_axisY_stats/Std";"AccelerometerMoving_axisY_stats/THD";"AccelerometerMoving_axisZ_stats/ClearanceFactor";"AccelerometerMoving_axisZ_stats/CrestFactor";"AccelerometerMoving_axisZ_stats/ImpulseFactor";"AccelerometerMoving_axisZ_stats/Kurtosis";"AccelerometerMoving_axisZ_stats/Mean";"AccelerometerMoving_axisZ_stats/PeakValue";"AccelerometerMoving_axisZ_stats/RMS";"AccelerometerMoving_axisZ_stats/SINAD";"AccelerometerMoving_axisZ_stats/SNR";"AccelerometerMoving_axisZ_stats/ShapeFactor";"AccelerometerMoving_axisZ_stats/Skewness";"AccelerometerMoving_axisZ_stats/Std";"AccelerometerMoving_axisZ_stats/THD";"AccelerometerStatic_axisY_stats/ClearanceFactor";"AccelerometerStatic_axisY_stats/CrestFactor";"AccelerometerStatic_axisY_stats/ImpulseFactor";"AccelerometerStatic_axisY_stats/Kurtosis";"AccelerometerStatic_axisY_stats/Mean";"AccelerometerStatic_axisY_stats/PeakValue";"AccelerometerStatic_axisY_stats/RMS";"AccelerometerStatic_axisY_stats/SINAD";"AccelerometerStatic_axisY_stats/SNR";"AccelerometerStatic_axisY_stats/ShapeFactor";"AccelerometerStatic_axisY_stats/Skewness";"AccelerometerStatic_axisY_stats/Std";"AccelerometerStatic_axisY_stats/THD";"AccelerometerStatic_axisZ_stats/ClearanceFactor";"AccelerometerStatic_axisZ_stats/CrestFactor";"AccelerometerStatic_axisZ_stats/ImpulseFactor";"AccelerometerStatic_axisZ_stats/Kurtosis";"AccelerometerStatic_axisZ_stats/Mean";"AccelerometerStatic_axisZ_stats/PeakValue";"AccelerometerStatic_axisZ_stats/RMS";"AccelerometerStatic_axisZ_stats/SINAD";"AccelerometerStatic_axisZ_stats/SNR";"AccelerometerStatic_axisZ_stats/ShapeFactor";"AccelerometerStatic_axisZ_stats/Skewness";"AccelerometerStatic_axisZ_stats/Std";"AccelerometerStatic_axisZ_stats/THD";"AccelerometerMoving_axisY_ps_spec/BandPower";"AccelerometerMoving_axisY_ps_spec/PeakAmp1";"AccelerometerMoving_axisY_ps_spec/PeakAmp10";"AccelerometerMoving_axisY_ps_spec/PeakAmp2";"AccelerometerMoving_axisY_ps_spec/PeakAmp3";"AccelerometerMoving_axisY_ps_spec/PeakAmp4";"AccelerometerMoving_axisY_ps_spec/PeakAmp5";"AccelerometerMoving_axisY_ps_spec/PeakAmp6";"AccelerometerMoving_axisY_ps_spec/PeakAmp7";"AccelerometerMoving_axisY_ps_spec/PeakAmp8";"AccelerometerMoving_axisY_ps_spec/PeakAmp9";"AccelerometerMoving_axisY_ps_spec/PeakFreq1";"AccelerometerMoving_axisY_ps_spec/PeakFreq10";"AccelerometerMoving_axisY_ps_spec/PeakFreq2";"AccelerometerMoving_axisY_ps_spec/PeakFreq3";"AccelerometerMoving_axisY_ps_spec/PeakFreq4";"AccelerometerMoving_axisY_ps_spec/PeakFreq5";"AccelerometerMoving_axisY_ps_spec/PeakFreq6";"AccelerometerMoving_axisY_ps_spec/PeakFreq7";"AccelerometerMoving_axisY_ps_spec/PeakFreq8";"AccelerometerMoving_axisY_ps_spec/PeakFreq9";"AccelerometerMoving_axisZ_ps_spec/BandPower";"AccelerometerMoving_axisZ_ps_spec/PeakAmp10";"AccelerometerMoving_axisZ_ps_spec/PeakAmp1";"AccelerometerMoving_axisZ_ps_spec/PeakAmp2";"AccelerometerMoving_axisZ_ps_spec/PeakAmp3";"AccelerometerMoving_axisZ_ps_spec/PeakAmp4";"AccelerometerMoving_axisZ_ps_spec/PeakAmp5";"AccelerometerMoving_axisZ_ps_spec/PeakAmp6";"AccelerometerMoving_axisZ_ps_spec/PeakAmp7";"AccelerometerMoving_axisZ_ps_spec/PeakAmp8";"AccelerometerMoving_axisZ_ps_spec/PeakAmp9";"AccelerometerMoving_axisZ_ps_spec/PeakFreq10";"AccelerometerMoving_axisZ_ps_spec/PeakFreq1";"AccelerometerMoving_axisZ_ps_spec/PeakFreq2";"AccelerometerMoving_axisZ_ps_spec/PeakFreq3";"AccelerometerMoving_axisZ_ps_spec/PeakFreq4";"AccelerometerMoving_axisZ_ps_spec/PeakFreq5";"AccelerometerMoving_axisZ_ps_spec/PeakFreq6";"AccelerometerMoving_axisZ_ps_spec/PeakFreq7";"AccelerometerMoving_axisZ_ps_spec/PeakFreq8";"AccelerometerMoving_axisZ_ps_spec/PeakFreq9";"AccelerometerStatic_axisY_ps_spec/BandPower";"AccelerometerStatic_axisY_ps_spec/PeakAmp10";"AccelerometerStatic_axisY_ps_spec/PeakAmp1";"AccelerometerStatic_axisY_ps_spec/PeakAmp2";"AccelerometerStatic_axisY_ps_spec/PeakAmp3";"AccelerometerStatic_axisY_ps_spec/PeakAmp4";"AccelerometerStatic_axisY_ps_spec/PeakAmp5";"AccelerometerStatic_axisY_ps_spec/PeakAmp6";"AccelerometerStatic_axisY_ps_spec/PeakAmp7";"AccelerometerStatic_axisY_ps_spec/PeakAmp8";"AccelerometerStatic_axisY_ps_spec/PeakAmp9";"AccelerometerStatic_axisY_ps_spec/PeakFreq10";"AccelerometerStatic_axisY_ps_spec/PeakFreq1";"AccelerometerStatic_axisY_ps_spec/PeakFreq2";"AccelerometerStatic_axisY_ps_spec/PeakFreq3";"AccelerometerStatic_axisY_ps_spec/PeakFreq4";"AccelerometerStatic_axisY_ps_spec/PeakFreq5";"AccelerometerStatic_axisY_ps_spec/PeakFreq6";"AccelerometerStatic_axisY_ps_spec/PeakFreq7";"AccelerometerStatic_axisY_ps_spec/PeakFreq8";"AccelerometerStatic_axisY_ps_spec/PeakFreq9";"AccelerometerStatic_axisZ_ps_spec/BandPower";"AccelerometerStatic_axisZ_ps_spec/PeakAmp10";"AccelerometerStatic_axisZ_ps_spec/PeakAmp1";"AccelerometerStatic_axisZ_ps_spec/PeakAmp2";"AccelerometerStatic_axisZ_ps_spec/PeakAmp3";"AccelerometerStatic_axisZ_ps_spec/PeakAmp4";"AccelerometerStatic_axisZ_ps_spec/PeakAmp5";"AccelerometerStatic_axisZ_ps_spec/PeakAmp6";"AccelerometerStatic_axisZ_ps_spec/PeakAmp7";"AccelerometerStatic_axisZ_ps_spec/PeakAmp8";"AccelerometerStatic_axisZ_ps_spec/PeakAmp9";"AccelerometerStatic_axisZ_ps_spec/PeakFreq10";"AccelerometerStatic_axisZ_ps_spec/PeakFreq1";"AccelerometerStatic_axisZ_ps_spec/PeakFreq2";"AccelerometerStatic_axisZ_ps_spec/PeakFreq3";"AccelerometerStatic_axisZ_ps_spec/PeakFreq4";"AccelerometerStatic_axisZ_ps_spec/PeakFreq5";"AccelerometerStatic_axisZ_ps_spec/PeakFreq6";"AccelerometerStatic_axisZ_ps_spec/PeakFreq7";"AccelerometerStatic_axisZ_ps_spec/PeakFreq8";"AccelerometerStatic_axisZ_ps_spec/PeakFreq9"],'ConditionVariables',"Label");


% Gather all features into a table.
featureTable = readFeatureTable(outputEnsemble);

% Feature ranking for FeatureTable1
selectedFeatureNames = ["AccelerometerMoving_axisY_stats/ClearanceFactor","AccelerometerMoving_axisY_stats/CrestFactor","AccelerometerMoving_axisY_stats/ImpulseFactor","AccelerometerMoving_axisY_stats/Kurtosis","AccelerometerMoving_axisY_stats/Mean","AccelerometerMoving_axisY_stats/PeakValue","AccelerometerMoving_axisY_stats/RMS","AccelerometerMoving_axisY_stats/SINAD","AccelerometerMoving_axisY_stats/SNR","AccelerometerMoving_axisY_stats/ShapeFactor","AccelerometerMoving_axisY_stats/Skewness","AccelerometerMoving_axisY_stats/Std","AccelerometerMoving_axisY_stats/THD","AccelerometerMoving_axisZ_stats/ClearanceFactor","AccelerometerMoving_axisZ_stats/CrestFactor","AccelerometerMoving_axisZ_stats/ImpulseFactor","AccelerometerMoving_axisZ_stats/Kurtosis","AccelerometerMoving_axisZ_stats/Mean","AccelerometerMoving_axisZ_stats/PeakValue","AccelerometerMoving_axisZ_stats/RMS","AccelerometerMoving_axisZ_stats/SINAD","AccelerometerMoving_axisZ_stats/SNR","AccelerometerMoving_axisZ_stats/ShapeFactor","AccelerometerMoving_axisZ_stats/Skewness","AccelerometerMoving_axisZ_stats/Std","AccelerometerMoving_axisZ_stats/THD","AccelerometerStatic_axisY_stats/ClearanceFactor","AccelerometerStatic_axisY_stats/CrestFactor","AccelerometerStatic_axisY_stats/ImpulseFactor","AccelerometerStatic_axisY_stats/Kurtosis","AccelerometerStatic_axisY_stats/Mean","AccelerometerStatic_axisY_stats/PeakValue","AccelerometerStatic_axisY_stats/RMS","AccelerometerStatic_axisY_stats/SINAD","AccelerometerStatic_axisY_stats/SNR","AccelerometerStatic_axisY_stats/ShapeFactor","AccelerometerStatic_axisY_stats/Skewness","AccelerometerStatic_axisY_stats/Std","AccelerometerStatic_axisY_stats/THD","AccelerometerStatic_axisZ_stats/ClearanceFactor","AccelerometerStatic_axisZ_stats/CrestFactor","AccelerometerStatic_axisZ_stats/ImpulseFactor","AccelerometerStatic_axisZ_stats/Kurtosis","AccelerometerStatic_axisZ_stats/Mean","AccelerometerStatic_axisZ_stats/PeakValue","AccelerometerStatic_axisZ_stats/RMS","AccelerometerStatic_axisZ_stats/SINAD","AccelerometerStatic_axisZ_stats/SNR","AccelerometerStatic_axisZ_stats/ShapeFactor","AccelerometerStatic_axisZ_stats/Skewness","AccelerometerStatic_axisZ_stats/Std","AccelerometerStatic_axisZ_stats/THD","AccelerometerMoving_axisY_ps_spec/BandPower","AccelerometerMoving_axisY_ps_spec/PeakAmp1","AccelerometerMoving_axisY_ps_spec/PeakAmp10","AccelerometerMoving_axisY_ps_spec/PeakAmp2","AccelerometerMoving_axisY_ps_spec/PeakAmp3","AccelerometerMoving_axisY_ps_spec/PeakAmp4","AccelerometerMoving_axisY_ps_spec/PeakAmp5","AccelerometerMoving_axisY_ps_spec/PeakAmp6","AccelerometerMoving_axisY_ps_spec/PeakAmp7","AccelerometerMoving_axisY_ps_spec/PeakAmp8","AccelerometerMoving_axisY_ps_spec/PeakAmp9","AccelerometerMoving_axisY_ps_spec/PeakFreq1","AccelerometerMoving_axisY_ps_spec/PeakFreq10","AccelerometerMoving_axisY_ps_spec/PeakFreq2","AccelerometerMoving_axisY_ps_spec/PeakFreq3","AccelerometerMoving_axisY_ps_spec/PeakFreq4","AccelerometerMoving_axisY_ps_spec/PeakFreq5","AccelerometerMoving_axisY_ps_spec/PeakFreq6","AccelerometerMoving_axisY_ps_spec/PeakFreq7","AccelerometerMoving_axisY_ps_spec/PeakFreq8","AccelerometerMoving_axisY_ps_spec/PeakFreq9","AccelerometerMoving_axisZ_ps_spec/BandPower","AccelerometerMoving_axisZ_ps_spec/PeakAmp10","AccelerometerMoving_axisZ_ps_spec/PeakAmp1","AccelerometerMoving_axisZ_ps_spec/PeakAmp2","AccelerometerMoving_axisZ_ps_spec/PeakAmp3","AccelerometerMoving_axisZ_ps_spec/PeakAmp4","AccelerometerMoving_axisZ_ps_spec/PeakAmp5","AccelerometerMoving_axisZ_ps_spec/PeakAmp6","AccelerometerMoving_axisZ_ps_spec/PeakAmp7","AccelerometerMoving_axisZ_ps_spec/PeakAmp8","AccelerometerMoving_axisZ_ps_spec/PeakAmp9","AccelerometerMoving_axisZ_ps_spec/PeakFreq10","AccelerometerMoving_axisZ_ps_spec/PeakFreq1","AccelerometerMoving_axisZ_ps_spec/PeakFreq2","AccelerometerMoving_axisZ_ps_spec/PeakFreq3","AccelerometerMoving_axisZ_ps_spec/PeakFreq4","AccelerometerMoving_axisZ_ps_spec/PeakFreq5","AccelerometerMoving_axisZ_ps_spec/PeakFreq6","AccelerometerMoving_axisZ_ps_spec/PeakFreq7","AccelerometerMoving_axisZ_ps_spec/PeakFreq8","AccelerometerMoving_axisZ_ps_spec/PeakFreq9","AccelerometerStatic_axisY_ps_spec/BandPower","AccelerometerStatic_axisY_ps_spec/PeakAmp10","AccelerometerStatic_axisY_ps_spec/PeakAmp1","AccelerometerStatic_axisY_ps_spec/PeakAmp2","AccelerometerStatic_axisY_ps_spec/PeakAmp3","AccelerometerStatic_axisY_ps_spec/PeakAmp4","AccelerometerStatic_axisY_ps_spec/PeakAmp5","AccelerometerStatic_axisY_ps_spec/PeakAmp6","AccelerometerStatic_axisY_ps_spec/PeakAmp7","AccelerometerStatic_axisY_ps_spec/PeakAmp8","AccelerometerStatic_axisY_ps_spec/PeakAmp9","AccelerometerStatic_axisY_ps_spec/PeakFreq10","AccelerometerStatic_axisY_ps_spec/PeakFreq1","AccelerometerStatic_axisY_ps_spec/PeakFreq2","AccelerometerStatic_axisY_ps_spec/PeakFreq3","AccelerometerStatic_axisY_ps_spec/PeakFreq4","AccelerometerStatic_axisY_ps_spec/PeakFreq5","AccelerometerStatic_axisY_ps_spec/PeakFreq6","AccelerometerStatic_axisY_ps_spec/PeakFreq7","AccelerometerStatic_axisY_ps_spec/PeakFreq8","AccelerometerStatic_axisY_ps_spec/PeakFreq9","AccelerometerStatic_axisZ_ps_spec/BandPower","AccelerometerStatic_axisZ_ps_spec/PeakAmp10","AccelerometerStatic_axisZ_ps_spec/PeakAmp1","AccelerometerStatic_axisZ_ps_spec/PeakAmp2","AccelerometerStatic_axisZ_ps_spec/PeakAmp3","AccelerometerStatic_axisZ_ps_spec/PeakAmp4","AccelerometerStatic_axisZ_ps_spec/PeakAmp5","AccelerometerStatic_axisZ_ps_spec/PeakAmp6","AccelerometerStatic_axisZ_ps_spec/PeakAmp7","AccelerometerStatic_axisZ_ps_spec/PeakAmp8","AccelerometerStatic_axisZ_ps_spec/PeakAmp9","AccelerometerStatic_axisZ_ps_spec/PeakFreq10","AccelerometerStatic_axisZ_ps_spec/PeakFreq1","AccelerometerStatic_axisZ_ps_spec/PeakFreq2","AccelerometerStatic_axisZ_ps_spec/PeakFreq3","AccelerometerStatic_axisZ_ps_spec/PeakFreq4","AccelerometerStatic_axisZ_ps_spec/PeakFreq5","AccelerometerStatic_axisZ_ps_spec/PeakFreq6","AccelerometerStatic_axisZ_ps_spec/PeakFreq7","AccelerometerStatic_axisZ_ps_spec/PeakFreq8","AccelerometerStatic_axisZ_ps_spec/PeakFreq9"];

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
