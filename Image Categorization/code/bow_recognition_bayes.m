function label = bow_recognition_bayes( histogram, vBoWPos, vBoWNeg)

    [muPos sigmaPos] = computeMeanStd(vBoWPos);
    [muNeg sigmaNeg] = computeMeanStd(vBoWNeg);

    % Calculating the probability of appearance each word in observed histogram
    % according to normal distribution in each of the positive and negative bag of words
    pHistCar = 0;
    for i=1:length(histogram)
        p = log(normpdf(histogram(i), muPos(i), sigmaPos(i)));
        if isnan(p) ~= 1
            pHistCar = pHistCar + p;
        end
    end
    pHistCar = exp(pHistCar);
    
    pHistNotCar = 0;
    for i=1:length(histogram)
        p = log(normpdf(histogram(i), muNeg(i), sigmaNeg(i)));
        if isnan(p) ~= 1
            pHistNotCar = pHistNotCar + p;
        end
    end
    pHistNotCar = exp(pHistNotCar);
    
    pCar = 0.5;
    pNotCar = 0.5;
    
    if (pHistCar * pCar) > (pHistNotCar * pNotCar)
        label = 1;
    else
        label = 0;
    end
    
end