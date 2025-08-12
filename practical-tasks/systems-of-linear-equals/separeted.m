function TEMP = separeted(A, a, b, n)
    TEMP = zeros(n-1, n-1);
    row = 1;
    for i = 1:n
        if i ~= a
            col = 1;
            for j = 1:n
                if j ~= b
                    TEMP(row, col) = A(i, j);
                    col = col + 1;
                end
            end
            row = row + 1;
        end
    end
end