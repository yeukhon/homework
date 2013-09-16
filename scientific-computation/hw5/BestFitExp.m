% Problem 1 # helper

function soln = BestFitExp( X,Y )

degree = 1;
lny = log(Y); % lny = ln(Y)
soln = BestFitNOrder(X, lny, degree);
end

