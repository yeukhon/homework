% Modified by student; adapated from textbook


function  [nTotal, numI] = AdaptQNC(fname, a, b, n, m, tol, left, right)
% [nTotal, numI] = AdaptQNC(fname, a, b, n, m, tol, left, right)
%
% Integrates a function from a to b 
% fname is a string that names an available function of the form f(x) that 
% is defined on [a,b]. f should return a column vector if x is a column vector.
% a,b are real scalars, m is an integer that satisfies 2 <= m <=11, and
% tol is a positive real.
%
% numI is a composite m-point Newton-Cotes approximation of the 
% integral of f(x) from a to b, with the abscissae chosen adaptively. 

format longe; 
A1 = CompositeSimpson(inline(fname),a,b,8); % we assume this is better
A2 = CompositeSimpson(inline(fname),a,b,n);
d = 2*floor((m-1)/2)+1;
error = (A2-A1)/(2^(d+1)-1);
if abs(error) <= tol
   % A2 is acceptable
   numI = A2+error;
   nTotal = left + right;
else
   % Sum suitably accurate left and right integrals
   mid = (a+b)/2;
   [nL, numIL] = AdaptQNC(fname,a,mid,n,m,tol/2,left+1, right);
   [nR, numIR] = AdaptQNC(fname,mid,b,n,m,tol/2, left, right+1);
   numI = numIL + numIR;
   nTotal = nL + nR;
end

end