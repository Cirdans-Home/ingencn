%% Condizionamento di un sistema lineare

A = [4.1 2.8; 9.7 6.6];
b = A(:,1);
x = A\b;

% Peturbiamo il lato destro
b2 = [4.11; 9.7];
x2 = A\b2;

kappa = cond(A);
bound = kappa*norm(b-b2)/norm(b);
errore_relativo = norm(x-x2)/norm(x);