% CAGD UE4 - Spline approximation
close all

% Spline degree
n = 3;


% Get sample points
fig = figure('Name', 'Spline Approxiamtion: Sample Points');
plot([0 100], [0 100]);
[xData, yData] = getpts(fig);
close all
p = [xData; yData];
m = size(p, 2);

% Get equidistant knots + add edge knot n times
u = getKnots(p, 'Equidistant');
u = [ repmat(u(1),1,n) u repmat(u(m),1,n)];

%% A: Spline approximation



%% B: Parameter correction
