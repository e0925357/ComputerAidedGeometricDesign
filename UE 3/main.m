% CAGD TASK 4.1 - Cubic spline interpolation

% 2D Samples
p = [1 3 5.5 6.5 5 4;2 4 4.5 2.5 1 2.5];

% Calculate knots
uChord = getKnots(p, 'ChordLength');
uEqui = getKnots(p, 'Equidistant');
uLee = getKnots(p, 'Lee');

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
