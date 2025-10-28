% Aufgabe 1
% a)
a = ones(1, 50) * 50; disp(a)
b = [1:2:50]'; disp(b)
c = reshape(1:100, 10, 10)'; disp(c);

% b)
% Normal Distribution, mean=2, var= 3. x from -10 to 10
mean = 2; var = 3;
x = linspace(-10,10,1000);
normalDist = (1/sqrt(2*pi*var)) * exp(-((x-mean).^2)/(2*var)); disp(normalDist);

% c)
function = 

