function out = FuzzyClassify(X, x)

l = length(X);
out = zeros(1,l);
for i = 1:l
    func = X{i};
    out(i) = func(x);
end;