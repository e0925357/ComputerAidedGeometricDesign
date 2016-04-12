function [ y ] = evaluateBsplineBasis( U, degree, t )
%EVALUATEBSPLINEBASIS Evaluates the basis function for all possible points
%in U for the parameter t.

y = zeros(size(U, 2) - degree - 1, 1);

for index = 1 : size(U, 2) - degree - 1;
    y(index) = evaluate(U, index, degree, t);
end
end

function y = evaluate(U, index, degree, t)

if degree <= 0
   if U(index) <= t && U(index + 1) > t
       y = 1;
   else
       y = 0;
   end
else
    denom1 = U(index + degree) - U(index);
    denom2 = U(index + degree + 1) - U(index + 1);
    val1 = evaluate(U, index, degree-1, t);
    val2 = evaluate(U, index + 1, degree - 1, t);
    
    if(denom1 == 0)
        val1 = 0;
    elseif (denom1 ~= 0)
        val1 = val1 * (t - U(index))/denom1;
    end
    
    if(denom2 == 0)
        val2 = 0;
    elseif (denom2 ~= 0)
        val2 = val2 * (U(index + degree + 1) - t)/denom2;
    end
    
    y = val1 + val2;
end
end