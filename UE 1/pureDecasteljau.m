function [ c ] = pureDecasteljau( b, t )
%PUREDECASTELJAU computes the point of the bézier curve using the algorithm of De Casteljau.
%   b are the control points of the curve
%   t is the parameter of the curve, must be between 0 and 1
%   returns c, the point on the curve.

%Create the matrix for the intermediate solutions
c = zeros(size(b, 1), size(b, 2) - 1);

%Iterate until there is only one control point left
while (size(b, 2) > 1)
    %Get the current degree of the curve
    n = size(b, 2) - 1;

    for i = 1 : n
        %For each control point in this step: compute the next
        %interpolation
        c(:,i) = (1-t).*b(:,i) + t.*b(:,i+1,:);
    end

    %Copy the results to the control point matrix
    b = c(:, 1:n, :);
end

%Now there is only one control point left - that's our solution
c = b(:, 1, :);

end

