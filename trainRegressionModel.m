function [trainedModel, validationRMSE] = trainRegressionModel(trainingData)
% [trainedModel, validationRMSE] = trainRegressionModel(trainingData)
% returns a trained regression model and its RMSE. This code recreates the
% model trained in Regression Learner app. Use the generated code to
% automate training the same model with new data, or to learn how to
% programmatically train models.
%
%  Input:
%      trainingData: a table containing the same predictor and response
%       columns as imported into the app.
%
%  Output:
%      trainedModel: a struct containing the trained regression model. The
%       struct contains various fields with information about the trained
%       model.
%
%      trainedModel.predictFcn: a function to make predictions on new data.
%
%      validationRMSE: a double containing the RMSE. In the app, the
%       History list displays the RMSE for each model.
%
% Use the code to train the model with new data. To retrain your model,
% call the function from the command line with your original data or new
% data as the input argument trainingData.
%
% For example, to retrain a regression model trained with the original data
% set T, enter:
%   [trainedModel, validationRMSE] = trainRegressionModel(T)
%
% To make predictions with the returned 'trainedModel' on new data T2, use
%   yfit = trainedModel.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedModel.HowToPredict

% Auto-generated by MATLAB on 06-Aug-2018 01:01:58


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'TimbreAvg1', 'TimbreAvg2', 'TimbreAvg3', 'TimbreAvg4', 'TimbreAvg5', 'TimbreAvg6', 'TimbreAvg7', 'TimbreAvg8', 'TimbreAvg9', 'TimbreAvg10', 'TimbreAvg11', 'TimbreAvg12', 'TimbreCovariance1', 'TimbreCovariance2', 'TimbreCovariance3', 'TimbreCovariance4', 'TimbreCovariance5', 'TimbreCovariance6', 'TimbreCovariance7', 'TimbreCovariance8', 'TimbreCovariance9', 'TimbreCovariance10', 'TimbreCovariance11', 'TimbreCovariance12', 'TimbreCovariance13', 'TimbreCovariance14', 'TimbreCovariance15', 'TimbreCovariance16', 'TimbreCovariance17', 'TimbreCovariance18', 'TimbreCovariance19', 'TimbreCovariance20', 'TimbreCovariance21', 'TimbreCovariance22', 'TimbreCovariance23', 'TimbreCovariance24', 'TimbreCovariance25', 'TimbreCovariance26', 'TimbreCovariance27', 'TimbreCovariance28', 'TimbreCovariance29', 'TimbreCovariance30', 'TimbreCovariance31', 'TimbreCovariance32', 'TimbreCovariance33', 'TimbreCovariance34', 'TimbreCovariance35', 'TimbreCovariance36', 'TimbreCovariance37', 'TimbreCovariance38', 'TimbreCovariance39', 'TimbreCovariance40', 'TimbreCovariance41', 'TimbreCovariance42', 'TimbreCovariance43', 'TimbreCovariance44', 'TimbreCovariance45', 'TimbreCovariance46', 'TimbreCovariance47', 'TimbreCovariance48', 'TimbreCovariance49', 'TimbreCovariance50', 'TimbreCovariance51', 'TimbreCovariance52', 'TimbreCovariance53', 'TimbreCovariance54', 'TimbreCovariance55', 'TimbreCovariance56', 'TimbreCovariance57', 'TimbreCovariance58', 'TimbreCovariance59', 'TimbreCovariance60', 'TimbreCovariance61', 'TimbreCovariance62', 'TimbreCovariance63', 'TimbreCovariance64', 'TimbreCovariance65', 'TimbreCovariance66', 'TimbreCovariance67', 'TimbreCovariance68', 'TimbreCovariance69', 'TimbreCovariance70', 'TimbreCovariance71', 'TimbreCovariance72', 'TimbreCovariance73', 'TimbreCovariance74', 'TimbreCovariance75', 'TimbreCovariance76', 'TimbreCovariance77', 'TimbreCovariance78'};
predictors = inputTable(:, predictorNames);
response = inputTable.label;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Train a regression model
% This code specifies all the model options and trains the model.
concatenatedPredictorsAndResponse = predictors;
concatenatedPredictorsAndResponse.label = response;
linearModel = fitlm(...
    concatenatedPredictorsAndResponse, ...
    'purequadratic', ...
    'RobustOpts', 'off');

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
linearModelPredictFcn = @(x) predict(linearModel, x);
trainedModel.predictFcn = @(x) linearModelPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedModel.RequiredVariables = {'TimbreAvg1', 'TimbreAvg2', 'TimbreAvg3', 'TimbreAvg4', 'TimbreAvg5', 'TimbreAvg6', 'TimbreAvg7', 'TimbreAvg8', 'TimbreAvg9', 'TimbreAvg10', 'TimbreAvg11', 'TimbreAvg12', 'TimbreCovariance1', 'TimbreCovariance2', 'TimbreCovariance3', 'TimbreCovariance4', 'TimbreCovariance5', 'TimbreCovariance6', 'TimbreCovariance7', 'TimbreCovariance8', 'TimbreCovariance9', 'TimbreCovariance10', 'TimbreCovariance11', 'TimbreCovariance12', 'TimbreCovariance13', 'TimbreCovariance14', 'TimbreCovariance15', 'TimbreCovariance16', 'TimbreCovariance17', 'TimbreCovariance18', 'TimbreCovariance19', 'TimbreCovariance20', 'TimbreCovariance21', 'TimbreCovariance22', 'TimbreCovariance23', 'TimbreCovariance24', 'TimbreCovariance25', 'TimbreCovariance26', 'TimbreCovariance27', 'TimbreCovariance28', 'TimbreCovariance29', 'TimbreCovariance30', 'TimbreCovariance31', 'TimbreCovariance32', 'TimbreCovariance33', 'TimbreCovariance34', 'TimbreCovariance35', 'TimbreCovariance36', 'TimbreCovariance37', 'TimbreCovariance38', 'TimbreCovariance39', 'TimbreCovariance40', 'TimbreCovariance41', 'TimbreCovariance42', 'TimbreCovariance43', 'TimbreCovariance44', 'TimbreCovariance45', 'TimbreCovariance46', 'TimbreCovariance47', 'TimbreCovariance48', 'TimbreCovariance49', 'TimbreCovariance50', 'TimbreCovariance51', 'TimbreCovariance52', 'TimbreCovariance53', 'TimbreCovariance54', 'TimbreCovariance55', 'TimbreCovariance56', 'TimbreCovariance57', 'TimbreCovariance58', 'TimbreCovariance59', 'TimbreCovariance60', 'TimbreCovariance61', 'TimbreCovariance62', 'TimbreCovariance63', 'TimbreCovariance64', 'TimbreCovariance65', 'TimbreCovariance66', 'TimbreCovariance67', 'TimbreCovariance68', 'TimbreCovariance69', 'TimbreCovariance70', 'TimbreCovariance71', 'TimbreCovariance72', 'TimbreCovariance73', 'TimbreCovariance74', 'TimbreCovariance75', 'TimbreCovariance76', 'TimbreCovariance77', 'TimbreCovariance78'};
trainedModel.LinearModel = linearModel;
trainedModel.About = 'This struct is a trained model exported from Regression Learner R2017b.';
trainedModel.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appregression_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'TimbreAvg1', 'TimbreAvg2', 'TimbreAvg3', 'TimbreAvg4', 'TimbreAvg5', 'TimbreAvg6', 'TimbreAvg7', 'TimbreAvg8', 'TimbreAvg9', 'TimbreAvg10', 'TimbreAvg11', 'TimbreAvg12', 'TimbreCovariance1', 'TimbreCovariance2', 'TimbreCovariance3', 'TimbreCovariance4', 'TimbreCovariance5', 'TimbreCovariance6', 'TimbreCovariance7', 'TimbreCovariance8', 'TimbreCovariance9', 'TimbreCovariance10', 'TimbreCovariance11', 'TimbreCovariance12', 'TimbreCovariance13', 'TimbreCovariance14', 'TimbreCovariance15', 'TimbreCovariance16', 'TimbreCovariance17', 'TimbreCovariance18', 'TimbreCovariance19', 'TimbreCovariance20', 'TimbreCovariance21', 'TimbreCovariance22', 'TimbreCovariance23', 'TimbreCovariance24', 'TimbreCovariance25', 'TimbreCovariance26', 'TimbreCovariance27', 'TimbreCovariance28', 'TimbreCovariance29', 'TimbreCovariance30', 'TimbreCovariance31', 'TimbreCovariance32', 'TimbreCovariance33', 'TimbreCovariance34', 'TimbreCovariance35', 'TimbreCovariance36', 'TimbreCovariance37', 'TimbreCovariance38', 'TimbreCovariance39', 'TimbreCovariance40', 'TimbreCovariance41', 'TimbreCovariance42', 'TimbreCovariance43', 'TimbreCovariance44', 'TimbreCovariance45', 'TimbreCovariance46', 'TimbreCovariance47', 'TimbreCovariance48', 'TimbreCovariance49', 'TimbreCovariance50', 'TimbreCovariance51', 'TimbreCovariance52', 'TimbreCovariance53', 'TimbreCovariance54', 'TimbreCovariance55', 'TimbreCovariance56', 'TimbreCovariance57', 'TimbreCovariance58', 'TimbreCovariance59', 'TimbreCovariance60', 'TimbreCovariance61', 'TimbreCovariance62', 'TimbreCovariance63', 'TimbreCovariance64', 'TimbreCovariance65', 'TimbreCovariance66', 'TimbreCovariance67', 'TimbreCovariance68', 'TimbreCovariance69', 'TimbreCovariance70', 'TimbreCovariance71', 'TimbreCovariance72', 'TimbreCovariance73', 'TimbreCovariance74', 'TimbreCovariance75', 'TimbreCovariance76', 'TimbreCovariance77', 'TimbreCovariance78'};
predictors = inputTable(:, predictorNames);
response = inputTable.label;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Set up holdout validation
cvp = cvpartition(size(response, 1), 'Holdout', 0.25);
trainingPredictors = predictors(cvp.training, :);
trainingResponse = response(cvp.training, :);
trainingIsCategoricalPredictor = isCategoricalPredictor;

% Train a regression model
% This code specifies all the model options and trains the model.
concatenatedPredictorsAndResponse = trainingPredictors;
concatenatedPredictorsAndResponse.label = trainingResponse;
linearModel = fitlm(...
    concatenatedPredictorsAndResponse, ...
    'purequadratic', ...
    'RobustOpts', 'off');

% Create the result struct with predict function
linearModelPredictFcn = @(x) predict(linearModel, x);
validationPredictFcn = @(x) linearModelPredictFcn(x);

% Add additional fields to the result struct


% Compute validation predictions
validationPredictors = predictors(cvp.test, :);
validationResponse = response(cvp.test, :);
validationPredictions = validationPredictFcn(validationPredictors);

% Compute validation RMSE
isNotMissing = ~isnan(validationPredictions) & ~isnan(validationResponse);
validationRMSE = sqrt(nansum(( validationPredictions - validationResponse ).^2) / numel(validationResponse(isNotMissing) ));