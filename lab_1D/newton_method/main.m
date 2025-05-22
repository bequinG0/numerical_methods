% Условие сходимости метода Ньютона выполнено => последовательность x_k сходиться к корню на отрезке

k = poly([-0.2, -6, 6, -8, -1, -5, 7, 8]);
f = @(x) polyval(k, x);

a = -8.1;
b = 8.1;
N = 8;
h_min = (b-a)/10000;
[left, right] = RootsSeparation(f, a, b, N, h_min, 0);
r = [];
for i = 1:N 
    r(end+1) = newton_method(f, left(i), right(i), 1e-3, 0);
endfor
r
waitfor(gcf);

% Условие сходимости метода Ньютона невыполнено, однако последовательность x_k сходится к корню на отрезке
f = @(x) x.^3 - x;

a = -1;
b = 1;
h_min = (b-a)/10000;
[left, right] = RootsSeparation(f, a, b, 2, h_min, 0);
r_2 = newton_method(f, left(1), right(1), 1e-6, 0)
r_3 = newton_method(f, left(2), right(2), 1e-6, 0)
waitfor(gcf);

% Условие сходимости метода Ньютона невыполнено, однако последовательность x_k не сходится к корню на отрезке

f = @(x) sign(x).*sqrt(abs(x));

a = -1;
b = 1;
h_min = (b-a)/10000;
[left, right] = RootsSeparation(f, a, b, 1, h_min, 0)
r_4 = newton_method(f, left(1), right(1), 1e-8, 1)
waitfor(gcf);