function [ sPrime ] = evalBsplinePrime(T, n, d, t)
%EVALBSPLINEPRIME evaluates the first derivative of the given b-spline at
%the positions t
%   T ... knot vector of the b-spline
%   n ... degree of the b-spline
%   d ... control points of the b-spline
%   t ... evalutaion points as curve parameters.

    k = size(d, 2);
    numPoints = size(t,2);
    sPrime = zeros(2,numPoints);

    for p = 1:numPoints
        
        % Forward operator
        for i = 1:k
            denom1 = T(i+n) - T(i);
            denom2 = T(i+n+1) - T(i+1);
            val1 = 0;
            val2 = 0;
            
            if(denom1 ~= 0)
               val1 = n/denom1 * evaluateBsplineBasis(T, n-1, i, t(p)) * d(:,i);
            end
            
            if(denom2 ~= 0)
               val2 = n/denom2 * evaluateBsplineBasis(T, n-1, i+1, t(p)) * d(:,i);
            end
            
            sPrime(:,p) = sPrime(:,p) + val1 - val2;
        end 
    end


end

