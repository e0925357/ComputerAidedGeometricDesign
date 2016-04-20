% CAGD TASK 4.1 - Cubic spline interpolation

% 2D Samples
p = [1 3 5.5 6.5 5 4;2 4 4.5 2.5 1 2.5];

% Calculate knots
uChord = getKnots(p, 'ChordLength');
uEqui = getKnots(p, 'Equidistant');
uLee = getKnots(p, 'Lee');

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
