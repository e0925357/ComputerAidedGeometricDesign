function [ m ] = getDerivative( p, u, method )
%GETDERIVATIVE For cubic C1 interpolation

switch method
    case 'FMILL'
        m = fmillDerivative(p, u);
    case 'Bessel'
        m = besselDerivative(p, u);
    otherwise
        m = NaN;
        error('No method specified!'); 
end

end

function m = besselDerivative(p, u)
    [dim, k] = size(p);
    m = zeros(dim, k);
    
    % mi
    for i = 2:k-1
        ai = (u(i) - u(i-1)) / (u(i+1) - u(i-1));
        a1 = (1 - ai)/(u(i)-u(i-1));
        a2 = ai/(u(i+1)-u(i));
        m(:,i) = a1 * (p(:,i)-p(:,i-1)) + a2 * (p(:,i+1)-p(:,i));
    end
    
    % m0
    m(:,1) = 2/(u(2)-u(1)) * (p(:,2)-p(:,1)) - m(:,2);
    
    % mk
    m(:,k) = 2/(u(k)-u(k-1)) * (p(:,k)-p(:,k-1)) - m(:,k-1);
    
end

function m = fmillDerivative(p, u)
    [dim, k] = size(p);
    m = zeros(dim, k);
    
    % m0 = mk = 0
    
    % mi
    for i = 2:k-1
        a1 = 1/ (u(i+1) - u(i-1));
        a2 = (p(:,i+1) - p(:,i-1)) / norm(p(:,i+1) - p(:,i-1));
        m(:,i) = a1 * a2;
    end   
    
end