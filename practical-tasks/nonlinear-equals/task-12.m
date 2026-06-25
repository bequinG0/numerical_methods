warning('off', 'Octave:missing-FcInit');

% численнное решение уравнения x - sin(x) = 0.25

fprintf("[*] численнное решение уравнения x - sin(x) = 0.25\n");

f = @(x) x - sin(x) - 0.25;

[left, right] = RootsSeparation(f, 0, 2, 100, 0.01, 1)

roots_1 = [];
roots_2 = [];
roots_3 = [];

for i = 1:length(left)
    [roots_1, ~] = edit_bisection(f, left(i), right(i), 1e-3, 0);
    [roots_2, ~] = newton_method(f, left(i), right(i), 1e-3, 0);
    [roots_3, ~] = secant_method(f, left(i), right(i), 1e-3, 0);
end

roots_1 
roots_2 
roots_3

print('../reports/.png/xsinx.png', '-dpng', '-r300');
waitfor(gcf);

% численное решение уравнения e^x - x^2 = 0

fprintf("[*] численнное решение уравнения e^x - x^2 = 0\n");
f = @(x) exp(x) - x.^2;

[left, right] = RootsSeparation(f, -1, 0, 100, 0.01, 1)

roots_1 = [];
roots_2 = [];
roots_3 = [];

for i = 1:length(left)
    [roots_1, ~] = edit_bisection(f, left(i), right(i), 1e-3, 0);
    [roots_2, ~] = newton_method(f, left(i), right(i), 1e-3, 0);
    [roots_3, ~] = secant_method(f, left(i), right(i), 1e-3, 0);
end

roots_1 
roots_2 
roots_3

print('../reports/.png/exx2.png', '-dpng', '-r300');
waitfor(gcf);

% численное решение уравнения x^3 + 3x^2 - 24x + 1 = 0

fprintf("[*] численнное решение уравнения x^3 + 3x^2 - 24x + 1 = 0\n");
f = @(x) x.^3 + 3*x.^2 - 24*x + 1;

[left, right] = RootsSeparation(f, -7, 5, 100, 0.01, 1)

roots_1 = [];
roots_2 = [];
roots_3 = [];

for i = 1:length(left)
    [roots_1(end+1), ~] = edit_bisection(f, left(i), right(i), 1e-3, 0);
    [roots_2(end+1), ~] = newton_method(f, left(i), right(i), 1e-3, 0);
    [roots_3(end+1), ~] = secant_method(f, left(i), right(i), 1e-3, 0);
end

roots_1 
roots_2 
roots_3

print('../reports/.png/x3.png', '-dpng', '-r300');
waitfor(gcf);


