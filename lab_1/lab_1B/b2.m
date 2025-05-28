f = @(x) cos(x);
a = 1; b = 2;
epsilon = 1e-16;
while b - a > epsilon
  c = 0.5 * (a + b);
  if sign(f(a)) ~= sign(f(c))
    b = c;
  else
    a = c;
  end
end
c
%На определённом шаге разность b-a станет равна 2e-16 что сравнимо с машинной погрешностью
