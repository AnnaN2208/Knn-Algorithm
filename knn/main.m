%Ntagiou Anna 432
close all;
clear all;
clc;

fileID = fopen('data.txt','r');
data_str = textscan(fileID,'%s %s %s %s %s %s %s %s %s %s %s','Delimiter',',');
fclose(fileID);

same_class=0;
[m,n]=size(data_str);
[j,l]=size(data_str{1,n});
for i=2:n                                                                   %Runs for all columns of data matrix except from the first
   for z=1:j                                                                %Runs for all rows of column i of data matrix 
       if(data_str{1,i}{z,1}=='?')                                          %Searching for '?' character
           class_empty=data_str{1,11}{z,1};                                 %Saving the class of empty field
           for v=1:j                                                        %Searching for instances who have the same class
               if(data_str{1,11}{v,1}==class_empty)                         %If the class of empty field is the same with the class of v instance
                   if(data_str{1,i}{v,1}~='?')                              %the algorithm saves the value of the column n and instance v
                        same_class(end+1)=str2double(data_str{1,i}{v,1});   %by avoiding the '?' character 
                   end                                                      %and by conversing string to double
               end                                                          %The conversion is because the algorithm needs the mean of instances
           end
           replace_double=round(sum(same_class)/length(same_class));        %Calculation of mean of instances with the same class
           replace = num2str(replace_double);                               %Conversion the replacement value to string 
           data_str{1,i}{z,1}=replace;                                      %Replacement of empty field
           same_class=0;
       end    
   end    
end
                                                    
data=cellfun(@str2double,data_str(1,2:11),'un',0);                          %There aren't any '?' characters so the algorithm converts the cell from string to double
data = cell2mat(data);                                                      %Conversion of cell of doubles to matrix 
Labels=data(:,10);                                                          %Placing the 10th column of data to Labels matrix
c0=1;
c1=1;
for i=1:length(data)                                                        %Searching of instances of every class
    if data(i,10)==2                                                        
        class0(c0,:)=data(i,:);                                             %the array class0 has the instances of class=2
        c0=c0+1;
    elseif data(i,10)==4 
        class1(c1,:)=data(i,:);                                             %the array class1 has the instances of class=4
        c1=c1+1;
    end
end
%{
Because of the very long data the algorithm needs to print, it asks for the classification method.
Case 1 is for Cross Validation with folds=10
Case 2 is for Percentance Split 66 that is 33% Test Data and 66% Train Data
Caes 3 is for Leave one out
%}
Precision=zeros(1,8);                                              %Initialization of matrix Precision
Precision_Class0=zeros(1,8);                                       %Initialization of matrix Precision_Class0
Precision_Class1=zeros(1,8);                                       %Initialization of matrix Precision_Class1
Sensitivity=zeros(1,8);                                            %Initialization of matrix Sensitivity
Specificity=zeros(1,8);                                            %Initialization of matrix Specificity
time_to_execute=zeros(1,8);                                        %Initialization of matrix time_to_execute 
        
prompt = 'Please select one of the following methods for kNN algorithm.\n1:Cross Validation with folds=10\n2:Percentance Split 66\n3:Leave one out\n';
method = input(prompt);
switch method
    case 1
        disp('--------------------------------------------------------------------');
        fprintf( 'Summary of method Cross Validation with folds=10\n');
        disp('--------------------------------------------------------------------');
        for k=1:2:15                                                        %When k is odd number,the algorithm gives better results
        index=round(k/2);                                                   %Variable index helps for creating matrixes without empty fields (converts k=1,3,5,7... to 1,2,3,4...)
        tic                                                                 %Start of timer
        Confusion_Matrix=zeros(2);                                          %Initialization of matrix Confusion_Matrix
            for n=1:10                                                      %Runs for N folds (N=10)
                [TrainData,TestData,LabelsTrainData,LabelsTestData] = cross(class0,class1,method);                      %Call cross function
                [Confusion_Matrix]=mykNN(TrainData,TestData,LabelsTrainData,LabelsTestData,Labels,k,Confusion_Matrix);  %Call mykNN function
            end
        [Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity] = summary( Confusion_Matrix,index,Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity ); %Call summary function
        time_to_execute(index)=toc;                                         %Stop of timer
        end
        plots(k,time_to_execute,Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity);
        [Max_Precision,Best_k]=max(Precision);                              %Finds the best k value based on precision 
        fprintf('\n\n');
        disp('====================================================================');
        fprintf( 'The best k parameter for method Cross Validation with folds=10 is %d\n',(Best_k*2)-1);
        disp('====================================================================');
        fprintf('\n\n');
    case 2
        disp('--------------------------------------------------------------------');
        fprintf( 'Summary of method Percentance Split 66 \n');
        disp('--------------------------------------------------------------------');
        for k=1:2:15                                                        %When k is odd number,the algorithm gives better results
        index=round(k/2);                                                   %Variable index helps for creating matrixes without empty fields (converts k=1,3,5,7... to 1,2,3,4...)
        tic                                                                 %Start of timer
        Confusion_Matrix=zeros(2);                                          %Initialization of matrix Confusion_Matrix
            for n=1:3                                                       %Runs for N folds (N=3)
                [TrainData,TestData,LabelsTrainData,LabelsTestData] = cross(class0,class1,method);                      %Call cross function
                [Confusion_Matrix]=mykNN(TrainData,TestData,LabelsTrainData,LabelsTestData,Labels,k,Confusion_Matrix);  %Call mykNN function
            end
        [Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity] = summary( Confusion_Matrix,index,Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity ); %Call summary function
        time_to_execute(index)=toc;                                         %Stop of timer
        end
        plots(k,time_to_execute,Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity);
        [Max_Precision,Best_k]=max(Precision);                              %Finds the best k value based on precision 
        fprintf('\n\n');
        disp('====================================================================');
        fprintf( 'The best k parameter for method Percentance Split 66 is %d\n',(Best_k*2)-1);
        disp('====================================================================');
        fprintf('\n\n');
    case 3
        disp('--------------------------------------------------------------------');
        fprintf( 'Summary of method Leave one out\n');
        disp('--------------------------------------------------------------------');
        for k=1:2:15                                                        %When k is odd number,the algorithm gives better results
        index=round(k/2);                                                   %Variable index helps for creating matrixes without empty fields (converts k=1,3,5,7... to 1,2,3,4...)
        tic                                                                 %Start of timer
        Confusion_Matrix=zeros(2);                                          %Initialization of matrix Confusion_Matrix
            for n=1:length(data)                                            %Runs for N folds (N=length(data)=699)
                [TrainData,TestData,LabelsTrainData,LabelsTestData] = cross(class0,class1,method);                              %Call cross function
                [Confusion_Matrix]=mykNN(TrainData,TestData,LabelsTrainData,LabelsTestData,Labels,k,Confusion_Matrix);  %Call mykNN function
            end
        [Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity] = summary( Confusion_Matrix,index,Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity ); %Call summary function
        time_to_execute(index)=toc;                                         %Stop of timer
        end
        plots(k,time_to_execute,Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity);
        [Max_Precision,Best_k]=max(Precision);                              %Finds the best k value based on precision 
        fprintf('\n\n');
        disp('====================================================================');
        fprintf( 'The best k parameter for method Leave one out is %d\n',(Best_k*2)-1);
        disp('====================================================================');
        fprintf('\n\n');
        
end




