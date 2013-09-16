% Problem 1 # helper

function [A, xs, cubicY, c] = CubicSpline( X, Y )

A = spline(X,Y);
c = A.coefs(3,:); 
xs = linspace(X(1), X(length(X)));
cubicY = ppval(A, X);

end

