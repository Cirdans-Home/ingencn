function [x,min_res] = minquad(A,b,flag)
%%MINQUAD risolve il problem ai minimi quadrati associato
% al sistema Ax=b con il metodo specificato in flag
%    INPUT:
%     A matrice del sistema
%     b termine noto del sistema
%     flag stringa che specifica il metodo di risoluzione
%    OUTPUT:
%     x soluzione del problema ai minimi quadrati, punto di minimo
%     min_res valore del minimo

switch flag
    case 'EqNormali'
        %[L,U] = lu(A.'*A);
        [L,U] = doolittlelu(A.'*A);
        c = A.'*b;
        y = forwardsolve(L,c); % Ly=c
        x = backwardsolve(U,y); % Ux=y
    case 'MetodoQR'
        [~,n] = size(A);
        [Q, R] = qr(A);
        c = Q.'*b;
        R1 = R(1:n,:);
        c1 = c(1:n);
        x = backwardsolve(R1,c1); % R1*x=c1
    otherwise
        error('Il metodo specificato non è stato implementato')
end
min_res = norm(A*x-b);

end
