% 1

f = @(x) sin(x.^2) - cos(x).*sqrt(x+1);

left = []; right = [];
a = -1;
b = 2;
N = 3;
TolX = 1e-8;
[left, right] = RootsSeparation(f, a, b, N, 0.01, 0);
x_newton = [];
for i = 1:N
    temp_r = 0; temp_x = [];
    [temp_r, temp_x] = edit_newton_method(f, left(i), right(i), TolX, 0);
    x_newton = [x_newton, temp_r];
endfor
x_fzero = [];
for i = 1:N 
    x_fzero = [x_fzero, fzero(f, [left(i), right(i)])];
endfor 
errors = [];
for i = 1:N
    errors(end+1) = abs(x_fzero(i) - x_newton(i));
endfor
x_fzero
x_newton
errors

% 2
f = @(x) e.^(1 - x./10) - x.^2 + 6 - 2.*x.*sin(x);

left = []; right = [];
a = -4.5;
b = -2;
N = 3;
TolX = 1e-8;
[left, right] = RootsSeparation(f, a, b, N, 0.01, 0);
x_newton = [];
for i = 1:N
    temp_r = 0; temp_x = [];
    [temp_r, temp_x] = edit_newton_method(f, left(i), right(i), TolX, 0);
    x_newton = [x_newton, temp_r];
endfor
x_fzero = [];
for i = 1:N 
    x_fzero = [x_fzero, fzero(f, [left(i), right(i)])];
endfor 
errors = [];
for i = 1:N
    errors(end+1) = abs(x_fzero(i) - x_newton(i));
endfor
x_fzero
x_newton
errors

% 3
f = @(x) log(2*x + 1) - exp(x).*sin(x);

left = []; right = [];
a = -0.1;
b = 3.5;
N = 3;
TolX = 1e-8;
[left, right] = RootsSeparation(f, a, b, N, 0.001, 0);
x_newton = [];
for i = 1:N
    temp_r = 0; temp_x = [];
    [temp_r, temp_x] = edit_newton_method(f, left(i), right(i), TolX, 0);
    x_newton = [x_newton, temp_r];
endfor
x_fzero = [];
for i = 1:N 
    x_fzero = [x_fzero, fzero(f, [left(i), right(i)])];
endfor 
errors = [];
for i = 1:N
    errors(end+1) = abs(x_fzero(i) - x_newton(i));
endfor
x_fzero
x_newton
errors

% 4

f = @(x) sqrt(2.*x - 4) - (2.*x - 5).^(1./3) .* sin(x./5) - pi./2;

left = []; right = [];
a = 9;
b = 10;
N = 1;
TolX = 1e-8;
[left, right] = RootsSeparation(f, a, b, N, 0.01, 0);
x_newton = [];
for i = 1:N
    temp_r = 0; temp_x = [];
    [temp_r, temp_x] = edit_newton_method(f, left(i), right(i), TolX, 0);
    x_newton = [x_newton, temp_r];
endfor
x_fzero = [];
for i = 1:N 
    x_fzero = [x_fzero, fzero(f, [left(i), right(i)])];
endfor 
errors = [];
for i = 1:N
    errors(end+1) = abs(x_fzero(i) - x_newton(i));
endfor
x_fzero
x_newton
errors
