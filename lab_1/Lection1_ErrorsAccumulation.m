% ÑÓÌÌÈÐÎÂÀÍÈÅ ÐßÄÀ

% Ïîëîæèòåëüíûå x
x = 1;
N = 15; %3; % 15
S = 0;
for k = 0 : N
    S = S + x^k / factorial(k);
end
AbsErr = abs(S - exp(x))
RelErr = AbsErr / exp(x)

% Êàêîå ìàêñèìàëüíîå N âûáèðàòü?
x = 1;
N = 170; % ïî÷åìó íå áîëüøå? factorial(171)
S = 0;
for k = 0 : N
    S = S + x^k / factorial(k);
end
AbsErr = abs(S - exp(x))
RelErr = AbsErr / exp(x)

% ÎÒÐÈÖÀÒÅËÜÍÛÅ x
x = -30; % -5; -20 (!); -30 (!!!)
N = 170;
S = 0;
for k = 0 : N
    S = S + x^k / factorial(k);
end
AbsErr = abs(S - exp(x))
RelErr = AbsErr / exp(x)
% S
% exp(x)

% ÏÐÀÂÈËÜÍÎ äëÿ x < 0
x = -30;
N = 170;
S = 0;
x1 = -x;
for k = 0 : N
    S = S + x1^k / factorial(k);
end
S = 1/S;
AbsErr = abs(S - exp(x))
RelErr = AbsErr / exp(x)
% S
% exp(x)

% ÂÛ×ÈÑËÅÍÈÅ ÏÐÎÈÇÂÎÄÍÎÉ f(x)
f = @(x)sin(x);
df = @(x)cos(x); % òî÷íîå çíà÷åíèå ïðîèçâîäíîé
Dx = 1e-2;      % øàã 1e-2; 1e-6; 1e-8; 1e-10 (!); 1e-14 (!); 1e-16 (!)
x = 0.8;
fx = (f(x+Dx) - f(x)) / Dx;
fx - df(x)

% ÐÅØÅÍÈÅ ÑËÀÓ Ax = b
%A = hilb(15);
%save('A.txt', 'A', '-ascii','-double')
A = load('A.txt') % ñ÷èòûâàåì ìàòðèöó À èç ôàéëà A.txt
xs = ones(15, 1)  % ñîçäàåì âåêòîð èç âñåõ 1 (òî÷íîå ðåøåíèå xs)
b = A*xs          % âû÷èñëÿåì ïðàâóþ ÷àñòü b, ñîîòâåòñòâóþùóþ òî÷íîìó ðåøåíèþ xs
x = A \ b;        % ðåøàåì ÑËÀÓ Ax = b
r = b - A*x       % âû÷èñëÿåì íåâÿçêó (ïðîâåðêà?)
x

