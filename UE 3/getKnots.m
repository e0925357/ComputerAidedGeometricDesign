function [ u ] = getKnots( p, method )
%GETLEEKNOTS Computes the knots of the given curve points.
%   p      ... the sampe points of the curve
%   method ... the method to generate the knotvector with.

switch(method)
    case 'Equidistant'
        u = Equidistant(p);
    case 'ChordLength'
        u = ChordLength(p);
    case 'Lee'
        u = Lee(p);
    otherwise
        error(strcat('The method "', method, '" is unknown!'));
end
end

function [u] = Equidistant(p)
    u = (0 : size(p, 2)-1)/(size(p, 2)-1); % the knots are equally far apart
end

function [u] = ChordLength(p)
    u = zeros(1, size(p, 2));
    
    %Compute the parameters based on the length of the norm of the
    %interpolation points
    for i = 2:(size(p,2))
        u(i) = u(i-1) + norm(p(:, i) - p(:, i-1));
    end
    
    %Normalize to [0;1]
    u = u ./ u(size(u, 2));
end

function [u] = Lee(p)
    u = zeros(1, size(p, 2));
    
    %Compute the parameters based on the squareroot of the norm of the
    %differences of the interpolation points
    for i = 2:(size(p,2))
        u(i) = u(i-1) + sqrt(norm(p(:, i) - p(:, i-1)));
    end
    
    %Normalize to [0;1]
    u = u ./ u(size(u, 2));
end

