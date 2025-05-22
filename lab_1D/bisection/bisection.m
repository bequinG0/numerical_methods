function [roots, x_list] = bisection(f, a, b, e, PlotFlag)
    x_list = [];
    k = 0;
    x_list(end+1) = (a+b)/2;
    while (abs(f(x_list(end))) > e) && k < 1000 
        if sign(f(x_list(end))) == sign(f(a))
            a = x_list(end);
        else
            b = x_list(end);
        endif
        x_list(end+1) = (a+b)/2;
        k = k + 1;
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
        title('Бисекция');
        legend('Функция', 'Корень', 'Location', 'northwest');
    endif

    roots = x_list(end);
endfunction