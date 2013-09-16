% Yeukhon Wong 8066
% CSC 301 Fall 2012
% Homework #4.  Problem 1

% Determine the number of intervals required to approximate
% integral(1/(x+4)) from 0 to 2 to within 10^-5 and compute
% the approximation:
% a) composite trapezoidal rule;
% b) composite simpson's rule;
% c) composite gaussian quadrature rule

format LONGE;
% create a symbolic equation as input to the functions below
sym x;
f = sym('1/(x+4)');
a = 0;
b = 2;
bound = 10^-5;

% these function calls returns
% appx value, expected value, error value, within bound, number of
% intervals, and the step size h
[t_appx, t_exp, t_e, t_bound_flag, t_n, t_h] = CompTrapez(f, a, b, bound);
[s_appx, s_exp, s_e, s_bound_flag, s_n, s_h] = CompSimp(f, a, b, bound);

% For Gauss Qaud we are going to find the first m that makes within bound
for m=2:6
    [gq_appx, gq_exp, gq_e, gq_bound_flag, gq_n] = CompGaussQaud( f, a, b, bound, m);
    if gq_bound_flag == 1, break, end
end

% tabular prints
fprintf('===============================================================================================\n')
fprintf('   method         appx         expect         error         accept(0/1)   # of n     step size  \n')
fprintf('-----------------------------------------------------------------------------------------------\n')
fprintf('  %s    %2.8f     %2.8f     %2.8f         %d          %d         %2.5f\n', 'CompTrapez', t_appx, t_exp, t_e, t_bound_flag, t_n, t_h)
fprintf('-----------------------------------------------------------------------------------------------\n')
fprintf('  %s    %2.8f     %2.8f     %2.8f         %d           %d         %2.5f\n', 'CompSimpsn', s_appx, s_exp, s_e, s_bound_flag, s_n, s_h)
fprintf('-----------------------------------------------------------------------------------------------\n')
fprintf('  %s   %2.8f     %2.8f     %2.8f         %d           %d         %s\n', 'CompGauQaud', gq_appx, gq_exp, gq_e, gq_bound_flag, gq_n, 'unknown')
fprintf('===============================================================================================\n')

