function [ bt ] = deBoor( knots, n, d, evalPoints )
%DEBOOR Compute B-spline curve using de Boor's algorithm

dim = size(d, 1);
numPoints = size(evalPoints, 2);
numControl = size(d, 2);
numKnots = size(knots,2);

% Find respective intervall
[N,bin] = histc(evalPoints, knots);

% De Boor Points
dBoor = zeros(dim, numControl, n+1);
dBoor(:,:,1) = d;

% B-spline curve evaluated at evalPoints
bt = zeros(dim, numPoints);
    
for k = 1:numPoints
    u = evalPoints(k);
    l = bin(k);
    
    % Skip points 
    if (l - n < 0 || l+n+1>numKnots || l == numControl)
        bt(:, k) = NaN;
        continue;
    end
%     
%     for r = 1:n
%         for i = l-n+r+1:l+1;
%             dBoor(:,i,r+1) = (1 - (u - knots(i) )/ (knots(i+n+1-r) - knots(i)))*dBoor(:,i-1, r) + ((u - knots(i) )/ (knots(i+n+1-r) - knots(i)))*dBoor(:,i, r);
%         end
%     end
%
%     bt(:,k) = dBoor(:,l+1,n+1);

    bt(:,k) = calcDeBoorPoint(u, knots, n, d, n, l);
    
    
end

end





function dNew = calcDeBoorPoint(u, knots, n, d, r, i)
    if (r == 0)
        dNew = d(:,i+1);
    else
        a = 1 - (u - knots(i+1)) / (knots(i+n+1-r+1) - knots(i+1));
        dNew = a*calcDeBoorPoint(u, knots, n, d, r-1, i-1) + a*calcDeBoorPoint(u, knots, n, d, r-1, i);
    end        
end