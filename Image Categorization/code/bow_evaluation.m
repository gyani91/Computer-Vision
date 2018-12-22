%
% BAG OF WORDS RECOGNITION EXERCISE
%
clear; close all;
%training
disp('creating codebook');
sizes = (120:40:280);
numTests = 4;
for sizeCodebook = (120:40:320)
    sum_nn_accuracies = 0;
    sum_bayes_accuracies = 0;
    for test = 1:numTests
        rng(test);
        numIterations = 10;
        vCenters = create_codebook('../data/cars-training-pos',sizeCodebook,numIterations);
        %keyboard;
        disp('processing positve training images');
        vBoWPos = create_bow_histograms('../data/cars-training-pos',vCenters);
        disp('processing negative training images');
        vBoWNeg = create_bow_histograms('../data/cars-training-neg',vCenters);
        %vBoWPos_test = vBoWPos;
        %vBoWNeg_test = vBoWNeg;
        %keyboard;
        disp('processing positve testing images');
        vBoWPos_test = create_bow_histograms('../data/cars-testing-pos',vCenters);
        disp('processing negative testing images');
        vBoWNeg_test = create_bow_histograms('../data/cars-testing-neg',vCenters);

        nrPos = size(vBoWPos_test,1);
        nrNeg = size(vBoWNeg_test,1);

        test_histograms = [vBoWPos_test;vBoWNeg_test];
        labels = [ones(nrPos,1);zeros(nrNeg,1)];
        
        sum_nn_accuracies = sum_nn_accuracies + bow_recognition_multi(test_histograms, labels, vBoWPos, vBoWNeg, @bow_recognition_nearest);

        sum_bayes_accuracies = sum_bayes_accuracies + bow_recognition_multi(test_histograms, labels, vBoWPos, vBoWNeg, @bow_recognition_bayes);
        
    end
    disp('______________________________________')
    disp(strcat('Size of Codebook : ', num2str(sizeCodebook)));
    disp('______________________________________')
    disp('Nearest Neighbor classifier')
    disp(sum_nn_accuracies/numTests);
    disp('______________________________________')
    disp('Bayesian classifier')
    disp(sum_bayes_accuracies/numTests);
    disp('______________________________________')
end
