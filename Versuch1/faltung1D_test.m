% Script zur Einführung in die eindimensionale Faltung

%% Testfunktion

% generiere Stützstellen, an denen die Funktion ausgewertet werden soll
dx = 0.5;
xs = -5:dx:5;

x = 1/4 * sqrt(abs(xs));
% x = xs.^3 + xs + 1;

%% Faltung

% Filterkern f
f = 1/dx * [1/2, 0, -1/2];
f2 = 1/dx * [1, -1, 0];
f3 = 1/dx * [0, 1, -1];
f4 = 1/dx^2 * [1, -2, 1];

% TODO b)

y = conv(x, f, 'same');
y_2 = conv(x, f2, 'same');
y_3 = conv(x, f3, 'same');
y_4 = conv(x, f4, 'same');
%% Darstellung

figure(1);
clf;

subplot(1, 5, 1);
plot(xs, x, '-b.');
title('Funktion');
subplot(1, 5, 2);
plot(xs, y, '-b.');
title(['Ergebnis mit Filter ', mat2str(f)]);
subplot(1, 5, 3);
plot(xs, y_2, '-b.');
title(['Ergebnis mit Filter ', mat2str(f2)]);

subplot(1, 5, 4);
plot(xs, y_3, '-b.');
title(['Ergebnis mit Filter ', mat2str(f3)]);

subplot(1, 5, 5);
plot(xs, y_4, '-b.');
title(['Ergebnis mit Filter ', mat2str(f4)]);


%% Randbehandlung
% TODO c)
m = floor(length(f)/2);
x_zero_padded = padarray(x, [0, m], 0, 'both');
x_mirror_padded = padarray(x, [0, m], 'symmetric', 'both');

y_zero = conv(x_zero_padded, f, 'valid');
y_mirror = conv(x_mirror_padded, f, 'valid');

figure(2);
clf;
subplot(1, 3, 1);
plot(xs, x, '-b.');
title('Original Function');
subplot(1, 3, 2);
plot(xs, y_zero, '-r.');
title('Zero-Padded');
subplot(1, 3, 3);
plot(xs, y_mirror, '-g.');
title('Mirrored');