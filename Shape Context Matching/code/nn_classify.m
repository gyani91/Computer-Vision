function [testClass] = nn_classify(matchingCostVector,trainClasses,k)
    % This function finds the k-nearest neighbours matches
    %
    % INPUTS :
    %
    % shape matching costs obtained by matching the test shape
    % to all training shapes, matchingCostVector
    % the class labels of the training shapes, trainClasses
    % number of neighbours to consider, k
    %
    % OUTPUT :
    % class label of the test shape, trainClasses

    [~,sorted_index] = sort(matchingCostVector, 'ascend');
    watches = 0; hearts = 0; forks = 0; 

    for i = sorted_index(1:k)
        if strcmpi(trainClasses(i),'Heart')  
            hearts = hearts+1;
        elseif strcmpi(trainClasses(i),'fork')  
            forks = forks+1;
        elseif strcmpi(trainClasses(i),'watch')  
            watches = watches+1;
        end
    end

    results = [hearts forks watches]; 
    label = {'Heart', 'fork', 'watch'};
    [~, max_index] = max(results);

    testClass = label{max_index};
end




