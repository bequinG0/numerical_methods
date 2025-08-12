function X = cholesky_crout(A, B, n)
    AB = [A, B];L = [];
    C = [];
    for i = 1:n 
        L(i, i) = 1;
    endfor 
    for i = 1:n 
        for j = 1:n 
            C(i, j) = 0;
        endfor 
    endfor 

    for i = 1:n 
        for j = 1:n
            temp = 0;
            for k = 1:(i-1)
                temp = temp + L(i, k) * C(k, j);
            endfor
            C(i, j) = A(i, j) - temp;

            temp = 0;
            for k = 1:(i-1)
                temp = temp + L(j, k) * C(k, i); 
            endfor
            L(j, i) = (A(j, i) - temp)/A(i, i);
        endfor 
    endfor

    C 
    L 
    

endfunction