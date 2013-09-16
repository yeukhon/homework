% CSC 301 Scientific Computing Fall 2012
% Author:   Yeukhon Wong
% Homework #4
% Problem 1

function [gq_appx, gq_exp, gq_e, gq_bound_flag, gq_n] = CompGaussQaud( f, a, b, bound, m)
% Use Composite Gaussian quadrature to determines
% the ideal number of intervals reuired
% to approximate input function f to within
% input bound, as well as the value of the 
% approximation and expected, and value of error.
%
% Parameters:
%      f:  sym
%        the function to approximate
%      a, b : num
%        the start and end point of the integration, respectively
%      bound : num
%        the numeric range of acceptance of the approximation
%      m  : num
%       number of points to use
% Usage:
%     [t_appx, t_exp, t_e, t_bound_flag, t_n, t_h] =  CompGaussQaud(f, a, b, bound, m)
format longe;

[w,x] = GLWeights(m);
tildec = (b-a)/2*w;
tildex = (b-a)/2*x + (b+a)/2;
fx = subs(f, {'x'}, {tildex});
gq_appx = sum(tildec.*fx);

gq_exp = double(int(f, a, b));
gq_e = abs(gq_exp - gq_appx);
gq_bound_flag = gq_e < bound;
gq_n = m-1;
end

