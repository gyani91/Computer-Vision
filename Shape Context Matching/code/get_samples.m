function [X_nsamp] = get_samples(X,nsamp)
    index = randperm(max(size(X)));
    X_nsamp = X(index(1:nsamp),:);
end