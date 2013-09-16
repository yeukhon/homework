% Yeukhon Wong 8066
% CSC 301 Fall 2012
% Homework #4.  Problem 2

% Determine the number of subintervals used for each function
% using adaptive quadrature to approximate
% 1) sin(1/x) and 2) cos(1/x) from 0.1 to 2 to within 10^-3 bound.

format LONGE;

% create a symbolic equation as input to the functions below
sym x;
f1 = sym('sin(1.0/x)');
f2 = sym('cos(1.0/x)');
a = 0.100000;
b = 2.000000;
bound = 10^-3;
n = 2;
m = 3;

[f1_n, f1_appx] = AdaptQNC(f1, a, b, 2*n, m, bound, 0, 0); 

[f2_n, f2_appx] = AdaptQNC(f2, a, b, 2*n, m, bound, 0, 0);
f1_exp = double(int(f1, a, b));
f2_exp = double(int(f2, a, b));

[f1Q, f1Count] = quad(inline(f1), a, b, bound);
[f2Q, f2Count] = quad(inline(f2), a, b, bound);

f1_e = abs(f1_appx-f1_exp);
f2_e = abs(f2_appx-f2_exp);

% tabular prints
fprintf('===================================================================================================\n')
fprintf('   func         appx         expect         error         accept(0/1)     subintervals     expect n\n')
fprintf('---------------------------------------------------------------------------------------------------\n')
fprintf('  %s   %2.8f     %2.8f     %2.8f         %d                %d           %d\n', 'sin(1/x)', f1_appx, f1_exp, f1_e, f1_e<=10^-3, f1_n, f1Count)
fprintf('---------------------------------------------------------------------------------------------------\n')
fprintf('  %s   %2.8f     %2.8f     %2.8f         %d                %d           %d\n', 'cos(1/x)', f2_appx, f2_exp, f2_e, f2_e<=10^-3, f2_n, f2Count)
fprintf('===================================================================================================\n')

% plot f(x) and g(x)
figure 
ezplot(f1, [0.1, 2])
figure 
ezplot(f2, [0.1, 2])