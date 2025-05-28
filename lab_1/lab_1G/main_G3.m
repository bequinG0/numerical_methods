a = 0:0.001:30;
f = @(x, a) log(x*a + 2) - exp(-a*x.^2 - x); 

roots = [];
for i = 1:length(a)
    roots(end+1) = fzero(@(x) f(x, a(i)), [0, 0.93]);
endfor

figure;
hold on;
grid on;
plot(a, roots, '.');
xlabel('a');
ylabel('roots');
waitfor(gcf);
