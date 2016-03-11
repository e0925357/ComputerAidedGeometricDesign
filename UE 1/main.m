close all

%% Aufgabe 1a: Illustrate de Casteljau algorithm
%Control points
b = [1 3 5.5 6.5 5 4;2 4 4.5 2.5 1 2.5];
%parameters to evaluate
t = 0 : 0.01 : 1;
%points on curve
c = zeros(size(b, 1), size(t, 2));

%Compute a curve point for each parameter
for i = 1 : size(t, 2)
    c(:, i) = pureDecasteljau(b, t(i));
end

%draw it!
figure
plot(b(1, :), b(2, :), '-r' )
hold on;
plot(c(1,:), c(2,:), '-b')
hold off;

%visualize the algorithm
decasteljau(b, 0.3);

title('Bézier Curve')

%% Aufgabe 1b: Compare bezier curves to approximations

% Plot Bezier curve
figure('Name', '1b: Compare Bézier curve and approximations')
plot(c(1,:), c(2,:), '-b');
hold on

% Plot approximations
col = {'--c', '--g', '--r'};
for i = 1:3
    p = controlPolygon(b, i);
    plot(p(1,:), p(2,:), col{i});
end
legend('Bézier curve', '1 iteration', '2 iterations', '3 iterations');

hold off