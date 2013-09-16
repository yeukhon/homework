function [ f ] = PolyInNewtonForm( C, X )

c_len = length(C);
x_len = length(X);

sym x;
f = strcat(num2str(c_len(1)));

str1 = '(x-{d})';
str2 = '*';
str3 = '+';
if c_len > 1
    for i=1:c_len
        f = strcat( f, str3, repmat(str1, [1, i]));
        for j=1:i
            f = regexprep(f, '{d}', num2str(C(j)), j);
        end
    end
    
end
        %sub = strcat( num2str(C(i)), str3, 
f = sym(subX)    
end

