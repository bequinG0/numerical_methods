% Параметры задачи
x = 0.8;                     % Точка, в которой вычисляем производную
dx = logspace(-25, 0, 1000); % Диапазон шагов от 1e-25 до 1
true_derivative = cos(x);    % Точное значение производной

% Вычисление ошибки для прямой разностной схемы
num_derivative = (sin(x + dx) - sin(x)) ./ dx;
err = abs(num_derivative - true_derivative);

% Построение графика
figure;
loglog(dx, err, 'r', 'LineWidth', 2);
hold on;
grid on;

% Теоретические кривые ошибок
epsilon = eps(1);            % Машинное эпсилон (~2.22e-16)
trunc_error = dx/2;          % Ошибка усечения O(h)
round_error = epsilon./dx;   % Ошибка округления O(ε/h)

loglog(dx, trunc_error, 'b--', 'LineWidth', 1.5);
loglog(dx, round_error, 'g--', 'LineWidth', 1.5);

% Настройка графика
xlabel('Шаг h');
ylabel('Ошибка E(h)');
title('Зависимость ошибки численного дифференцирования от шага h');
legend('Практическая ошибка', 'Теоретическая ошибка усечения', ...
       'Теоретическая ошибка округления', 'Location', 'best');

% Нахождение оптимального шага
[~, idx] = min(err);
optimal_h = dx(idx);
fprintf('Оптимальный шаг: %.3e\n', optimal_h);
