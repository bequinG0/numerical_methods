k = poly([-0.2, -6, 6, -8, -1, -5, 7, 8]);
f = @(x) polyval(k, x);

a = -10;
b = 10;
h_min = (b-a)/1e6;
[A, B] = RootsSeparation(f, -10, 10, 8, h_min, 0);
A
B
