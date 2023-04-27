function q = convergenza2(x)
%%CONVERGENZA produce una stima dell'ordine di convergenza della
%%successione x_n ad xtrue.
    q = zeros(length(x)-3,1);
    for n = 3:(length(x)-1)
        q(n-1) = real(log((x(n+1)-x(n))/(x(n)-x(n-1)))/log((x(n)-x(n-1))/(x(n-1)-x(n-2))));       
    end
end
