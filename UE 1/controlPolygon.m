function [ p ] = controlPolygon( P, i )
%CONTROLPOLYGON Computes the control points created by i de Casteljau
%iterations

% Init
n = size(P, 2)-1;
d = size(P, 1);
t = 0.5;
b = zeros(d, n + 1, n + 1);
b(:, :, 1) = P;
p = zeros(size(b,1), 2*n +1);
p(:,1,1) = P(:,1);

% de Casteljau iterations
for j = 1 : n

    % Iterate over all points
    for k = 1 : n + 1 - j 
        b(:, k, j + 1) = (1 - t) * b(:, k, j) + t * b(:, k + 1, j);
    end

    % ci
    p(:,j + 1) = b(:,1, j + 1);

    % di 
    p(:,2*n + 2 - j) = b(:, n + 2 - j , j);
end
    
if (i > 1)
    p = controlPolygon(p, i-1);
end

end

