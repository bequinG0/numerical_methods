f = @(x)x^3
a = -1;
b = 1;
epsilon = 1e-5;
while b - a > epsilon
  c = 0.5*(a+b);
  if f(a) * f(c) < 0
    b = c;
  else
    a = c;
  end
end
c
