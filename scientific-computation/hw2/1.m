clear all;

syms y a2 a3

M = [0.5 0.25 0.125; 1 1 1; 2 4 8];
t = [a2 a3 6];
r = [y 3 2];

sol = M\t
sol(1) == y
sol(2) == 3
sol(3) == 2
s1 = solve(sol(1), a2)
s2 = solve(sol(2), a3)
s3 = solve(sol(3), a4)
