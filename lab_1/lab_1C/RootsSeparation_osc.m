function [A, B] = RootsSeparation_osc(f, a, b, N, Hmin, PlotFlag)
  temp = b;
  A = [];
  B = [];
  count_roots = 0;
  while (N > 0) && (temp > a)
    if sign(f(temp)) ~= sign(f(temp + Hmin))
      A = [A, temp-Hmin];
      B = [B, temp+Hmin];
      N = N - 1;
      count_roots = count_roots + 1;
      Hmin = Hmin / (2*f(count_roots));
    endif
    temp = temp - Hmin;
  endwhile

  if PlotFlag == 1
    figure;
    hold on;
    grid on;
    x = linspace(a, b, 1000);
    plot(x, f(x), 'b', 'LineWidth', 2);
    plot(A, zeros(size(A)), 'ro', 'MarkerSize', 2, 'LineWidth', 1.5);
    plot(B, zeros(size(B)), 'ro', 'MarkerSize', 2, 'LineWidth', 1.5);
    xlabel('x');
    ylabel('f(x)');
    title('Интервалы с корнями (отмечены красным)');
    legend('Функция', 'Границы интервалов', 'Location', 'northwest');
  endif
endfunction
