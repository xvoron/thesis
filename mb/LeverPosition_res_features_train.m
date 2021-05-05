function [trainedClassifier, validationAccuracy] = LeverPosition_res_features_train(trainingData)
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

% Auto-generated by MATLAB on 05-May-2021 20:10:14


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'LeverPosition_res_stats/ClearanceFactor', 'LeverPosition_res_stats/CrestFactor', 'LeverPosition_res_stats/ImpulseFactor', 'LeverPosition_res_stats/Kurtosis', 'LeverPosition_res_stats/Mean', 'LeverPosition_res_stats/PeakValue', 'LeverPosition_res_stats/RMS', 'LeverPosition_res_stats/SINAD', 'LeverPosition_res_stats/SNR', 'LeverPosition_res_stats/ShapeFactor', 'LeverPosition_res_stats/Skewness', 'LeverPosition_res_stats/Std', 'LeverPosition_res_stats/THD'};
predictors = inputTable(:, predictorNames);
response = inputTable.Label;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false];

% Apply a PCA to the predictor matrix.
% Run PCA on numeric predictors only. Categorical predictors are passed through PCA untouched.
isCategoricalPredictorBeforePCA = isCategoricalPredictor;
numericPredictors = predictors(:, ~isCategoricalPredictor);
numericPredictors = table2array(varfun(@double, numericPredictors));
% 'inf' values have to be treated as missing data for PCA.
numericPredictors(isinf(numericPredictors)) = NaN;
[pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(...
    numericPredictors);
% Keep enough components to explain the desired amount of variance.
explainedVarianceToKeepAsFraction = 98/100;
numComponentsToKeep = find(cumsum(explained)/sum(explained) >= explainedVarianceToKeepAsFraction, 1);
pcaCoefficients = pcaCoefficients(:,1:numComponentsToKeep);
predictors = [array2table(pcaScores(:,1:numComponentsToKeep)), predictors(:, isCategoricalPredictor)];
isCategoricalPredictor = [false(1,numComponentsToKeep), true(1,sum(isCategoricalPredictor))];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationKNN = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 1, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true, ...
    'ClassNames', {'damp_small_bot'; 'damp_small_up'; 'health'; 'valve1'; 'valve2'});

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
pcaTransformationFcn = @(x) [ array2table((table2array(varfun(@double, x(:, ~isCategoricalPredictorBeforePCA))) - pcaCenters) * pcaCoefficients), x(:,isCategoricalPredictorBeforePCA) ];
knnPredictFcn = @(x) predict(classificationKNN, x);
trainedClassifier.predictFcn = @(x) knnPredictFcn(pcaTransformationFcn(predictorExtractionFcn(x)));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'LeverPosition_res_stats/ClearanceFactor', 'LeverPosition_res_stats/CrestFactor', 'LeverPosition_res_stats/ImpulseFactor', 'LeverPosition_res_stats/Kurtosis', 'LeverPosition_res_stats/Mean', 'LeverPosition_res_stats/PeakValue', 'LeverPosition_res_stats/RMS', 'LeverPosition_res_stats/SINAD', 'LeverPosition_res_stats/SNR', 'LeverPosition_res_stats/ShapeFactor', 'LeverPosition_res_stats/Skewness', 'LeverPosition_res_stats/Std', 'LeverPosition_res_stats/THD'};
trainedClassifier.PCACenters = pcaCenters;
trainedClassifier.PCACoefficients = pcaCoefficients;
trainedClassifier.ClassificationKNN = classificationKNN;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2021a.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'LeverPosition_res_stats/ClearanceFactor', 'LeverPosition_res_stats/CrestFactor', 'LeverPosition_res_stats/ImpulseFactor', 'LeverPosition_res_stats/Kurtosis', 'LeverPosition_res_stats/Mean', 'LeverPosition_res_stats/PeakValue', 'LeverPosition_res_stats/RMS', 'LeverPosition_res_stats/SINAD', 'LeverPosition_res_stats/SNR', 'LeverPosition_res_stats/ShapeFactor', 'LeverPosition_res_stats/Skewness', 'LeverPosition_res_stats/Std', 'LeverPosition_res_stats/THD'};
predictors = inputTable(:, predictorNames);
response = inputTable.Label;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false];

% Perform cross-validation
KFolds = 5;
cvp = cvpartition(response, 'KFold', KFolds);
% Initialize the predictions to the proper sizes
validationPredictions = response;
numObservations = size(predictors, 1);
numClasses = 5;
validationScores = NaN(numObservations, numClasses);
for fold = 1:KFolds
    trainingPredictors = predictors(cvp.training(fold), :);
    trainingResponse = response(cvp.training(fold), :);
    foldIsCategoricalPredictor = isCategoricalPredictor;
    
    % Apply a PCA to the predictor matrix.
    % Run PCA on numeric predictors only. Categorical predictors are passed through PCA untouched.
    isCategoricalPredictorBeforePCA = foldIsCategoricalPredictor;
    numericPredictors = trainingPredictors(:, ~foldIsCategoricalPredictor);
    numericPredictors = table2array(varfun(@double, numericPredictors));
    % 'inf' values have to be treated as missing data for PCA.
    numericPredictors(isinf(numericPredictors)) = NaN;
    [pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(...
        numericPredictors);
    % Keep enough components to explain the desired amount of variance.
    explainedVarianceToKeepAsFraction = 98/100;
    numComponentsToKeep = find(cumsum(explained)/sum(explained) >= explainedVarianceToKeepAsFraction, 1);
    pcaCoefficients = pcaCoefficients(:,1:numComponentsToKeep);
    trainingPredictors = [array2table(pcaScores(:,1:numComponentsToKeep)), trainingPredictors(:, foldIsCategoricalPredictor)];
    foldIsCategoricalPredictor = [false(1,numComponentsToKeep), true(1,sum(foldIsCategoricalPredictor))];
    
    % Train a classifier
    % This code specifies all the classifier options and trains the classifier.
    classificationKNN = fitcknn(...
        trainingPredictors, ...
        trainingResponse, ...
        'Distance', 'Euclidean', ...
        'Exponent', [], ...
        'NumNeighbors', 1, ...
        'DistanceWeight', 'Equal', ...
        'Standardize', true, ...
        'ClassNames', {'damp_small_bot'; 'damp_small_up'; 'health'; 'valve1'; 'valve2'});
    
    % Create the result struct with predict function
    pcaTransformationFcn = @(x) [ array2table((table2array(varfun(@double, x(:, ~isCategoricalPredictorBeforePCA))) - pcaCenters) * pcaCoefficients), x(:,isCategoricalPredictorBeforePCA) ];
    knnPredictFcn = @(x) predict(classificationKNN, x);
    validationPredictFcn = @(x) knnPredictFcn(pcaTransformationFcn(x));
    
    % Add additional fields to the result struct
    
    % Compute validation predictions
    validationPredictors = predictors(cvp.test(fold), :);
    [foldPredictions, foldScores] = validationPredictFcn(validationPredictors);
    
    % Store predictions in the original order
    validationPredictions(cvp.test(fold), :) = foldPredictions;
    validationScores(cvp.test(fold), :) = foldScores;
end

% Compute validation accuracy
correctPredictions = strcmp( strtrim(validationPredictions), strtrim(response));
isMissing = cellfun(@(x) all(isspace(x)), response, 'UniformOutput', true);
correctPredictions = correctPredictions(~isMissing);
validationAccuracy = sum(correctPredictions)/length(correctPredictions);
