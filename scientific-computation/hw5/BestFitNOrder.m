% Problem 1 # helper

function [ soln ] = BestFitNOrder( X,Y,degree )

n = length(X); % number of points

if nargin < 3
    n = length(X);
    degree = 1;
end
order = degree +1;

A = zeros(order); % square matrix
for i=2:order
    for j=1:order
        A(i, j) = sum( X.^(j+i-2) );
    end
end
% now work on the first row
A(1,1) = n;
for j=2:order
    A(1,j) = sum( X.^(j-1) );
end

% now work on the right hand side
B = zeros(order, 1);
for i=0:order-1
    B(i+1,1) = sum( (X.^(i)).*Y);
end    

soln = inv(A)*B;

end

