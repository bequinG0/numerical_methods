f = @(x) 10^11 - sum(arrayfun(@(k) x.^k/factorial(k), 0:100));

f(20)
f(50)

root = fzero(f, [20, 50]);

root