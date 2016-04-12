function [ bNew ] = computeNewBranch( b, q )
%COMPUTENEWBRANCH Compute the control points of a cubic Bezier curve that
%is appended to a given cubic Bezier curve with control points b with C2 closure and ends
%at a given point q

if (size(b, 2) ~= 4)
    disp('Error: Input curve not cubic');
    return
end

dim = size(b, 1);
if (size(q,1) ~= dim)
    disp('Error: Endpoint must have same dimension as control points of input curve!');
end


bNew = zeros(dim,4);

% Endpoint
bNew(:,4) = q;

% C0:
bNew(:,1) = b(:,4);

% C1:
bNew(:,2) = 2*b(:,4) - b(:,3);

% C2:
bNew(:,3) = 4*b(:,4) - 4*b(:,3) + b(:,2);

end

