function [Confusion_Matrix]=myWeightedKnn(TrainData,TestData,LabelsTrainData,LabelsTestData,Labels,k,Confusion_Matrix)
%Ntagiou Anna 432
%{
This function calculates the distance between TestData and TrainData, 
finds the neighbors 
and calculates the predicted class of every instance of TestData
%}

[m,n]=size(TestData);                                                       %Dimensions of matrix TestData
[j,l]=size(TrainData);                                                      %Dimensions of matrix TrainData
Distances=zeros(j,m);                                                       %Initialization of matrix Distances JxM
for i=1:m                                                                   %in which algorithm will have the euclidean distance
    for z=1:j
        V=0;
        for a=1:(l-1)
            V=V+(TestData(i,a) - TrainData(z,a))^2;                         %Calculation of V=(y1-x1)^2+(y2-x2)^2+...(yn-xn)^2
        end
        Distances(z,i) = sqrt(V);                                           %Calculation of square root of V
    end
end
[Distances_sort,Index]=sort(Distances,1);                                   %Sorts matrix Distances per column and saveing the indexes

NNeighbors=zeros(k,l+1,m);                                                  %Initialization of matrix NNeighboors KxLxM      
for i=1:m                                                                   %who has the instances of k-nearests neighbors                
    for h=1:k                                                               %For example, NNeighbors(2,:,3) has got the 2nd nearest 
        NNeighbors(h,1:l,i)=TrainData(Index(h,i),1:l);                      %neighbor of 3rd instance
        NNeighbors(h,l+1,i)=Distances_sort(h,i);                            %NNeighbors(:,l+1,:) has got the euclidean distance
    end
end

PreLabelsTestData=zeros(1,m);                                               %Initialization of matrix PreLabelsTestData 
for i=1:m                                                                   %who has the predicted classes
    counter0=0;
    counter1=0;
    for h=1:k                                                               %Counts the distances of class=2(counter0) 
        if NNeighbors(h,10,i)==2                                            %and class=4(counter1) of k-nearests neighbors
            counter0=counter0+NNeighbors(h,l+1,i);
        elseif NNeighbors(h,10,i)==4
            counter1=counter1+NNeighbors(h,l+1,i);
        end
    end
    if counter1>counter0                                                    %if counter1>counter0 the predicted class of Test_Data(i)
        PreLabelsTestData(i)=1;                                             %instance is 1(class=4) else the predicted class is 0
    end                                                                     %by initialization of matrix PreLabelsTestData 
end

for i=1:m                                                                   %Calculates the TP,FP,TN,FN
    if LabelsTestData(i)==PreLabelsTestData(i) && LabelsTestData(i)==0
        Confusion_Matrix(1,1)=Confusion_Matrix(1,1)+1;                      %TP:True Positive
    elseif LabelsTestData(i)==PreLabelsTestData(i) && LabelsTestData(i)==1
        Confusion_Matrix(2,2)=Confusion_Matrix(2,2)+1;                      %TN:True Negative
    elseif LabelsTestData(i)~=PreLabelsTestData(i) && LabelsTestData(i)==0
        Confusion_Matrix(1,2)=Confusion_Matrix(1,2)+1;                      %FN:False Negative
    elseif LabelsTestData(i)~=PreLabelsTestData(i) && LabelsTestData(i)==1
        Confusion_Matrix(2,1)=Confusion_Matrix(2,1)+1;                      %FP:False Positive
    end
end

end