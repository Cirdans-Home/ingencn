function V = Vandermonde(x)
    if ~isrow(x)
        disp('x must be a row vector')
        return
    end
    n = size(x,2)-1
    V = x.^((0:n)')';
end