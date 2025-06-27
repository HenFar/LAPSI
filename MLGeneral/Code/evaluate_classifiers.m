function evaluate_classifiers(theta12_nsr, theta23_nsr, theta12_vf, theta23_vf)

% Build features
X = [theta12_nsr, theta23_nsr; theta12_vf, theta23_vf];
y = [zeros(length(theta12_nsr),1); ones(length(theta12_vf),1)];

% Create 10-fold partition
cv = cvpartition(y, 'KFold', 10);

% ---- Choose classifiers ----
models = {
    'SVM',       @(X,y) fitcsvm(X, y, 'KernelFunction', 'linear');
    'LDA',       @(X,y) fitcdiscr(X, y);
    'RandomForest', @(X,y) fitcensemble(X, y, 'Method','Bag');
};

% Loop over models
for m = 1:size(models,1)
    name = models{m,1};
    trainFunc = models{m,2};
    accs = zeros(cv.NumTestSets,1);
    snss = zeros(cv.NumTestSets,1);
    spcs = zeros(cv.NumTestSets,1);

    for i = 1:cv.NumTestSets
        trainIdx = training(cv, i);
        testIdx = test(cv, i);

        mdl = trainFunc(X(trainIdx,:), y(trainIdx));
        yPred = predict(mdl, X(testIdx,:));
        yTrue = y(testIdx);

        % Confusion matrix
        TP = sum((yPred==1) & (yTrue==1));
        TN = sum((yPred==0) & (yTrue==0));
        FP = sum((yPred==1) & (yTrue==0));
        FN = sum((yPred==0) & (yTrue==1));

        accs(i) = (TP + TN) / (TP + TN + FP + FN);
        snss(i) = TP / (TP + FN);  % Sensitivity
        spcs(i) = TN / (TN + FP);  % Specificity
    end

    % Print results
    fprintf('\n%s:\n', name);
    fprintf('Accuracy: %.2f ± %.2f %%\n', mean(accs)*100, std(accs)*100);
    fprintf('Sensitivity: %.2f ± %.2f %%\n', mean(snss)*100, std(snss)*100);
    fprintf('Specificity: %.2f ± %.2f %%\n', mean(spcs)*100, std(spcs)*100);
end
end
