function [Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity] = summary( Confusion_Matrix,k,Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity )
%Ntagiou Anna 432
TP=Confusion_Matrix(1,1);
FN=Confusion_Matrix(1,2);
FP=Confusion_Matrix(2,1);
TN=Confusion_Matrix(2,2);
Precision_Class0(k)=TP/(TP+FP);
Precision_Class1(k)=TN/(TN+FN);
Precision(k)=(TP+TN)/(TP+FP+TN+FN);
Sensitivity(k)=TP/(TP+FN);
Specificity(k)=TN/(TN+FP);
disp('--------------------------------------------------------------------');
fprintf( 'Parameter k=%d\n',(k*2)-1);
disp('--------------------------------------------------------------------');
fprintf( 'Total number of instances:  %d\n',(TP+FP+TN+FN));
fprintf( 'Precision: \t\t\t\t\t%f\n', Precision(k) );
fprintf( 'Precision of class=2: \t\t%f \n', Precision_Class0(k) );
fprintf( 'Precision of class=4: \t\t%f \n', Precision_Class1(k) );
fprintf( 'Sensitivity: \t\t\t\t%f \n', Sensitivity(k) )
fprintf( 'Specificity: \t\t\t\t%f \n', Specificity(k) )
printmat(Confusion_Matrix, 'Confusion_Matrix', 'CLASS=2 CLASS=4', 'CLASS=2 CLASS=4' );

end

