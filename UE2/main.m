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

ua = zeros(size(uA, 2) - 3, size(t,2));
ub = zeros(size(uB, 2) - 3, size(t,2));
for i = 1 : size(t, 2)
ua(:, i) = evaluateBsplineBasis(uA, 2, t(i));
ub(:, i) = evaluateBsplineBasis(uB, 2, t(i));
end

figure
plot(t, ua(1, :), '-r')
hold on
plot(t, ua(2, :), ':b')
hold off
legend('i=1', 'i=2')
title('BSpline Basis uA, degree 2')

figure
plot(t, ub(1, :), '-r')
hold on
plot(t, ub(2, :), ':b')
plot(t, ub(3, :), '-.g')
plot(t, ub(4, :), '--o')
plot(t, ub(5, :), '.m')
plot(t, ub(6, :), '*c')
plot(t, ub(7, :), '-*k')
hold off
legend('i=1', 'i=2', 'i=3', 'i=4', 'i=5', 'i=6', 'i=7')
title('BSpline Basis uB, degree 2')
