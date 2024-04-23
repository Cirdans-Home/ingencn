n = 500; 
Q = orth(randn(n,n));
d = logspace(0,-10,n);
A = Q*diag(d)*Q';
x = randn(n,1);
b = A*x;

tic
y = inv(A)*b; 
t = toc
res_inv = norm(A*y-b)

tic
z = A\b;
t1 = toc
res_bs = norm(A*z-b)

% tic
% [U,S,V] = svd(A);
% Ainv = U*inv(S)*V';
% w = Ainv*b;
% t2 = toc
% res_svd = norm(A*w-b)