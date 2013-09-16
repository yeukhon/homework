% CSC 301 Scientific Computing Fall 2012
% Author: Yeukhon Wong
% Homework #2
% Problem P1

clc;
clear all;

% these symbols are placeholder for symbolic solution (I learned this when
% I was a freshman ...)
syms y a2 a3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [ 0.5  0.25  0.125  ]    [ a2 ]    [ y ]
% [  1     1     1    ]    [ a3 ]  = [ 3 ]
% [  2     4     8    ]    [ 6  ]    [ 2 ]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = [0.5 0.25 0.125; 1 1 1; 2 4 8];
t = [a2 a3 6]';
rs = [y 3 2]';

% the solve(...) function will solve symbolic equations
% see help solve
sol = solve(M * t == r);
disp('the results are: \n')
fprintf('%3.3f, %3.3f, %3.3f, %3.3f, %3.3f', 0.00, sol.a2, sol.a3, 6.00, sol.y)

% Acknowledgement
% I found solve(...) myself. But I didn't know how to use the '==' operator
% properly so that I could equate the solution (rs) to the equations.
% I ended up getting help from someone online. But I did the verification
% on paper by hand before I did the coding.

% This is my question.
% http://stackoverflow.com/questions/12827411/solving-for-the-coefficent-of-linear-equations-with-one-known-coefficent