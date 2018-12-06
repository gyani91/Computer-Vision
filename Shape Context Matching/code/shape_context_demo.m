%This file runs the shape_classfication function with different value of K

N = 7;
accuracies=zeros(1,N);

for k=1:N
    accuracies(k)=shape_classification(k);
end
disp(accuracies);
