function [ d, uNew ] = approximateDataHoschek( p, u, lambda, n, k, tol, maxIter, debug  )
%APPROXIMATEDATAHOSCHEK Approximate 2xm data p with B-spline of degree n with knot
%vector u, k control points and smoothing factor lambda and performs
%Hoschek parameter correction until the error vector is orthogonal to
%spline curve in a up to tolerance tol

% Initial spline curve
d = approximateData(p, u, lambda, n, k);
s = bSplinePoint(u, n, d, u);

if(debug)
    t = 0:0.001:1;
    curve = bSplinePoint(u, n, d, t);
    su = bSplinePoint(u,n,d,u);

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
sPrime = evalSplinePrime(u, n, u, d);
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
    h = (dot(v,sPrimeNormalized,1))./(sPrimeNorm.*sPrimeNorm);
    h(isnan(h)) = 0;
    uNew = u + h;
    uNew = sort(uNew);
    uNew = (uNew - uNew(1) )/ ( uNew(end) - uNew(1));
    
    % Approximate data with corrected parameters
    d = approximateData(p, uNew, lambda, n, k);
    s = bSplinePoint(uNew, n, d, uNew);
    
    % Calculate new error
    sPrime = evalSplinePrime(uNew, n, uNew, d);
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
        curve = bSplinePoint(u, n, d, t);
        su = bSplinePoint(u,n,d,u);

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

function sPrime =  evalSplinePrime(u, n, t, d)
    k = size(d, 2);
    numPoints = size(t,2);
    sPrime = zeros(2,numPoints);

    for p = 1:numPoints
        
        % Forward operator
        for i = 1:k-1
            sPrime(:,p) = sPrime(:,p) + evaluateBsplineBasis(u, n-1, i, t(p)) * (d(:,i+1) - d(:,i)) ;
        end 
        
        if(t(p) == 1)
            % Last curve point: backward operator
            sPrime(:,p) = sPrime(:,p) + evaluateBsplineBasis(u, n-1, k, t(p)) * (d(:,k) - d(:,k-1)) ;
        end
    end
end
