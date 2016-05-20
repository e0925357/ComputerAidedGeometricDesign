function [ bt ] = pureDeBoor( knots, n, d, evalPoints )
%DEBOOR Compute B-spline curve and  d using de Boor's algorithm
% knots      ...    knot vector 
% n          ...    degree
% d          ...    control points
% evalPoints ...    parameter values where curve is evaluated

% Init
dim = size(d, 1);
numPoints = size(evalPoints, 2);
numControl = size(d, 2);
numKnots = size(knots,2);

% Find respective intervall
[~,bin] = histc(evalPoints, knots);

% De Boor Points
dBoor = zeros(dim, numControl, n+1);
dBoor(:,:,1) = d;

% B-spline curve evaluated at evalPoints
bt = zeros(dim, numPoints);

% Evaluate curve points
for k = 1:numPoints
    
    % Get parameter
    u = evalPoints(k);
    
    % Get respective interval
    l = bin(k) - 1; % index shift s.t. first bin has index 0
    
    % Special case u=1:
    if (u==1)
        for i=1:numControl
            bt(:,k) = bt(:,k) + evaluateBsplineBasis(knots, n, i, 1);
        end
        
        continue;
    end
    
    % Skip points that are out of range
    if (l - n < 0 || l+n+1 > numKnots || l+1 > numControl)
        bt(:, k) = NaN;
        continue;
    end
       
    % Calculate deBoor points
    for r = 1:n
        % Iterate over affected control points
        for i = l-n+r+1:l+1;
            ai = (u - knots(i) )/ (knots(i+n+1-r) - knots(i));
            dBoor(:,i,r+1) = (1 - ai)*dBoor(:,i-1, r) + ai*dBoor(:,i, r);
        end
    end
    
    % Store curve point
    bt(:,k) = dBoor(:,l+1,n+1);   
    
end

end
