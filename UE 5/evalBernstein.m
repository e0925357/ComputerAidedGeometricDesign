% Evaluate Bernstein polynomial
function B = evalBernstein(n, i, t)
    B = nchoosek(n,i) * t^i * (1-t)^(n-i);
end