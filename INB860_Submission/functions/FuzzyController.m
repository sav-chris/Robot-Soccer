function centroid = FuzzyController(membershipFuncA, membershipFuncB, M, outputMembershipFunction, A, B, lower, upper, delta )

[n m] = size(M);
outputClasses = length(outputMembershipFunction);
%Error checking

if length(membershipFuncA) ~= m
    error('dimension of membershipFuncA does not match decision matrix');
end

if length(membershipFuncB) ~= n
    error('dimension of membershipFuncB does not match decision matrix');
end

Weights = zeros(n, m); %initialise wieghts matrix, same dimensions as M
categoriesedWeights = cell(1, outputClasses);

membershipA = FuzzyClassify(membershipFuncA, A); % length m
membershipB = FuzzyClassify(membershipFuncB, B); % length n
%Choose the minimum weight
for i = 1:m  %horizontal along M
    for j = 1:n  %vertical along M
        Weights(j, i) = min(membershipA(i), membershipB(j));
        
        index = M(j,i);
        categoriesedWeights{index} = [categoriesedWeights{index}, Weights(j,i)];
    end;
end;

cutOff = zeros(1, outputClasses);
for index = 1:outputClasses
    category = categoriesedWeights{index}; 
    if isempty(category)
        category = 0;
    end;
    cutOff(index) = max(category); %norm
end;

%Chop off the membership functions
evaluateWithCutOffs = @( outputMembershipFunctions, cutOffs, x) min(FuzzyClassify(outputMembershipFunctions, x), cutOffs);
%Collect the membership functions into one function
totalOutputAreaFunction = @(x) max(evaluateWithCutOffs(outputMembershipFunction, cutOff, x));

count = 1;
y = zeros(1, round((upper - lower)/ delta));
px = zeros(1, round((upper - lower)/ delta));
for ticks = lower:delta:upper
    px(count) = ticks;
    y(count) = totalOutputAreaFunction(ticks);
    count = count + 1;
end;
%plot(px, y); %plot for debugging

centroid = (px*transpose(y))/sum(y);


