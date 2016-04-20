function [ s, bezierPoints ] = interpolateC1( knots, p, firstDerivatives )
%INTERPOLATEC1 Summary of this function goes here
%   Detailed explanation goes here
u = knots(1) : 0.01 : knots(size(knots, 2));
s = zeros(size(p, 1), size(u, 2));
bezierPoints = zeros(size(p, 1), 4, size(knots, 2)-1);
nextBorder = knots(2);
currentSegment = 1;

bezierPoints = computeBezierPoints(p(:,1), p(:,2), firstDerivatives(:, 1), firstDerivatives(:, 2), knots(2) - knots(1), bezierPoints, currentSegment);

for i = 1 : size(u, 2)
    while u(i) >= nextBorder && u(i) < knots(size(knots, 2))
        currentSegment = currentSegment + 1;
        nextBorder = knots(currentSegment + 1);
        
        bezierPoints = computeBezierPoints(p(:,currentSegment), p(:,currentSegment+1), firstDerivatives(:, currentSegment), firstDerivatives(:, currentSegment+1), knots(currentSegment+1) - knots(currentSegment), bezierPoints, currentSegment);
    end
    
    if  u(i) >= knots(size(knots, 2))
        s(:,i) = p(:, size(p, 2));
    else
        dI = knots(currentSegment+1) - knots(currentSegment);
        t = (u(i) - knots(currentSegment))/dI;
        s(:, i) = hermite(0, t)*p(:, currentSegment) + dI*hermite(1, t)*firstDerivatives(:, currentSegment) + dI*hermite(2, t)*firstDerivatives(:, currentSegment+1) + hermite(3, t)*p(:, currentSegment+1);
    end
end

end

function [h] = hermite(i, t)
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
    bezierPoints(:, 1, segement) = currentPoint;
    bezierPoints(:, 2, segement) = currentPoint + deltaI/3*currentDeriv;
    bezierPoints(:, 3, segement) = nextPoint - deltaI/3*nextDeriv;
    bezierPoints(:, 4, segement) = nextPoint;
end