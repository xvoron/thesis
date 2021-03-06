function [trainedClassifier, validationAccuracy] = acc_BaggedTrees_KW_train(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% Returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: A table containing the same predictor and response
%       columns as those imported into the app.
%
%  Output:
%      trainedClassifier: A struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: A function to make predictions on new
%       data.
%
%      validationAccuracy: A double containing the accuracy in percent. In
%       the app, the History list displays this overall accuracy score for
%       each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedClassifier.HowToPredict

% Auto-generated by MATLAB on 03-May-2021 19:57:30


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'AccelerometerMoving_axisZ_stats/Skewness', 'AccelerometerStatic_axisY_stats/RMS', 'AccelerometerStatic_axisY_stats/ShapeFactor', 'AccelerometerStatic_axisZ_ps_spec/PeakAmp10', 'AccelerometerStatic_axisZ_ps_spec/PeakAmp3'};
predictors = inputTable(:, predictorNames);
response = inputTable.Label;
isCategoricalPredictor = [false, false, false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
template = templateTree(...
    'MaxNumSplits', 4839);
classificationEnsemble = fitcensemble(...
    predictors, ...
    response, ...
    'Method', 'Bag', ...
    'NumLearningCycles', 30, ...
    'Learners', template, ...
    'ClassNames', {'damp_small_bot'; 'damp_small_bot+damp_small_up'; 'damp_small_bot+damps_large'; 'damp_small_up'; 'damps_large+damp_small_up'; 'health'; 'pressure+damp_small_bot'; 'pressure+damp_small_up'; 'pressure+damps_large'; 'pressure+valve1'; 'pressure+valve2'; 'valve1'; 'valve1+damp_small_bot'; 'valve1+damp_small_up'; 'valve1+damps_large'; 'valve1+valve2'; 'valve2'; 'valve2+damp_small_bot'; 'valve2+damp_small_up'; 'valve2+damps_large'});

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
ensemblePredictFcn = @(x) predict(classificationEnsemble, x);
trainedClassifier.predictFcn = @(x) ensemblePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'AccelerometerMoving_axisZ_stats/Skewness', 'AccelerometerStatic_axisY_stats/RMS', 'AccelerometerStatic_axisY_stats/ShapeFactor', 'AccelerometerStatic_axisZ_ps_spec/PeakAmp10', 'AccelerometerStatic_axisZ_ps_spec/PeakAmp3'};
trainedClassifier.ClassificationEnsemble = classificationEnsemble;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2021a.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'AccelerometerMoving_axisZ_stats/Skewness', 'AccelerometerStatic_axisY_stats/RMS', 'AccelerometerStatic_axisY_stats/ShapeFactor', 'AccelerometerStatic_axisZ_ps_spec/PeakAmp10', 'AccelerometerStatic_axisZ_ps_spec/PeakAmp3'};
predictors = inputTable(:, predictorNames);
response = inputTable.Label;
isCategoricalPredictor = [false, false, false, false, false];

% Set up holdout validation
cvp = cvpartition(response, 'Holdout', 0.25);
trainingPredictors = predictors(cvp.training, :);
trainingResponse = response(cvp.training, :);
trainingIsCategoricalPredictor = isCategoricalPredictor;

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
template = templateTree(...
    'MaxNumSplits', 4839);
classificationEnsemble = fitcensemble(...
    trainingPredictors, ...
    trainingResponse, ...
    'Method', 'Bag', ...
    'NumLearningCycles', 30, ...
    'Learners', template, ...
    'ClassNames', {'damp_small_bot'; 'damp_small_bot+damp_small_up'; 'damp_small_bot+damps_large'; 'damp_small_up'; 'damps_large+damp_small_up'; 'health'; 'pressure+damp_small_bot'; 'pressure+damp_small_up'; 'pressure+damps_large'; 'pressure+valve1'; 'pressure+valve2'; 'valve1'; 'valve1+damp_small_bot'; 'valve1+damp_small_up'; 'valve1+damps_large'; 'valve1+valve2'; 'valve2'; 'valve2+damp_small_bot'; 'valve2+damp_small_up'; 'valve2+damps_large'});

% Create the result struct with predict function
ensemblePredictFcn = @(x) predict(classificationEnsemble, x);
validationPredictFcn = @(x) ensemblePredictFcn(x);

% Add additional fields to the result struct


% Compute validation predictions
validationPredictors = predictors(cvp.test, :);
validationResponse = response(cvp.test, :);
[validationPredictions, validationScores] = validationPredictFcn(validationPredictors);

% Compute validation accuracy
correctPredictions = strcmp( strtrim(validationPredictions), strtrim(validationResponse));
isMissing = cellfun(@(x) all(isspace(x)), validationResponse, 'UniformOutput', true);
correctPredictions = correctPredictions(~isMissing);
validationAccuracy = sum(correctPredictions)/length(correctPredictions);
