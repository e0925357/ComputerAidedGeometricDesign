function visualizeBasis( U, n )
%VISUALIZEBASIS visualizes the knot vector of the b-spline basis
%   Detailed explanation goes here

t = 0 : 0.001 : 1;
u = zeros(size(U, 2) - 1 - n, size(t,2));

for i = 1 : size(t, 2)
   u(:, i) = evaluateBsplineBasis2(U, n, t(i)); 
end

us = sum(u, 1);

figure
hold on
plot(t, us, ':k')
for i = 1 : size(u, 1)
    plot(t, u(i, :))
end
hold off
title('Knot vector u')

end

