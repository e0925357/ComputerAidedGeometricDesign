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
plot(uEqui, y1, '-X')
hold on
plot(uChord, y2, '--X')
plot(uLee, y3, '-.X')
hold off
legend('Equidistant', 'ChordLength', 'Lee')
axis([0 1 0.5 3.5]);
ax = gca;
ax.XGrid = 'on';

% Calculate derivatives for C1 spline
mChordFMILL = getDerivative(uChord, 'FMILL');
mEquiFMILL = getDerivative(uEqui, 'FMILL');
mLeeFMILL = getDerivative(uLee, 'FMILL');

mChordBessel = getDerivative(uChord, 'Bessel');
mEquiBessel = getDerivative(uEqui, 'Bessel');
mLeeBessel = getDerivative(uLee, 'Bessel');

% Interpolate using a C1 spline
s1ChordFMILL = interpolateC1(uChord, p, mChordFMILL);
s1EquiFMILL = interpolateC1(uEqui, p, mEquiFMILL);
s1LeeFMILL = interpolateC1(uLee, p, mLeeFMILL);
s1ChordBessel = interpolateC1(uChord, p, mChordBessel);
s1EquiBessel = interpolateC1(uEqui, p, mEquiBessel);
s1LeeBessel = interpolateC1(uLee, p, mLeeBessel);

% Interpolate using a C2 spline
s2Chord = interpolateC2(uChord, p);
s2Equi = interpolateC2(uEqui, p);
s2Lee = interpolateC2(uLee, p);
