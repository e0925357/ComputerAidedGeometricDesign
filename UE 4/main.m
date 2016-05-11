% CAGD UE4 - Spline approximation
close all
dbstop error

% Spline degree
n = 3;

lambda = 0.1;

% Get sample points
fig = figure('Name', 'Spline Approxiamtion: Sample Points');
plot([0 100], [0 100]);
[xData, yData] = getpts(fig);
close all
p = [xData'; yData'];
m = size(p, 2);

% Init control points
k = round(m/2);

% Get equidistant knots + add edge knot n times
u = getKnots(p, 'Equidistant', n);

%% A: Spline approximation
d = approximateData(p, u, lambda, n, k);

t = 0:0.01:1;
s = pureDeBoor(u, n, d, t);

figure
plot(d(1,:), d(2,:), 'ro-.');
hold on
plot(s(1,:), s(2,:));
plot(p(1,:), p(2, :), 'g*');
legend('Control points', 'Curve', 'Sample points', 'Location', 'southeast');
title('Spline Approximation');
hold off

%% B: Parameter correction
