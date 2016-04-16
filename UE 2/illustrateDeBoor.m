function [ bt ] = illustrateDeBoor( knots, n, d, evalPoints, u )
%DEBOOR Compute B-spline curve and  d using de Boor's algorithm
% knots      ...    knot vector 
% n          ...    degree
% d          ...    control points
% evalPoints ...    parameter values where curve is evaluated
% u          ...    evaluation parameter for illustration

% Init
dim = size(d, 1);
numControl = size(d, 2);
numKnots = size(knots,2);

% Find respective intervall
[~,bin] = histc(u, knots);

% De Boor Points
dBoor = zeros(dim, numControl, n+1);
dBoor(:,:,1) = d;

% Get respective interval
l = bin - 1; % index shift s.t. first bin has index 0

% Skip if point is out of range
if (l - n < 0 || l+n+1 > numKnots || l+1 > numControl)
    bt = NaN;
end

% Draw control points
figure
p1 = plot(d(1,:), d(2,:), 'ro-.');
hold on

% Calculate deBoor points
for r = 1:n
    % Iterate over affected control points
    for i = l-n+r+1:l+1;
        ai = (u - knots(i) )/ (knots(i+n+1-r) - knots(i));
        dBoor(:,i,r+1) = (1 - ai)*dBoor(:,i-1, r) + ai*dBoor(:,i, r);
    end
    
    %Wait for a button press
    title('Press a button or click to cotinue!')
    waitforbuttonpress();
    
    % Draw new points
    p2 = plot(dBoor(1, l-n+r+1:l+1, r+1), dBoor(2, l-n+r+1:l+1, r+1), 'b*-');
    
end

% Draw entire curve
title('Press a button or click to cotinue!')
waitforbuttonpress();
btAll = pureDeBoor(knots, n, d, evalPoints);
p3 = plot(btAll(1,:), btAll(2,:), 'k:');

legend([p1 p2 p3], 'Control points', 'DeBoor points', 'Spline curve');
title('DeBoor Algorithm');
hold off

% Store curve point
bt = dBoor(:,l+1,n+1);   

end


