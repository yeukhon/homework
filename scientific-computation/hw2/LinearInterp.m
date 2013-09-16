% CSC 301 Scientific Computing Fall 2012
% Author:   Yeukhon Wong
% Homework #1
% Problem 2

% Degree one interpolation.

function [appx,exact,err] = LinearInterp(fn, x0, x1, x, y0, y1)
% Interpolate the function fn at x given 
% two sets of points (x0, y0), (x1, y1).
% x0 and x1 must be provided as a minimally requirement.
% 
% appx the value of the interpolation
% exact the value of the computation using fn
% err the interpolation error
%
% Usage:
%     [appx,exact,err] =  LinearInterp(fn, x0, x1, x)
%     [appx,exact,err] =  LinearInterp(fn, x0, x1, x, y0)
%     [appx,exact,err] =  LinearInterp(fn, x0, x1, x, y0, y1)

if nargin < 5
    y0 = feval(fn, x0);
    y1 = feval(fn, x1);
elseif nargin < 6
    y1 = feval(fn, x1);
end

left = (y0 * ( (x1 - x)/ (x1 - x0) ));
right = (y1 * ( (x - x0)/ (x1 - x0) ));
appx = left + right;

exact = feval(fn, x);
err = exact - appx;