function [ p ] = controlPolygon( P, i )
%CONTROLPOLYGON Computes the control points created by i de Casteljau
%iterations

% Init
n = size(P, 2)-1;
dim = size(P, 1);
t = 0.5;
b = zeros(dim, n + 1, n + 1);
b(:, :, 1) = P;
c = zeros(dim, n + 1);
c(:,1) = P(:,1);
d = zeros(dim, n + 1);
d(:, n + 1) = P(:, n + 1); 

% de Casteljau iterations
for j = 1 : n

    % Iterate over all points
    for k = 1 : n + 1 - j 
        b(:, k, j + 1) = (1 - t) * b(:, k, j) + t * b(:, k + 1, j);
    end

    % ci
    c(:, j + 1) = b(:,1, j + 1);

    % di 
    d(:, n + 1 - j) = b(:, n + 1 - j , j + 1);
end
    
if (i > 1)
    c = controlPolygon(c, i-1);
    d = controlPolygon(d, i-1);
end

p = [c d(:,2:end)];

end

