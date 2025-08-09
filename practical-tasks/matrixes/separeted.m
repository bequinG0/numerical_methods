function TEMP = separeted(A, a, b, n)
    TEMP = zeros(n-1, n-1);
    for i = 1:n 
        if i ~= a 
            for j = 1:n 
                if j ~= b
                    TEMP = A(i, j);
                endif 
            endfor
        endif
    endfor
    return TEMP;
endfunction