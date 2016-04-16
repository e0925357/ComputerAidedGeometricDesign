close all

%% 2.1
% Control points
b = [1 3 5.5 6.5;2 4 4.5 2.5];

% End point
q = [4; 2.5];

% Control points of new branch
bNew = computeNewBranch(b, q);

%parameters to evaluate
t = 0 : 0.01 : 1;

%points on  curve
c1 = zeros(size(b, 1), size(t, 2));
c2 = zeros(size(bNew, 1), size(t, 2));

%Compute a curve point for each parameter
for i = 1 : size(t, 2)
    c1(:, i) = pureDecasteljau(b, t(i));
    c2(:, i) = pureDecasteljau(bNew, t(i));
    
end

%draw it!
figure
plot(b(1, :), b(2, :), '--r' )
hold on;
plot(c1(1,:), c1(2,:), '-b')
plot(bNew(1, :), bNew(2, :), '-.r' )
plot(c2(1,:), c2(2,:), ':b')
hold off;
legend('original polygon', 'original curve', 'extended polygon', 'extended curve');

%% 2.2
% Nodes
uA = [0 0.25 0.5 0.75 1];
uB = [0 0 0 0.3 0.5 0.5 0.6 1 1 1];

ua0 = zeros(size(uA, 2) - 1, size(t,2));
ua1 = zeros(size(uA, 2) - 2, size(t,2));
ua2 = zeros(size(uA, 2) - 3, size(t,2));
ub0 = zeros(size(uB, 2) - 1, size(t,2));
ub1 = zeros(size(uB, 2) - 2, size(t,2));
ub2 = zeros(size(uB, 2) - 3, size(t,2));

for i = 1 : size(t, 2)
    ua0(:, i) = evaluateBsplineBasis(uA, 0, t(i));
    ub0(:, i) = evaluateBsplineBasis(uB, 0, t(i));
    ua1(:, i) = evaluateBsplineBasis(uA, 1, t(i));
    ub1(:, i) = evaluateBsplineBasis(uB, 1, t(i));
    ua2(:, i) = evaluateBsplineBasis(uA, 2, t(i));
    ub2(:, i) = evaluateBsplineBasis(uB, 2, t(i));
end

ua0s = sum(ua0, 1);
ua1s = sum(ua1, 1);
ua2s = sum(ua2, 1);

ub0s = sum(ub0, 1);
ub1s = sum(ub1, 1);
ub2s = sum(ub2, 1);

figure
subplot(2, 2, 1)
plot(t, ua0s, '--.k')
hold on
plot(t, ua0(1, :), '-r')
plot(t, ua0(2, :), ':b')
plot(t, ua0(3, :), '-.g')
plot(t, ua0(4, :), '--o')
hold off
axis([0 1 0 1.1])
legend('sum', 'i=1', 'i=2', 'i=3', 'i=4')
title('BSpline Basis uA, degree 0')

subplot(2, 2, 2)
plot(t, ua1s, '--.k')
hold on
plot(t, ua1(1, :), '-r')
plot(t, ua1(2, :), ':b')
plot(t, ua1(3, :), '-.g')
hold off
axis([0 1 0 1.1])
legend('sum', 'i=1', 'i=2', 'i=3')
title('BSpline Basis uA, degree 1')

subplot(2, 2, 3)
plot(t, ua2s, '--.k')
hold on
plot(t, ua2(1, :), '-r')
plot(t, ua2(2, :), ':b')
hold off
axis([0 1 0 1.1])
legend('sum', 'i=1', 'i=2')
title('BSpline Basis uA, degree 2')

figure
subplot(2, 2, 1)
plot(t, ub0s, '--.k')
hold on
plot(t, ub0(1, :), '-r')
plot(t, ub0(2, :), ':b')
plot(t, ub0(3, :), '-.g')
plot(t, ub0(4, :), '--o')
plot(t, ub0(5, :), '.m')
plot(t, ub0(6, :), '*c')
plot(t, ub0(7, :), '-*k')
plot(t, ub0(8, :), 'xy')
plot(t, ub0(9, :), '-xr')
hold off
axis([0 1 0 1.1])
legend('sum', 'i=1', 'i=2', 'i=3', 'i=4', 'i=5', 'i=6', 'i=7', 'i=8', 'i=9')
title('BSpline Basis uB, degree 0')

