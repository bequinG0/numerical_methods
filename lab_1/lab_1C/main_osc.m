f = @(x) x .* sin(1 ./x);
x = linspace(0.01, 0.5, 1000);

figure;
hold on;
grid on;
plot(x, f(x), 'b', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('Интервалы с корнями (отмечены красным)');
legend('Функция', 'Границы интервалов', 'Location', 'northwest');

h_min = 0.001
[A, B] = RootsSeparation_osc(f, 0.01, 1, 8, h_min, 1);
A
B
waitfor(gcf);
