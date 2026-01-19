%% a)
% Punkte generieren und plotten
n = 50;
X = zeros(3, n);

sx = 3;   tx = 5;
sy = 1;   ty = -3;
sz = 0.5; tz = -2;

X(1, :) = sx * randn(1, n) + tx;
X(2, :) = sy * randn(1, n) + ty;
X(3, :) = sz * randn(1, n) + tz;

w1 = 60;
w2 = 30;
w3 = 0;

R1 = [cosd(w1) -sind(w1) 0; sind(w1) cosd(w1) 0; 0 0 1];
R2 = [cosd(w2) 0 sind(w2); 0 1 0; -sind(w2) 0 cosd(w2)];
R3 = [1 0 0; 0 cosd(w3) -sind(w3); 0 sind(w3) cosd(w3)];

X = R3 * R2 * R1 * X;

figure(1);
plot3(X(1, :), X(2, :), X(3, :), 'xb'); axis equal;

%% b)
% Hauptkomponenten bestimmen (Eigenwerte und Eigenvektoren der
% Kovarianzmatrix der Punktmenge berechnen)

% TODO


%% c)
% Hauptachsen (Eigenvektoren) plotten und deren Länge mit dem zugehörigen
% Eigenwert gewichten

% TODO


%% d)
% Projektion auf eine der Hauptachsen über Skalarprodukt
% Tipp: Eigenvektoren haben die Länge 1

% TODO


% Varianz in der Projektion

% TODO


%% e)
% Rekonstruktion aus 1D-Unterraum und Plot

% TODO


%% f)
% Projektion in den 2D-Unterraum der ersten beiden Hauptkomponenten und Rekonstruktion

% TODO


% mittlerer quadratischer Rekonstruktionsfehler

% TODO

