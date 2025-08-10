function X = gauss(A, B, n);

    AB = [A, B];

    for k = 1:n-1
        temp = AB(k, k);
        for j = k:size(AB, 2)
            AB(k, j) = AB(k, j)/temp;
        end
        for i = k+1:n   
            factor = AB(i, k);
            for j = k:size(AB, 2)
                AB(i, j) = AB(i, j) - AB(k, j) * factor;
            end
        end
    end

    AB(end, end) = AB(end, end)/AB(end, end-1);
    AB(end, end-1) = 1;

    X = [];
    X(end+1) = AB(end, end)/AB(end, end-1);

    n = size(A, 1);

    for i = n-1:-1:1
        res = AB(i, end);
        for j = (i+1):n 
            res = res - AB(i, j)*X(end-j+i+1);
        end
        X(end+1) = res;
    end

    return;
endfunction