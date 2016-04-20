function drawComparison( p, titelStr, names, curves, styles )

figure
hold on

for i = 1 : size(curves, 3)
    plot(curves(1, :, i), curves(2, :, i), styles{i})
end

scatter(p(1,:), p(2,:), 'Og')
hold off
title( titelStr )
legend(names, 'Points')

