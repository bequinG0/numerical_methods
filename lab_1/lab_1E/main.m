k = poly([-0.2, -6, 6, -8, -1, -5, 7, 8]);
f = @(x) polyval(k, x);

a = -8.1;
b = -7.5;
N = 1;
h_min = (b-a)/1000;
[left, right] = RootsSeparation(f, a, b, N, h_min, 0);
[r, x_list] = edit_secant_method(f, left(1), right(1), 1e-6, 0); %поменять название метод
fprintf("%.20f\n", r);
r 
hold on;
errors = [];
for i = 1:length(x_list)
    errors(end+1) = abs(x_list(i) - r);
endfor
errors = abs(x_list - r);
errors(errors == 0) = eps;
semilogy(1:length(errors), errors, '-o');
xlabel('k');
ylabel('Err');
title('Сходимость метода (блок Е)');
grid on;

waitfor(gcf);

% Для g(x) процесс работает неправильно

g = @(x) abs(x);
a = -1;
b = 0.5;
N = 1;
x_list = [];
h_min = (b-a)/1000;
%[left, right] = RootsSeparation(g, a, b, N, h_min, 0);
[r, x_list] = edit_bisection(g, a, b, 1e-6, 0);
r 