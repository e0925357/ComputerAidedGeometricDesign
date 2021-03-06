% CAGD UE4 - Spline approximation
close all
dbstop error

% Spline degree
n = 3;

lambda = 0.1;

%Sample new points?
samplePoints = false;

if(samplePoints)
    % Get sample points
    fig = figure('Name', 'Spline Approxiamtion: Sample Points');
    plot([0 100], [0 100]);
    [xData, yData] = getpts(fig);
    close all
    p = [xData'; yData'];
else
    %Use prerecorded points
    p = [4.72350230414746 4.95391705069124 5.18433179723502 6.10599078341014 8.17972350230415 10.0230414746544 33.5253456221198 42.0506912442396 48.5023041474654 55.8755760368664 82.3732718894009 82.6036866359447 82.3732718894009 81.6820276497696 47.5806451612903 42.9723502304148 34.2165898617512 32.3732718894009 34.4470046082949 36.9815668202765 40.2073732718894 42.9723502304148 47.1198156682028 49.1935483870968 52.1889400921659 60.4838709677420 56.1059907834101 46.1981566820277 44.1244239631336;12.9737609329446 18.5131195335277 26.3848396501458 32.5072886297376 45.3352769679300 55.5393586005831 84.6938775510204 87.0262390670554 87.3177842565598 87.6093294460641 59.3294460641399 50.5830903790087 42.1282798833819 30.1749271137026 16.1807580174927 17.0553935860058 24.3440233236152 58.4548104956268 61.9533527696793 64.2857142857143 65.4518950437318 66.9096209912537 66.0349854227405 65.7434402332362 63.7026239067055 42.1282798833819 31.0495626822157 32.5072886297376 49.1253644314869];
end

% Get equidistant parameter values
u = equidistant(size(p, 2), 1);

% Init knots and control points
T = equidistant(size(p, 2), n+1);
k = size(T, 2) - n - 1;

%visualizeBasis(u, n);

%% A: Spline approximation
da = approximateData(p, n, T, k, lambda, u);

t = 0:0.001:1;
sa = bSplinePoint(T, n, da, t);
sUa = bSplinePoint(T,n,da,u);

figure
subplot(1,2,1)
plot(da(1,:), da(2,:), 'ro-.');
hold on
plot(sa(1,:), sa(2,:));
plot(p(1,:), p(2, :), 'g*');
plot(sUa(1,:), sUa(2, :), 'm+');
legend('Control points', 'Curve', 'Sample points', 'Parameter Points', 'Location', 'southeast');
title('Spline Approximation');
ylim([0 100])
xlim([0 100])
hold off

%% B: Parameter correction
[db, uNew] = approximateDataHoschek(p, n, T, k, lambda, u, 0.55, 100, false);

t = 0:0.001:1;
sb = bSplinePoint(T, n, db, t);
sUb = bSplinePoint(T,n,db,uNew);

subplot(1,2,2)
plot(db(1,:), db(2,:), 'ro-.');
hold on
plot(sb(1,:), sb(2,:));
plot(p(1,:), p(2, :), 'g*');
plot(sUb(1,:), sUb(2, :), 'm+');
legend('Control points', 'Curve', 'Sample points', 'Parameter Points', 'Location', 'southeast');
title('Spline Hoschek Approximation');
ylim([0 100])
xlim([0 100])
hold off
