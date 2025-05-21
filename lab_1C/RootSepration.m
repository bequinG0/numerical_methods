

function [A, B] = RootsSeparation(f, a, b, N, Hmin, PlotFlag)
  temp = a;
  A = [];
  B = [];
  while (N > 0) && (temp < b)
    if sign(f(temp)) ~= sign(f(temp + Hmin))
      A = [A, temp];
      B = [B, temp+Hmin];
      N = N - 1;
    endif
    temp = temp + Hmin;
  endwhile

  if PlotFlag == 1
    figure;
    hold on;
    grid on;
    x = linspace(a, b, 1000);
    plot(x, f(x), 'b', 'LineWidth', 2);
    plot(A, zeros(size(A)), 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
    plot(B, zeros(size(B)), 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
    xlabel('x');
    ylabel('f(x)');
    title('Интервалы с корнями (отмечены красным)');
    legend('Функция', 'Границы интервалов', 'Location', 'northwest');
  endif
endfunction
%}

k = poly([-0.2, -6, 6, -8, -1, -5, 7, 8]);
f = @(x) polyval(k, x);

a = -10;
b = 10;
h_min = (b-a)/1e6;
[A, B] = RootsSeparation(f, -10, 10, 8, h_min, 0);
A
B
