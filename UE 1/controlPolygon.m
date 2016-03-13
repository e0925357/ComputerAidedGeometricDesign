function [ p ] = controlPolygon( P, i )
%CONTROLPOLYGON Computes the control polygon p created by i de Casteljau
%iterations for initial control points P

%% Init
% Degree
n = size(P, 2)-1;
% Dimension
dim = size(P, 1);
% Evaluation parameter
t = 0.5;
% De Casteljau control points
b = zeros(dim, n + 1, n + 1);
b(:, :, 1) = P;
% Left branch of control polygon
c = zeros(dim, n + 1);
c(:,1) = P(:,1);
% Right branch of control polygon
d = zeros(dim, n + 1);
d(:, n + 1) = P(:, n + 1); 

%% De Casteljau iterations
for j = 1 : n

    % Iterate over all points
    for k = 1 : n + 1 - j 
        b(:, k, j + 1) = (1 - t) * b(:, k, j) + t * b(:, k + 1, j);
    end

    % Left branch
    c(:, j + 1) = b(:,1, j + 1);

    % Right branch 
    d(:, n + 1 - j) = b(:, n + 1 - j , j + 1);
end

% Repeat for each new branch separately
if (i > 1)
    c = controlPolygon(c, i-1);
    d = controlPolygon(d, i-1);
end

% Merge branches into a single polygon
p = [c d(:,2:end)];

end

