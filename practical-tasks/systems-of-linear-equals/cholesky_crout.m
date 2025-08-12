function X = cholesky_crout(A, B, n)
    L = eye(n);
    C = zeros(n);

    for i = 1:n 
        for j = i:n
            temp = 0;
            for k = 1:(i-1)
                temp = temp + L(i, k) * C(k, j);
            endfor
            C(i, j) = A(i, j) - temp;
        endfor

        for j = (i+1):n 
            temp = 0;
            for k = 1:(i-1)
                temp = temp + L(j, k) * C(k, i); 
            endfor
            L(j, i) = (A(j, i) - temp)/C(i, i);
        endfor 
    endfor

    Y = zeros(n, 1);
    Y(1) = B(1);
    for i = 2:n
        temp = 0;
        for k = 1:i-1 
            temp = temp + Y(k)*L(i, k);
        endfor
        Y(i) = B(i) - temp;
    endfor

    X = zeros(n, 1);
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