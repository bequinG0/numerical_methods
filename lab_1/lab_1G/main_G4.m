

f = @(x) 10^11 - sum(x.^(0:100) ./ factorial(0:100));
f
a = 20;
b = 50;

[left, right] = RootsSeparation(f, a, b, 1, 1e-3, 0);
r = fzero(f, [left(end), right(end)]);
[r_newton, ~] = edit_newton_method(f, left(end), right(end), 1e-6, 0);
fprintf("%.16f\n", r);
fprintf("%.16f\n", r_newton);
fprintf("%.16f\n", abs(r - r_newton));
