function [ bt ] = bSplinePoint( knots, n, d, evalPoints )
%BSPLINEPOINT Summary of this function goes here
%   Detailed explanation goes here
% Init
dim = size(d, 1);
numPoints = size(evalPoints, 2);
numControl = size(d, 2);

% B-spline curve evaluated at evalPoints
bt = zeros(dim, numPoints);

% Evaluate curve points
for k = 1:numPoints
    % Get parameter
    u = evalPoints(k);
    
    for i=1:numControl
        eval = evaluateBsplineBasis(knots, n, i, u)*d(:, i);
        eval(isnan(eval)) = 0;
        bt(:,k) = bt(:,k) + eval;
    end
end

end

