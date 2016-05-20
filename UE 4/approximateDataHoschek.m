function [ d ] = approximateDataHoschek( p, u, lambda, n, k, tol  )
%APPROXIMATEDATAHOSCHEK Approximate 2xm data p with B-spline of degree n with knot
%vector u, k control points and smoothing factor lambda and performs
%Hoschek parameter correction until the error vector is orthogonal to
%spline curve in a up to tolerance tol

% Initial spline curve
d = approximateData(p, u, lambda, n, k);
s = pureDeBoor(u, n, d, u);

% Error
sPrime = evalSplinePrime(u, n, u, d);
v = p - s;

while (~isempty(dot(v,sPrime,2)>tol))
    
    % Calculate new parameters
    sPrimeNorm = repmat(sqrt(sum(sPrime.^2, 1)), 2,1);
    h = (dot((p-s),sPrime,2)) ./ sPrimeNorm;
    uNew = u + h;
    uNew = (uNew - uNew(1) )/ ( uNew(end) - uNew(1));
    
    % Approximate data with corrected parameters
    d = approximateData(p, uNew, lambda, n, k);
    s = pureDeBoor(uNew, n, d, uNew);
    
    % Calculate new error
    sPrime = evalSplinePrime(uNew, n, uNew, d);
    v = p - s;
    
    u = uNew;

end

end

function sPrime =  evalSplinePrime(u, n, t, d)
    k = size(d, 2);
    numPoints = size(t,2);
    sPrime = zeros(2,numPoints);

    for p = 1:numPoints
        for i = 1:k-1
            sPrime(:,p) = sPrime(:,p) + evaluateBsplineBasis(u, n, i, t(p)) * (d(:,i+1) - d(:,i)) ;
        end 
    end
end
