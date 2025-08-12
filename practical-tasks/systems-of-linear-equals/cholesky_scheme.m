function X = cholesky_scheme(A, B, n)
    L = zeros(n);
    for i = 1:n 
        temp = 0;
        for k = 1:(i-1)
            temp = temp + L(i, k)^2;
        endfor
        L(i, i) = sqrt(A(i, i) - temp);

        for j = (i+1):n 
            temp = 0;
            for k = 1:(i-1)
                temp = temp + L(i, k)*L(j, k);
            endfor
            L(j, i) = (A(j, i) - temp)/L(i, i);
        endfor 
    endfor

    Y = zeros(n, 1);
    Y(1) = B(1)/L(1, 1);
    for i = 2:n
        temp = 0;
        for k = 1:i-1 
            temp = temp + Y(k)*L(i, k);
        endfor
        Y(i) = (B(i) - temp)/L(i, i);
    endfor

    X = zeros(n, 1);
    C = L';
    X(end) = Y(end)/C(end, end);

    for i = n:-1:1
        temp = 0;
        for k = i+1:n
            temp = temp + C(i, k) * X(k);
        endfor
        X(i) = (Y(i) - temp) / C(i, i);
    endfor

    X = sort(X');
    return;
endfunction