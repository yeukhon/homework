% CSC 301 Scientific Computing Fall 2012
% Author:   Yeukhon Wong
% Homework #4
% Problem 1

function [s_appx, s_exp, s_e, s_bound_flag, s_n, s_h] = CompSimp(f, a, b, bound)
% Use Composite Simpson's Rule to determines
% the ideal number of intervals reuired
% to approximate input function f to within
% input bound, as well as the value of the 
% approximation and the expected, and value of error.
%
% Parameters:
%      f:  sym
%        the function to approximate
%      a, b : num
%        the start and end point of the integration, respectively
%      bound : num
%        the numeric range of acceptance of the approximation
% Usage:
%     [s_appx, s_exp, s_e, s_bound_flag, s_n, s_h] =  CompSimp(f, a, b, bound)

% first, find the fourth derivative of f and determine the f^4(mu) in
% the interval mu = [a, b]
% Note we don't step over the entire interval to find mu which is bad. It's
% okay for now...
format LONGE;
f_4 = diff( diff( diff( diff(f) ) ) );
f4_mu_a = subs(f_4, {'x'}, {a});
f4_mu_b = subs(f_4, {'x'}, {b});
f4_mu_mid = subs(f_4, {'x'}, {(a+b)/2});
f4_mu = max( [f4_mu_a, f4_mu_mid, f4_mu_b] );

% next, find the step length h
% remember E_simp is |(b-a) f^4(mu) h^4)/180| <= acceptance bound
top = bound * 180;
bottom = (b-a) * f4_mu;
s_h = (top / bottom)^(1/4);

% s_n is s_h = (b-a)/s_n where s_n is even.
% since s_n is even # of intervals, it can also be written as (b-a)/2*m
s_n = (b-a)/s_h;

% finally, fix s_n so it becomes even and ceiling
ns = [ ceil(s_n) ceil(s_n)+1 ceil(s_n)+2];
ns_mod = mod(ns, 2);
[v, i] = min(ns_mod); % locates the first even point
s_n = ns(i);  % given the first even point, lookup the ceil(..) in ns

%%
% let us now find the value of the approximation
% since matlab is based-1, the formula
s_appx = double(CompositeSimpson(inline(f), a, b, s_n)); % approximation
s_exp = double(int(f, a, b));  % expected value
s_e = double(abs(s_exp - s_appx));  % error value
s_bound_flag = s_e <= bound;