function [ y ] = evaluateBsplineBasis( U, degree, index, t )
%EVALUATEBSPLINEBASIS Evaluates the basis function for all possible points
%in U for the parameter t.

%Is the degree 0?
if degree <= 0
   %The value is 1 if t is between the knots.
   if U(index) <= t && U(index + 1) > t
       y = 1;
   else
       y = 0;
   end
else
    %Compute the the value based on a recusion
    
    %Check the denominators of the factors - they may be null if the
    %multipizity of the knot is high enought. 
    denom1 = U(index + degree) - U(index);
    denom2 = U(index + degree + 1) - U(index + 1);
    val1 = 0;
    val2 = 0;
    
    if (denom1 ~= 0)
        %Compute the first value recursively
        val1 = evaluateBsplineBasis(U, degree-1, index, t) * (t - U(index))/denom1;
    end
    
    if (denom2 ~= 0)
        %Compute the second value recursively
        val2 = evaluateBsplineBasis(U, degree - 1, index + 1, t) * (U(index + degree + 1) - t)/denom2;
    end
    
    %Combine the values to the final result
    y = val1 + val2;
end
end