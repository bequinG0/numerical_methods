%>>>>>>> origin/desktop
k = poly([-0.2, -6, 6, -8, -1, -5, 7, 8]);
f = @(x) polyval(k, x);

a = -8.1;
b = 8.1;
h_min = (b-a)/10000;
[A, B] = RootsSeparation(f, -8.1, 8.1, 8, h_min, 1);
A
B
waitfor(gcf);
%>>>>>>> origin/desktop
