warning('off', 'Octave:missing-FcInit');

fprintf("[*] Решение СЛАУ методом Гаусса\n");

A = [5.64, -4.52, 4.57;
    -2.17, 1.36, -5.53;
    8.77, -2.78, 5.44];

B = [8.32, 7.21, 7.56];

AB = [5.64, -4.52, 4.57, 8.32;
    -2.17, 1.36, -5.53, 7.21;
    8.77, -2.78, 5.44, 7.56];

n = size(AB, 1);

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
AB 

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



AB(1, 1)*X(1) + AB(1, 2)*X(2) + AB(1,3)*X(3) 
X
