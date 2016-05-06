function [] = plots(k,time_to_execute,Precision,Precision_Class0,Precision_Class1,Sensitivity,Specificity)
%Ntagiou Anna 432
x=1:2:k;
figure(1)
subplot(2,2,1)
bar(x,time_to_execute);                                            %Graph of execution time for every k
title('Time of execution for every k(1-15)');
subplot(2,2,2)
plot(x,Precision);
title('Precision for every k(1-15)');
subplot(2,2,3)
plot(x,Precision_Class0);
title('Precision of Class0 for every k(1-15)');
subplot(2,2,4)
plot(x,Precision_Class1);
title('Precision of Class1 for every k(1-15)');
figure(2)
subplot(1,2,1)
plot(x,Sensitivity);                                               %Graph of execution time for every k
title('Sensitivity for every k(1-15)');
subplot(1,2,2)
plot(x,Specificity);
title('Specificity for every k(1-15)');
end

