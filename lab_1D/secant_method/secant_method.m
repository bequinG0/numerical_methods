function root = secant_method(f, a, b, e, PlotFlag)
    dx = 1e-6;
    x = [b, b-dx];
    while (abs(f(x(end))) > e) && ((x(end) >= a) && (x(end) <=b))
        x(end+1) = x(end) - f(x(end)) .* ((x(end) - x(end-1))./(f(x(end)) - f(x(end-1))));
    endwhile

    if PlotFlag == 1
        figure;
        hold on;
        grid on;
        t = linspace(a, b, 1000);
        plot(t, f(t), 'b', 'LineWidth', 2);
        plot(x(end), f(x(end)), 'ro', 'MarkerSize', 2, 'LineWidth', 3);
        xlabel('x');
        ylabel('f(x)');
        title('Интервалы с корнями (отмечены красным)');
        legend('Функция', 'Корень', 'Location', 'northwest');
    endif

    root = x(end);

endfunction