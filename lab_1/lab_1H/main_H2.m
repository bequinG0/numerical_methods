x = {[1:10], [1:20], [1:30]};
k = {poly(x{1}), poly(x{2}), poly(x{3})};

k_fix = k; 
k_fix{1}(2) = k_fix{1}(2) + 1e-3;    
k_fix{2}(2) = k_fix{2}(2) + 2^(-23);   
k_fix{3}(2) = k_fix{3}(2) + 1e-7;    

for i = 1:3
    x_original = roots(k{i});
    x_perturbed = roots(k_fix{i});
    
    fprintf('\nПолином степени %d\n', i*10);
    fprintf('================================\n');
    x_original = sort(x_original);
    x_perturbed = sort(x_perturbed);
    
    fprintf('%5s %20s %20s %12s\n', 'Корень', 'Оригинал', 'Возмущенный', 'Разница');
    for j = 1:min(length(x_original), length(x_perturbed))
        fprintf('%5d %20.16f %20.16f %12.4e\n', j, x_original(j), x_perturbed(j), abs(x_original(j) - x_perturbed(j)));
    end
    
    complex_roots = x_perturbed(abs(imag(x_perturbed)) > 1e-10);
    if ~isempty(complex_roots)
        fprintf('\nОбнаружены комплексные корни:\n');
        disp(complex_roots);
    end
end