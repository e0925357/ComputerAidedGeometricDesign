%% CAGD: UE 5
close all
clc

%% Task 1: Surface interpolation

% Data
[x, y] = meshgrid(1:100,1:100);
error = randn(100);
zPure = x.^2 - y.^2;
z =  zPure + error;
nPoints = 10;
ind = [1 sort(randperm(98,nPoints -2)+1) 100];
xr = x(1:nPoints, ind);
yr = y(ind, 1:nPoints);
zr = z(ind, ind);

% Points at boundary
px = [xr(1,:); yr(1,:); zr(1, :)];
py = [xr(:, 1)'; yr(:, 1)'; zr(:, 1)'];

% Get knots
Tx = getKnots(px, 'ChordLength');
Ty = getKnots(py, 'ChordLength');

% Interpolate curves using a C2 spline
[sX, sXBez] = interpolateC2(Tx, px);
[sY, sYBez] = interpolateC2(Ty, py);
nX = size(sX, 2);
nY = size(sY, 2);

% Create surface
deltaXY = sY - repmat(sX(:, 1), 1, nX);
deltaXY = permute(deltaXY, [ 1 3 2]);
s = repmat(sX, 1, 1, nY) + repmat(deltaXY, 1, nX, 1);

% Compare with original data
figure(1)
surf(x, y, z, ones(size(z)));
hold on
surf(permute(s(1,:,:), [2 3 1]), permute(s(2,:,:), [2 3 1]), permute(s(3,:,:), [2 3 1]), zeros(size(permute(s(2,:,:), [2 3 1]))));
colormap(winter);

% Compare with sampled data
figure(2)
%surf(xr, yr, zr, ones(size(zr)));
plot3(xr(:), yr(:), zr(:), 'r.', 'MarkerSize', 5);
hold on
surf(permute(s(1,:,:), [2 3 1]), permute(s(2,:,:), [2 3 1]), permute(s(3,:,:), [2 3 1]), zeros(size(permute(s(2,:,:), [2 3 1]))));
colormap(winter);

figure(3)
surf(xr, yr, zr, ones(size(zr)));
%plot3(xr(:), yr(:), zr(:), 'r.', 'MarkerSize', 5);
hold on
surf(permute(s(1,:,:), [2 3 1]), permute(s(2,:,:), [2 3 1]), permute(s(3,:,:), [2 3 1]), zeros(size(permute(s(2,:,:), [2 3 1]))));
colormap(winter);

figure(4)
surf(x, y, z, zeros(size(z)));
hold on
surf(x, y, zPure, ones(size(zPure)));
colormap(winter);
%% Task 2: Surface approximation

