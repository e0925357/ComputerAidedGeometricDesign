function [ d ] = approximateData( p, u, lambda, n, k )
%APPROXIMATEDATA Approximate 2xm data p with B-spline of degree n with knot
%vector u, k control points and smoothing factor lambda

% Get number of data points
m = size(p,2);

% Init minimization matrix
A = zeros(k,k);
b = zeros(k,2);
d = zeros(k,2);
   
% Derive error term with respect to control point dl
for l = 1:k

    % Iterate over knot vector
    for j = 1:m

        % Iterate over control points
        for i = 1:k
            A(l,i) = A(l, i) + createMatrixEntry(i, j, l, u, lambda, n, k);   

        end
        
        for dim=1:2
            b(l, dim) = b(l, dim) + N(u, n, l, u(j)) * p(dim, j);
        end

    end

end

% Find mininal control points
d(:,1) = A \ b(:,1);
d(:,2) = A \ b(:,2);
d = d';

end

function ail = createMatrixEntry(i, j, l, u, lambda, n, k)
    ail = 2 * lambda * (N(u, n, l-2, u(j)) - 2 * N(u, n, l-1, u(j)) + N(u, n, l, u(j)));

    if i==1
        ail = ail * N(u, n, 1, u(j));
    elseif i==2
        ail = ail * ( N(u, n, 2, u(j)) - 2* N(u, n, 1, u(j)));
    elseif i==k-1
        ail = ail * ( N(u, n, k-3, u(j)) - 2* N(u, n, k-2, u(j)));
    elseif i==k
        ail = ail * N(u, n, k-2, u(j));
    else
        ail = ail * ( N(u, n, i-2, u(j)) - 2* N(u, n, i-1, u(j)) + N(u, n, i, u(j)));
    end

    ail = ail + N(u, n, i, u(j)) * N(u, n, l, u(j));
end



function y = N(u, n, index, t)
    if index<=0
        y =0;
    else
        y = evaluateBsplineBasis(u, n, index, t);
    end
end
