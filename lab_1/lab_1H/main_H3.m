f = @(t) t^4 - 6*t^3 + 3*t^2 + 26*t - 24;

[left, right] = RootsSeparation(f, -2.1, 4.1, 4, 1e-6, 0);
t_list = [];
for i = 1:4
    t_list(end+1) = fzero(f, [left(i), right(i)]);
endfor

t_list
t_roots = roots([1, -6, 3, 26, -24])
x_fzero = []; x_roots = [];
for i = 1:4
    x_fzero(end+1) = log(t_list(i));
    x_roots(end+1) = log(t_roots(i));
endfor
x_fzero
x_roots