function x = mollelineari(n,k,W)

if length(k) ~= n || length(W) ~= n
    error('k e W devono avere lunghezza n');
end

A = diag(k(1:n) + [k(2:n);0],0) + ...
    diag(-k(2:n),1) + diag(-k(2:n),-1);

[L,U,P] = ludecomp(A);
x = backwardsolve(U,forwardsolve(L,P*W));

end