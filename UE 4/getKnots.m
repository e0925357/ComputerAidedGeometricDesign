function [ u ] = getKnots( p, method, n )
%GETLEEKNOTS Computes the knots of the given curve points.
%   p      ... the sample points of the curve
%   method ... the method to generate the knotvector with.

switch(method)
    case 'Equidistant'
        u = Equidistant(p, n);
    case 'ChordLength'
        u = ChordLength(p);
    case 'Lee'
        u = Lee(p);
    otherwise
        error(strcat('The method "', method, '" is unknown!'));
end
end

function [u] = Equidistant(p, n)
    m = size(p,2);
    u(1:n) = 0;
    u(m-n+1:m) = 1;
    u(n+1:m-n) = (0 : m-1 -2*n)/(m-1 -2*n); % the knots are equally far apart
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

