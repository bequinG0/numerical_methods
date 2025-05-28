function [root, x_list] = secant_method(f, a, b, e, PlotFlag)
    dx = 1e-6;
    x_list = [b, b-dx];
    while (abs(f(x_list(end))) > e) && ((x_list(end) >= a) && (x_list(end) <=b))
        x_list(end+1) = x_list(end) - f(x_list(end)) .* ((x_list(end) - x_list(end-1))./(f(x_list(end)) - f(x_list(end-1))));
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
        title('Метод секущих');
        legend('Функция', 'Корень', 'Location', 'northwest');
    endif

    root = x_list(end);
endfunction
