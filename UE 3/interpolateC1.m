function [ s, bezierPoints ] = interpolateC1( knots, p, firstDerivatives )
%INTERPOLATEC1 Creates a cubic spline with the given curve points p and
%the firstDerivatives at these points as well as the knot vector.
%   knots            ... the knot vector of the spline
%   p                ... the sample points on the curve
%   firstDerivatives ... the first derivatives of the curve

%Initialize sample points u
u = knots(1) : 0.01 : knots(size(knots, 2));
%allocate space for the resulting curve s
s = zeros(size(p, 1), size(u, 2));
%allocate space for the resulting bezier points
bezierPoints = zeros(size(p, 1), 4, size(knots, 2)-1);
%initialize the current curve segment
nextBorder = knots(2);
currentSegment = 1;

%Compute the bezier points for the first curve segment
bezierPoints = computeBezierPoints(p(:,1), p(:,2), firstDerivatives(:, 1), firstDerivatives(:, 2), knots(2) - knots(1), bezierPoints, currentSegment);

for i = 1 : size(u, 2)
    %Check if we are still in the same curve segment
    while u(i) >= nextBorder && u(i) < knots(size(knots, 2))
        %We are in a different segment -> count up
        currentSegment = currentSegment + 1;
        nextBorder = knots(currentSegment + 1);
        
        %Compute the bezier points for the curve segment
        bezierPoints = computeBezierPoints(p(:,currentSegment), p(:,currentSegment+1), firstDerivatives(:, currentSegment), firstDerivatives(:, currentSegment+1), knots(currentSegment+1) - knots(currentSegment), bezierPoints, currentSegment);
    end
    
    if  u(i) >= knots(size(knots, 2))
        s(:,i) = p(:, size(p, 2)); % handle the special case of u = 1
    else
        %default case
        %compute the current forward difference in the knot vector
        dI = knots(currentSegment+1) - knots(currentSegment);
        %compute the parameter t relative to the current curve segment
        t = (u(i) - knots(currentSegment))/dI;
        %compute the point on the curve
        s(:, i) = hermite(0, t)*p(:, currentSegment) + dI*hermite(1, t)*firstDerivatives(:, currentSegment) + dI*hermite(2, t)*firstDerivatives(:, currentSegment+1) + hermite(3, t)*p(:, currentSegment+1);
    end
end

end

function [h] = hermite(i, t)
    %Compute the i-th cubic Hermite polynominal for the given parameter t
    switch i
        case 0
            h = evalBernstein(3, 0, t) + evalBernstein(3, 1, t);
        case 1
            h = evalBernstein(3, 1, t)/3;
        case 2
            h = evalBernstein(3, 2, t)/-3;
        case 3
            h = evalBernstein(3, 2, t) + evalBernstein(3, 3, t);
        otherwise
            error(strcat('Invalid hermite parameter i=', num2str(i)))
    end
end

function [bezierPoints] = computeBezierPoints(currentPoint, nextPoint, currentDeriv, nextDeriv, deltaI, bezierPoints, segement)
    %Compute the bezier points of the given curve segment
    bezierPoints(:, 1, segement) = currentPoint;
    bezierPoints(:, 2, segement) = currentPoint + deltaI/3*currentDeriv;
    bezierPoints(:, 3, segement) = nextPoint - deltaI/3*nextDeriv;
    bezierPoints(:, 4, segement) = nextPoint;
end