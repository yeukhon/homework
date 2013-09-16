  function result = dot3(x,y)
% result = dot3(x,y)
% x and y are regular numbers. The output is a 3-digit floating point
% number of x * y.
% result is a 3-digit floating point number.

new_x = Represent(x);
new_y = Represent(y);
result = Float(new_x, new_y, '*');