subplot(2, 2, 2)
plot(t, ub0s, '--.k')
hold on
plot(t, ub1(1, :), '-r')
plot(t, ub1(2, :), ':b')
plot(t, ub1(3, :), '-.g')
plot(t, ub1(4, :), '--o')
plot(t, ub1(5, :), '.m')
plot(t, ub1(6, :), '*c')
plot(t, ub1(7, :), '-*k')
plot(t, ub0(8, :), 'xy')
hold off
axis([0 1 0 1.1])
legend('sum', 'i=1', 'i=2', 'i=3', 'i=4', 'i=5', 'i=6', 'i=7', 'i=8')
title('BSpline Basis uB, degree 1')


subplot(2, 2, 3)
plot(t, ub2s, '--.k')
hold on
plot(t, ub2(1, :), '-r')
plot(t, ub2(2, :), ':b')
plot(t, ub2(3, :), '-.g')
plot(t, ub2(4, :), '--o')
plot(t, ub2(5, :), '.m')
plot(t, ub2(6, :), '*c')
plot(t, ub2(7, :), '-*k')
hold off
axis([0 1 0 1.1])
legend('sum', 'i=1', 'i=2', 'i=3', 'i=4', 'i=5', 'i=6', 'i=7')
title('BSpline Basis uB, degree 2')


%% 2.3 
% Illustrate the deBoor algorithm for one parameter
knots = [0 0 0 0 0.3 0.5 0.7 1 1 1];
control = [1 3 6 8 8.5 6; 1 4 4.5 3.5 2 3.5];
illustrateDeBoor(knots, 3, control, t, 0.4);

% Example 1: degree 2
knots = [0 0 0 0.3 0.5 0.7 1 1 1];
control = [1 3 6 8 8.5 6; 1 4 4.5 3.5 2 3.5];
bt = pureDeBoor(knots, 2, control, t);

% Example 2: degree 3
knots1 = [0 0 0 0 0.3 0.5 0.7 1 1 1 ];
bt1 = pureDeBoor(knots1, 3, control, t);

% Example 3: degree 3
knots2 = [0 0 0 0 0.3 0.5 0.7 1 1 1 1];
control2 = [control control(:,end)];
bt2 = pureDeBoor(knots2, 3, control2, t);

% Example 4: Special case - compare with de Casteljau
knots3 = [0 0 0 1 1 1];
control3 = control(:,2:4);
bt3 = pureDeBoor(knots3, 2, control3, t);

bCast = zeros(size(control3, 1), size(t,2));
for i = 1 : size(t, 2)
    bCast(:, i) = pureDecasteljau(control3, t(i));    
end


% Plot examples
figure

subplot(1,3,1)
plot(control(1,:), control(2,:), 'ro-.');
hold on
plot(bt(1,:), bt(2,:));
legend('Control points', 'Curve', 'Location', 'southeast');
title('DeBoor: degree 2');
hold off

subplot(1,3,2)
plot(control(1,:), control(2,:), 'ro-.');
hold on
plot(bt1(1,:), bt1(2,:));
legend('Control points', 'Curve', 'Location', 'southeast');
title('DeBoor: degree 3, add one knot');
hold off

subplot(1,3,3)
plot(control2(1,:), control2(2,:), 'ro-.');
hold on
plot(bt2(1,:), bt2(2,:));
legend('Control points', 'Curve', 'Location', 'southeast');
title('DeBoor: degree 3, add another knot');
hold off

figure('Name', 'DeCasteljau: special case of deBoor algorithm');

subplot(1,2,1)
plot(control3(1,:), control3(2,:), 'ro-.');
hold on
plot(bt3(1,:), bt3(2,:));
legend('Control points', 'Curve');
title('DeBoor algorithm with knots (0,0,0,1,1,1)')
hold off

subplot(1,2,2)
plot(control3(1,:), control3(2,:), 'ro-.');
hold on
plot(bCast(1,:), bCast(2,:));
legend('Control points', 'Curve');
title('DeCasteljau algorithm');
hold off

