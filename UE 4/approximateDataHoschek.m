function [ d, uNew ] = approximateDataHoschek( p, n, T, k, lambda, u, tol, maxIter, debug  )
%APPROXIMATEDATAHOSCHEK Approximates data p with B-spline of degree n with knot
%vector u, k control points and smoothing factor lambda and performs
%Hoschek parameter correction until the error vector is orthogonal to
%spline curve in a up to tolerance tol

% Initial spline curve
d = approximateData(p, n, T, k, lambda, u);
s = bSplinePoint(T, n, d, u);

if(debug)
    t = 0:0.001:1;
    curve = bSplinePoint(T, n, d, t);
    su = bSplinePoint(T,n,d,u);

    figure
    plot(d(1,:), d(2,:), 'ro-.');
    hold on
    plot(curve(1,:), curve(2,:));
    plot(p(1,:), p(2, :), 'g*');
    plot(su(1,:), su(2, :), 'm+');
    legend('Control points', 'Curve', 'Sample points', 'Knot Points', 'Location', 'southeast');
    title('Spline Hoschek Approximation');
    hold off
end

% Error
sPrime = evalBsplinePrime(T, n, d, u);
sPrimeNorm = sqrt(sum(sPrime.^2, 1));
sPrimeNormalized = sPrime./ repmat(sPrimeNorm,2,1);
sPrimeNormalized(isnan(sPrimeNormalized)) = 0;
v = p - s;
vNorm = sqrt(sum(v.^2, 1));
vNormalized = v./ repmat(vNorm,2,1);
vNormalized(isnan(vNormalized)) = 0;

% Count interation
it = 0;

while (max(dot(vNormalized,sPrimeNormalized,1)) > tol && it < maxIter)
    disp(strcat('Start iteration #', num2str(it)))
    
    % Calculate new parameters
    h = (dot(v,sPrime,1))./(sPrimeNorm.*sPrimeNorm);
    h(isnan(h)) = 0;
    uNew = u + h;
    uNew(1) = u(1);
    uNew(size(u, 2)) = u(size(u, 2));
    %uNew = sort(uNew);
    %uNew = (uNew - uNew(1) )/ ( uNew(end) - uNew(1));
    
    % Approximate data with corrected parameters
    d = approximateData(p, n, T, k, lambda, uNew);
    s = bSplinePoint(T, n, d, uNew);
    
    % Calculate new error
    sPrime = evalBsplinePrime(T, n, d, uNew);
    sPrimeNorm = sqrt(sum(sPrime.^2, 1));
    sPrimeNormalized = sPrime./ repmat(sPrimeNorm,2,1);
    sPrimeNormalized(isnan(sPrimeNormalized)) = 0;
    v = p - s;
    vNorm = sqrt(sum(v.^2, 1));
    vNormalized = v./ repmat(vNorm,2,1);
    vNormalized(isnan(vNormalized)) = 0;
    
    % Prepare next iteration
    u = uNew;
    it = it +1;
    
    if(debug)
        t = 0:0.001:1;
        curve = bSplinePoint(T, n, d, t);
        su = bSplinePoint(T,n,d,u);

        plot(d(1,:), d(2,:), 'ro-.');
        hold on
        plot(curve(1,:), curve(2,:));
        plot(p(1,:), p(2, :), 'g*');
        plot(su(1,:), su(2, :), 'm+');
        legend('Control points', 'Curve', 'Sample points', 'Knot Points', 'Location', 'southeast');
        title('Spline Hoschek Approximation - klick to continue');
        hold off
        
        waitforbuttonpress 
    end
    disp(strcat('Error=', num2str(sum(sum(v.^2, 1)))))
end

end
