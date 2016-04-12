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
