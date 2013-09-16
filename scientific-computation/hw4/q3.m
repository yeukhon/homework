% CSC 301 Scientific Computing Fall 2012
% Author: Yeukhon Wong
% Homework #4
% Problem P3

% Re-use the code I did for homework #2 problem 1

clc;
clear all;

% these symbols are placeholder for symbolic solution (I learned this when
% I was a freshman ...)
syms a b c d

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [ 1   1   0   0  ]    [ a ]    [ 2 ]
% [ -1  1   1   1  ]    [ b ]  = [ 2 ]
% [ 1   1   -2  -2 ]    [ c ]    [ 2/3 ]
% [-1   1   3   3  ]    [ d ]    [ 0 ]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following code works on MATLAB 2012A, 2012B
%M = [1 1 0 0 ; -1 1 1 1; 1 1 -2 2; -1 1 3 3];
%t = [a b c d]';
%rs = [2 0 2/3 0]';
%sol = solve(M * t == rs);
%pretty(sol)

% Older version can solve it by
sol = solve('a+b+0*c+0*d=2','-1*a+1*b+c+d=0', '1*a+1*b-2*c+2*d=2/3', '-1*a+1*b+3*c+3*d=0');

disp('the results are: \n')
fprintf('a = %3.3f, b = %3.3f, c = %3.3f, d = %3.3f\n', double(sol.a), double(sol.b), double(sol.c), double(sol.d))
