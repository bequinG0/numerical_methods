function one = determinate(A, n)
    if n == 1
        one = A(1, 1);
        return;
    endif
    if n > 1
        res = 0;
        for i = 1:n 
            res = res + (-1)^(i+1) * A(1, i) * determinate(separeted(A, 1, i, n), n-1);
        endfor
        one = res;
    endif
endfunction