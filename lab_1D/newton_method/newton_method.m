function [root, x_list] = newton_method(f, a, b, e, PlotFlag)
    x_list = [b];
    dx = 1e-6;
    while (abs(f(x_list(end))) > e) && ((x_list(end) <= b) && (x_list(end) >= a))
        df = (f(x_list(end) + dx) - f(x_list(end))) / dx;
        x_list(end+1) = x_list(end) - f(x_list(end)) / df;
    endwhile

    if PlotFlag == 1
        figure;
        hold on;
        grid on;
        t = linspace(a, b, 1000);
        plot(t, f(t), 'b', 'LineWidth', 2);
        plot(x_list(end), f(x_list(end)), 'ro', 'MarkerSize', 2, 'LineWidth', 3);
        xlabel('x');
        ylabel('f(x)');
        title('Метод Ньютона (касательных)');
        legend('Функция', 'Корень', 'Location', 'northwest');
    endif

    root = x_list(end);
endfunction