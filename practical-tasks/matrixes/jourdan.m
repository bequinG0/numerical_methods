function X = jourdan(A, B, n)
    AB = [A, B];
    X = [];
    for k = 1:n
        temp = AB(k, k);
        for j = 1:n+1
            AB(k, j) = AB(k, j)/temp;
        endfor
        %AB
        for i = 1:n
            if i ~= k
                temp = AB(i, k); 
                for j = 1:n+1
                    AB(i, j) = AB(i, j) - AB(k, j)*temp;
                endfor
            endif
        endfor

        %AB
    endfor

    for i = 1:n
        X(end+1) = AB(i, end);
    endfor
    X = sort(X);
    return;
endfunction
