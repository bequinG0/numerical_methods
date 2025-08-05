format long e

fprintf("[*] Вычисление экспоненты e^x\n");

% Вычисление экспоненты

x = 1;
ex = exp(x);

fact = 1;
N = 170;
S = 0;

if x > 0 % В случае положительных x ищем сумму в прямом виде
  for k = 0:100
    if k!=0
      fact = fact * k;
    endif
    S += x^k/fact;
  end
else % В случае отрицательных x ищем обратную величину для суммы
  for k = 0:100
    if k!=0
      fact = fact * k;
    endif
    S += (-x)^k/fact;
  end
  S = 1/S;
endif

err = abs(ex - S); % Абсолютная ошибка
o_err = err/ex; % Относитальная ошибка

fprintf("e^x = %.20f\n", ex);
fprintf("S_N = %.20f\n", S);
fprintf("err = %.20f\n", err);
fprintf("o_err = %.20f\n\n", o_err);

%Подсчёт суммы 1/k^2
#{
fprintf("[*] Подсчёт суммы 1/k^2\n");

s_1 = 0;
s_2 = 0;
for k = 1:1e9 % По возрастанию
  s_1 += 1/k^2;
end


for k = 1e9:-1:1 % По убыванию
  s_2 += 1/k^2;
end

%Символьные вычисления

syms k;
vpa(symsum(1/k^2, k, 1, inf), 20)

err_1 = abs(s_1 - double(vpa(symsum(1/k^2, k, 1, inf), 20)));
err_2 = abs(s_2 - double(vpa(symsum(1/k^2, k, 1, inf), 20)));
o_err_1 = err_1/double(vpa(symsum(1/k^2, k, 1, inf), 20));
o_err_2 = err_2/double(vpa(symsum(1/k^2, k, 1, inf), 20));

fprintf("s_1 = %.20f\n", s_1);
fprintf("s_2 = %.20f\n", s_2);
fprintf("err_1 = %.20f\n", err_1);
fprintf("err_2 = %.20f\n", err_2);
fprintf("o_err_1 = %.20f\n", o_err_1);
fprintf("o_err_2 = %.20f\n\n", o_err_2);
#}
 %Вычисление суммы \sum \limits_{k=1}^{n} x^k

fprintf("[*] Вычисление суммы x^k\n");

x_1 = 2;
x_2 = 7/3;

S_1 = zeros(1, 9);
S_2 = zeros(1, 9);
k = zeros(1, 9);

for i = 2:10
  k = 1:i;
  S_1(i-1) = sum(x_1.^k);
  S_2(i-1) = sum(x_2.^k);
endfor

for i = 1:9
  fprintf("S_1[%d] = %.20f\n", i, S_1(i));
  fprintf("S_2[%d] = %.20f\n", i, S_2(i));
endfor

S_1(end);

% Вычисление производной функции

x = 0.8;
dx = logspace(-25, 0, 1000);
dx_1 = linspace(1e-25, 1, 1000);

err = abs(((sin(x+dx)-sin(x))./dx) - cos(x));

figure(1);
hold on;
grid on;

loglog(dx, err, 'r', 'LineWidth', 2);

err_2 = abs(( x + dx - x)./dx - 1);
loglog(dx, err_2, 'b', 'LineWidth', 2);

xlabel('Шаг h');
ylabel('Ошибка E(h)');
title('Зависимость ошибки численного дифференцирования от шага h');

figure(2);

hold on;
grid on;

plot(dx_1, err_2, 'r', 'LineWidth', 2);
xlabel('Шаг h');
ylabel('Ошибка E(h)');
title('Зависимость ошибки численного дифференцирования от шага h');

