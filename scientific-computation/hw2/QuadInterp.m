% CSC 301 Scientific Computing Fall 2012
% Author:   Yeukhon Wong
% Homework #2
% Problem 2

% Degree-two interpolation

function [appx,exact,err] = QuadInterp(fn, x0, x1, x2, x, y0, y1, y2)
% Interpolate the function fn at x given 
% three sets of points (x0, y0), (x1, y1), (x2, y2).
% x0, x1, x2 must be provided as a minimally requirement.
% 
% appx the value of the interpolation
% exact the value of the computation using fn
% err the interpolation error
%
% Usage:
%     [appx,exact,err] =  LinearInterp(fn, x0, x1, x2, x)
%     [appx,exact,err] =  LinearInterp(fn, x0, x1, x2, x, y0)
%     [appx,exact,err] =  LinearInterp(fn, x0, x1, x2, x, y0, y1)
%     [appx,exact,err] =  LinearInterp(fn, x0, x1, x2, x, y0, y1, y2)

if nargin < 6
    y0 = feval(fn, x0);
    y1 = feval(fn, x1);
    y2 = feval(fn, x2);
elseif nargin < 7
    y1 = feval(fn, x1);
    y2 = feval(fn, x2);
elseif nargin < 8
    y2 = feval(fn, x2);
end

L0 = ((x - x1) * (x - x2)) / ((x0 - x1)*(x0 - x2));
L1 = ((x - x0) * (x - x2)) / ((x1 - x0)*(x1 - x2));
L2 = ((x - x0) * (x - x1)) / ((x2 - x0)*(x2 - x1));

appx = y0 * L0 + y1 * L1 + y2 * L2;

exact = feval(fn, x);
err = exact - appx;