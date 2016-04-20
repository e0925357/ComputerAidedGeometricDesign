% CAGD TASK 4.1 - Cubic spline interpolation

% 2D Samples
p = [1 3 5.5 6.5 5 4;2 4 4.5 2.5 1 2.5];

figure
plot(p(1,:), p(2,:))

% Calculate knots
uEqui = getKnots(p, 'Equidistant');
uChord = getKnots(p, 'ChordLength');
uLee = getKnots(p, 'Lee');

y1 = ones(1, size(uEqui, 2));
y2 = ones(1, size(uChord, 2)).*2;
y3 = ones(1, size(uLee, 2)).*3;

figure
plot(uEqui, y1, '-Xr')
hold on
plot(uChord, y2, '--Xg')
plot(uLee, y3, '-.Xb')
hold off
legend('Equidistant', 'ChordLength', 'Lee')
axis([0 1 0.5 3.5]);
ax = gca;
ax.XGrid = 'on';

% Calculate derivatives for C1 spline
u = 0:(1/6):1;
m1 = getDerivative(p, u, 'FMILL');
m2 = getDerivative(p, u, 'Bessel');
figure
plot(p(1,:), p(2,:), 'ro');
hold on
plot(p(1,:)+m2(1,:), p(2,:)+m2(2,:),'b*');

mChordFMILL = getDerivative(p, uChord, 'FMILL');
mEquiFMILL = getDerivative(p, uEqui, 'FMILL');
mLeeFMILL = getDerivative(p, uLee, 'FMILL');

mChordBessel = getDerivative(p, uChord, 'Bessel');
mEquiBessel = getDerivative(p, uEqui, 'Bessel');
mLeeBessel = getDerivative(p, uLee, 'Bessel');

% Interpolate using a C1 spline
[s1ChordFMILL, s1ChordFMILLBez ] = interpolateC1(uChord, p, mChordFMILL);
[s1EquiFMILL, s1EquiFMILLBez] = interpolateC1(uEqui, p, mEquiFMILL);
[s1LeeFMILL, s1LeeFMILLBez] = interpolateC1(uLee, p, mLeeFMILL);
[s1ChordBessel, s1ChordBesselBez] = interpolateC1(uChord, p, mChordBessel);
[s1EquiBessel, s1EquiBesselBez] = interpolateC1(uEqui, p, mEquiBessel);
[s1LeeBessel, s1LeeBesselBez] = interpolateC1(uLee, p, mLeeBessel);

drawSpline(s1ChordFMILL, s1ChordFMILLBez, p, 'C1 Chord FMILL')
drawSpline(s1EquiFMILL, s1EquiFMILLBez, p, 'C1 Equi FMILL')
drawSpline(s1LeeFMILL, s1LeeFMILLBez, p, 'C1 Lee FMILL')
drawSpline(s1ChordBessel, s1ChordBesselBez, p, 'C1 Chord Bessel')
drawSpline(s1EquiBessel, s1EquiBesselBez, p, 'C1 Equi Bessel')
drawSpline(s1LeeBessel, s1LeeBesselBez, p, 'C1 Lee Bessel')

% Interpolate using a C2 spline
s2Chord = interpolateC2(uChord, p);
s2Equi = interpolateC2(uEqui, p);
s2Lee = interpolateC2(uLee, p);
