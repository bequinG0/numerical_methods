k = poly([-0.2, -6, 6, -8, -1, -5, 7, 8]);
f = @(x) polyval(k, x);

a = -8.1;
b = -7.5;
N = 1;
h_min = (b-a)/10000;
%[left, right] = RootsSeparation(f, a, b, N, h_min, 0)
[r, x_list] = bisection(f, a, b, 1e-3, 0)
errors = [];
for i = 1:length(x_list)
    errors(end+1) = abs(x_list(i) - r);
endfor
errors = abs(x_list - r);
errors(errors == 0) = eps;
semilogy(1:length(errors), errors, '-o');
xlabel('k');
ylabel('Err');
title('Сходимость метода биссекции');
grid on;

waitfor(gcf);

f = @(x) x.^3 - x;

a = -0.5;
b = 1;
h_min = (b-a)/10000;
[left, right] = RootsSeparation(f, a, b, N, h_min, 0);
[r, x_list] = bisection(f, left(1), right(1), 1e-3, 0)
errors = [];
for i = 1:length(x_list)
    errors(end+1) = abs(x_list(i) - r);
endfor
errors = abs(x_list - r);
errors(errors == 0) = eps;
semilogy(1:length(errors), errors, '-o');
xlabel('k');
ylabel('Err');
title('Сходимость метода биссекции');
grid on;
waitfor(gcf);


f = @(x) sign(x)*sqrt(abs(x));

a = -0.5;
b = 1;
h_min = (b-a)/10000;
[left, right] = RootsSeparation(f, a, b, N, h_min, 0)
[r, x_list] = bisection(f, left(1), right(1), 1e-3, 0);
x_list(end)
errors = [];
for i = 1:length(x_list)
    errors(end+1) = abs(x_list(i) - r);
endfor
errors = abs(x_list - r);
errors(errors == 0) = eps;
semilogy(1:length(errors), errors, '-o');
xlabel('k');
ylabel('Err');
title('Сходимость метода биссекции');
grid on;
waitfor(gcf);
%}
