function X = sweep(A, B, n)

    a = zeros(1,n);  
    b = zeros(1,n);  
    c = zeros(1,n);  

    for i = 1:n
        b(i) = A(i,i);
        if i > 1
            a(i) = A(i,i-1);
        end
        if i < n
            c(i) = A(i,i+1);
        end
    end

    alpha = zeros(1,n);
    beta  = zeros(1,n);

    alpha(1) = -c(1)/b(1);
    beta(1)  = B(1)/b(1);

    for i = 2:n-1
        denom   = b(i) + a(i) * alpha(i-1);
        alpha(i)= -c(i)/denom;
        beta(i) = (B(i) - a(i)*beta(i-1)) / denom;
    end

    denom = b(n) + a(n) * alpha(n-1);
    beta(n) = (B(n) - a(n)*beta(n-1)) / denom;

    X = zeros(1,n);
    X(n) = beta(n);

    for i = n-1:-1:1
        X(i) = alpha(i)*X(i+1) + beta(i);
    end

    X = sort(X);
    return;
end