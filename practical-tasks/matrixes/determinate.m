function one = determinate(A, n)
    if n == 1
        return A(1, 1);
    endif
    if n > 1
        ans = 0;
        for i = 1:n 
            ans = ans + (-1)^(i+1) * A(1, i) * determinate(separeted(A, 1, i, n-1), n-1);
        endfor
    endif
endfunction