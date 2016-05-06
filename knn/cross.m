function [TrainData,TestData,LabelsTrainData,LabelsTestData] = cross(class0,class1,method) 
%Ntagiou Anna 432
Xtrain1 = class0;                                               %length(class0) instances of class 0 with 10 features
Xtrain2 = class1;                                               %length(class1) instances of class 1 with 10 features
N1 = length(Xtrain1);                                           %number of instances per class
N2 = length(Xtrain2);

switch method
    case 1
        Nfolds = 10;                                                    %number of folds (Cross Validation with folds=10)
        indices1 = crossvalind('Kfold',N1,Nfolds);                      %creating folds of class 1 indices of instances of each fold
        indices2 = crossvalind('Kfold',N2,Nfolds);                      %creating folds of class 2
        for i=1:Nfolds
            Test_Fold_class1 = find(indices1 == i);
            Train_Folds_class_1 = find(indices1 ~= i);
            Test_Fold_class2 = find(indices2 == i);
            Train_Folds_class_2 = find(indices2 ~= i);
            TrainData = [Xtrain1(Train_Folds_class_1,:);
            Xtrain2(Train_Folds_class_2,:)];
            LabelsTrainData = [zeros(length(Train_Folds_class_1),1);
            ones(length(Train_Folds_class_2),1)];
            TestData = [Xtrain1(Test_Fold_class1,:);
            Xtrain2(Test_Fold_class2,:)];
            LabelsTestData = [zeros(length(Test_Fold_class1),1);
            ones(length(Test_Fold_class2),1)];
        end
    case 2
        Nfolds = 3;                                                     %number of folds (33% Test Data and 66% Train Data so N=3)
        indices1 = crossvalind('Kfold',N1,Nfolds);                      %creating folds of class 1 indices of instances of each fold
        indices2 = crossvalind('Kfold',N2,Nfolds);                      %creating folds of class 2
        for i=1:Nfolds
            Test_Fold_class1 = find(indices1 == i);
            Train_Folds_class_1 = find(indices1 ~= i);
            Test_Fold_class2 = find(indices2 == i);
            Train_Folds_class_2 = find(indices2 ~= i);
            TrainData = [Xtrain1(Train_Folds_class_1,:);
            Xtrain2(Train_Folds_class_2,:)];
            LabelsTrainData = [zeros(length(Train_Folds_class_1),1);
            ones(length(Train_Folds_class_2),1)];
            TestData = [Xtrain1(Test_Fold_class1,:);
            Xtrain2(Test_Fold_class2,:)];
            LabelsTestData = [zeros(length(Test_Fold_class1),1);
            ones(length(Test_Fold_class2),1)];
        end
    case 3
        Nfolds = N1+N2;                                                 %number of folds (Leave one out that is N Test Data and N-1 Train Data so N=N1+N2 )
        indices1 = crossvalind('Kfold',N1,Nfolds);                      %creating folds of class 1 indices of instances of each fold
        indices2 = crossvalind('Kfold',N2,Nfolds);                      %creating folds of class 2
        for i=1:Nfolds
            Test_Fold_class1 = find(indices1 == i);
            Train_Folds_class_1 = find(indices1 ~= i);
            Test_Fold_class2 = find(indices2 == i);
            Train_Folds_class_2 = find(indices2 ~= i);
            TrainData = [Xtrain1(Train_Folds_class_1,:);
            Xtrain2(Train_Folds_class_2,:)];
            LabelsTrainData = [zeros(length(Train_Folds_class_1),1);
            ones(length(Train_Folds_class_2),1)];
            TestData = [Xtrain1(Test_Fold_class1,:);
            Xtrain2(Test_Fold_class2,:)];
            LabelsTestData = [zeros(length(Test_Fold_class1),1);
            ones(length(Test_Fold_class2),1)];
        end
end