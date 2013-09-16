% CSC 301 Scientific Computing Fall 2012
% Author:   Yeukhon Wong
% Homework #1
% Problem P1.3.2 (p.40)

clear all;
clc;

% given number of trials 100, step 100, up to 800
% step through as a vector of size (number of trials)
disp('    n                Uniform                Normal            ')
for n = 100:100:800
    coeffs = rand(n,3); % a,b,c for 100 times  [100 by 3]
    complexes = zeros(n,1);
    % for each n-th trial, determines b^2 - 4*a*c < 0 and record the result
    for i = 1:1:n
        % the result will be 1 if it is less than zero (true statement)
        complexes(i) = (coeffs(i, 2).^2 - 4*coeffs(i, 1) * coeffs(i, 3)) < 0;  
    end
    prob_uni = sum(complexes)/n;
    
    coeffs = randn(n,3);
    complexes = zeros(n,1);
    for i = 1:1:n
        complexes(i) = (coeffs(i, 2).^2 - 4*coeffs(i, 1) * coeffs(i, 3)) < 0;
    end
    prob_norm = sum(complexes)/n;
    fprintf('    %3d                %3f                %3f            \n', n, prob_uni, prob_norm)
end