function drawSpline( s, bezierPoints, p, titelStr )

figure
hold on
for seg = 1 : size(bezierPoints, 3)
   plot(bezierPoints(1, :, seg), bezierPoints(2, :, seg), '--Xr') 
end

plot(s(1, :), s(2, :), '-b')
scatter(p(1,:), p(2,:), 'Og')
hold off
title( titelStr )
axis([0 7 0 7])

end

