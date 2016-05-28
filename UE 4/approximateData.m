function [ d ] = approximateData( p, n, T, k, lambda, u )
%APPROXIMATEDATA Approximate 2xm data p with B-spline of degree n with knot
%vector T, k number of control points, smoothing factor lambda and
%parameter values u

% Get number of data points
m = size(p,2);

% Init minimization matrix
A = zeros(k,k);
b = zeros(k,2);
d = zeros(k,2);
   
% Derive error term with respect to control point dl
for l = 1:k

    % Iterate over parameter vector
    for j = 1:m

        % Iterate over control points
        for i = 1:k
            A(l,i) = A(l, i) + createMatrixEntry(i, j, l, T, lambda, n, k, u);   

        end
        
        for dim=1:2
            b(l, dim) = b(l, dim) + N(T, n, l, u(j)) * p(dim, j);
        end

    end

end

% Find mininal control points
d(:,1) = A \ b(:,1);
d(:,2) = A \ b(:,2);
d = d';

end

function ail = createMatrixEntry(i, j, l, T, lambda, n, k, u)
    ail = 2 * lambda * (N(T, n, l-2, u(j)) - 2 * N(T, n, l-1, u(j)) + N(T, n, l, u(j)));

    if i==1
        ail = ail * N(T, n, 1, u(j));
    elseif i==2
        ail = ail * ( N(T, n, 2, u(j)) - 2* N(T, n, 1, u(j)));
    elseif i==k-1
        ail = ail * ( N(T, n, k-3, u(j)) - 2* N(T, n, k-2, u(j)));
    elseif i==k
        ail = ail * N(T, n, k-2, u(j));
    else
        ail = ail * ( N(T, n, i-2, u(j)) - 2* N(T, n, i-1, u(j)) + N(T, n, i, u(j)));
    end

    ail = ail + N(T, n, i, u(j)) * N(T, n, l, u(j));
end



function y = N(T, n, index, t)
    if index<=0
        y =0;
    else
        y = evaluateBsplineBasis(T, n, index, t);
    end
end
