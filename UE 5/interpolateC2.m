function [ s, b] = interpolateC2( u, p )
%INTERPOLATEC2 Interpolate the given points p at knots u using a C2
%continuous cubic spline s with inner Bezier points b

[dim, k] = size(p);
if (size(u)~=k)
    error('Numbers of knots and sample points do not agree!');
end
    
%% Estimate derivatives for C2 continuity

% Init A
A = zeros(k);
A(1,1:2) = [2 1];
A(k,k-1:k) = [1 2];
for i = 2:k-1
    a1 = u(i+1)-u(i);
    a2 = 2 * (u(i+1)-u(i-1));
    a3 = u(i) - u(i-1);
    A(i, i-1:i+1) = [a1 a2 a3];
end

% Init right side
r = zeros(dim,k);
r(:,1) = (3/(u(2)-u(1))) * (p(:,2) - p(:,1));
r(:,k) = (3/(u(k)-u(k-1))) * (p(:,k) - p(:,k-1));
for i = 2:k-1
    p1 = (u(i+1)-u(i))/(u(i)-u(i-1)) * (p(:,i) - p(:,i-1));
    p2 = (u(i)-u(i-1))/(u(i+1)-u(i)) * (p(:,i+1) - p(:,i));
    r(:,i) = 3 * ( p1 +  p2);    
end

% Init derivative vector with natural border conditions
m = zeros(dim,k);
m(:,1) = r(:,1);
m(:,k) = r(:,k);


% Solve linear system coordinatewise
for d = 1:dim
    m(d,:) = A \ (r(d,:))';
end

%% Interpolate
[s, b] = interpolateC1(u, p, m);
end

