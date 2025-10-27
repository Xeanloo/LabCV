% Script zur Einführung in die eindimensionale Faltung

%% Testfunktion

% a) Das Resultat ist auf die zentrale Überlappung der Faltung beschränkt
% Das Ergebnis hat die gleiche Größe wie das erste Eingabeargument

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
