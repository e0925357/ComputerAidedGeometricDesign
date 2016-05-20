function [ d ] = approximateDataHoschek( p, u, lambda, n, k, tol, maxIter  )
%APPROXIMATEDATAHOSCHEK Approximate 2xm data p with B-spline of degree n with knot
%vector u, k control points and smoothing factor lambda and performs
%Hoschek parameter correction until the error vector is orthogonal to
%spline curve in a up to tolerance tol

% Initial spline curve
d = approximateData(p, u, lambda, n, k);
s = pureDeBoor(u, n, d, u);

% Error
sPrime = evalSplinePrime(u, n, u, d);
sPrimeNorm = sqrt(sum(sPrime.^2, 1));
sPrimeNormalized = sPrime./ repmat(sPrimeNorm,2,1);
v = p - s;
vNorm = sqrt(sum(v.^2, 1));
vNormalized = v./ repmat(vNorm,2,1);

% Count interation
it = 0;

while (~isempty(dot(vNormalized,sPrimeNormalized,2)>tol) && it < maxIter)
    
    % Calculate new parameters
    h = (dot((p-s),sPrime,1)) ./ sPrimeNorm;
    uNew = u + h;
    uNew = (uNew - uNew(1) )/ ( uNew(end) - uNew(1));
    
    % Approximate data with corrected parameters
    d = approximateData(p, uNew, lambda, n, k);
    s = pureDeBoor(uNew, n, d, uNew);
    
    % Calculate new error
    sPrime = evalSplinePrime(uNew, n, uNew, d);
    sPrimeNorm = sqrt(sum(sPrime.^2, 1));
    sPrimeNormalized = sPrime./ repmat(sPrimeNorm,2,1);
    v = p - s;
    vNorm = sqrt(sum(v.^2, 1));
    vNormalized = v./ repmat(vNorm,2,1);
    
    % Prepare next iteration
    u = uNew;
    it = it +1;

end

end

function sPrime =  evalSplinePrime(u, n, t, d)
    k = size(d, 2);
    numPoints = size(t,2);
    sPrime = zeros(2,numPoints);

    for p = 1:numPoints
        
        % Forward operator
        for i = 1:k-1
            sPrime(:,p) = sPrime(:,p) + evaluateBsplineBasis(u, n, i, t(p)) * (d(:,i+1) - d(:,i)) ;
        end 
        
        % Last curve point: backward operator
        sPrime(:,p) = sPrime(:,p) + evaluateBsplineBasis(u, n, k, t(p)) * (d(:,k) - d(:,k-1)) ;
    end
end
