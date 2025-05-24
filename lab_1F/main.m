% Визуализация метода Ньютона

f = @(x) x.^3 + 2*x.^2 - 2*x - 1;

a = -4;
b = 4;
N = 3;
e = 1e-6;
[left, right] = RootsSeparation(f, a, b, N, 0.1, 0)
r = [];
x_list = [];
for i = 1:N 
    temp_r = 0; temp_x = [];
    [temp_r, temp_x] = newton_method(f, left(i), right(i), e, 0); % если в названии поменять метод, то можно увидеть визуализацию метода секущих
    r(end+1) = temp_r;
    x_list = [x_list, temp_x];
endfor 

x_list
r
y = {};
for i = 1:length(x_list)
    df = (f(x_list(i)+e) - f(x_list(i)))/e;
    y{i} = @(x) f(x_list(i)) + df * (x - x_list(i));
endfor

figure(1);
clf;
hold on;
grid on;
space = linspace(a, b, 1000);
color = ['r', 'g', 'b'];
for i = 1:length(x_list)
    if ismember(x_list(i), r)
        plot(space, y{i}(space), 'r', 'LineWidth', 1);
    else 
        plot(space, y{i}(space), 'g', 'LineWidth', 1);
    endif
endfor
plot(space, f(space), 'b-', 'LineWidth', 2);
for i = 1:N
    plot(r(i), 0, 'o', 'Color', 'r', 'MarkerFaceColor', 'r');    
endfor
xlabel('x');
ylabel('y');
title('Метод Ньютона');
waitfor(gcf);

