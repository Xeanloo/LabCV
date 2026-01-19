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

R4 = R3 * R2 * R1;

X = R4 * X;

figure(1);
plot3(X(1, :), X(2, :), X(3, :), 'xb'); axis equal;

%% b)
% Hauptkomponenten bestimmen (Eigenwerte und Eigenvektoren der
% Kovarianzmatrix der Punktmenge berechnen)

% TODO

% Kovarianzmatrix berechnen
% wichtig: jede Spalte ist ein Datenpunkt
C = cov(X');

% Eigenwerte und Eigenvektoren berechnen
[Vt, Dt] = eig(C);

% Hauptkomponenten (Eigenvektoren) sortieren nach Eigenwerten (absteigend)
[~, idx] = sort(diag(Dt), 'descend');
V = Vt(:, idx);
D = Dt(idx, idx);

%% c)
% Hauptachsen (Eigenvektoren) plotten und deren Länge mit dem zugehörigen
% Eigenwert gewichten
hold on;
origin = mean(X, 2);
for i = 1:3
    eigvec = V(:, i);
    eigval = D(i, i);
    quiver3(origin(1), origin(2), origin(3), ...
            eigvec(1) * eigval, eigvec(2) * eigval, eigvec(3) * eigval, ...
            'LineWidth', 2, 'MaxHeadSize', 0.5, 'Color', 'r', 'AutoScale', 'off');
end


%% d)
% Projektion auf eine der Hauptachsen über Skalarprodukt
% Tipp: Eigenvektoren haben die Länge 1

% TODO
% Projektion auf die erste Hauptkomponente
pc1 = V(:, 1);
projections1 = pc1' * (X - origin); % zentrieren und projizieren

pc2 = V(:, 2);
projections2 = pc2' * (X - origin); % zentrieren und projizieren

pc3 = V(:, 3);
projections3 = pc3' * (X - origin); % zentrieren und projizieren

% Varianz in der Projektion
variance_proj_1 = var(projections1');
disp(['Varianz der Projektion auf die erste Hauptkomponente: ', num2str(variance_proj_1)]);

variance_proj_2 = var(projections2');
disp(['Varianz der Projektion auf die zweite Hauptkomponente: ', num2str(variance_proj_2)]);

variance_proj_3 = var(projections3');
disp(['Varianz der Projektion auf die dritte Hauptkomponente: ', num2str(variance_proj_3)]);

figure(2);
% Plot the projections in 1D-space
hold on;
plot(projections1, 1*ones(size(projections1)), 'xr', 'MarkerSize', 8);
plot(projections2, 2*ones(size(projections2)), 'xg', 'MarkerSize', 8);
plot(projections3, 3*ones(size(projections3)), 'xb', 'MarkerSize', 8);
xlim([-10 10]);
ylim([0 4]);
yticks([1 2 3]);
yticklabels({'1. Hauptkomponente', '2. Hauptkomponente', '3. Hauptkomponente'});
title('Projektionen auf die Hauptkomponenten');
xlabel('Projektion');
ylabel('Hauptkomponente');
hold off;

% Varianz der Originaldaten
variance_orig = var(X');
disp(['Varianz der Originaldaten: ', num2str(variance_orig)]);


%% e)
% Rekonstruktion aus 1D-Unterraum und Plot
% Rekonstruktion der Punkte aus der Projektion auf die erste Hauptkomponente
reconstructed_X = origin + (pc1 * projections1);
reconstructed_Y = origin + (pc2 * projections2);
reconstructed_Z = origin + (pc3 * projections3);
% TODO
figure(3);
axis equal;
hold on;
plot3(X(1, :), X(2, :), X(3, :), 'xb');
plot3(reconstructed_X(1, :), reconstructed_X(2, :), reconstructed_X(3, :), 'or');
plot3(reconstructed_Y(1, :), reconstructed_Y(2, :), reconstructed_Y(3, :), 'or');
plot3(reconstructed_Z(1, :), reconstructed_Z(2, :), reconstructed_Z(3, :), 'or');

Xlines = [X(1,:); reconstructed_X(1,:); nan(1,size(X,2))];
Ylines = [X(2,:); reconstructed_X(2,:); nan(1,size(X,2))];
Zlines = [X(3,:); reconstructed_X(3,:); nan(1,size(X,2))];

plot3(Xlines(:), Ylines(:), Zlines(:), 'k-')
legend('Originalpunkte', 'Rekonstruierte Punkte aus 1D', 'Rekonstruierte Punkte aus 2D', 'Rekonstruierte Punkte aus 3D', 'Projektionslinien');


%% f)
% Projektion in den 2D-Unterraum der ersten beiden Hauptkomponenten und Rekonstruktion

% TODO
figure(4);
subplot(1, 2, 1);
axis equal;
hold on;
projections_2D = [projections1; projections2]; % 2D-Projektionen
plot(projections_2D(1, :), projections_2D(2, :), 'xm');
xlabel('Projektion auf 1. Hauptkomponente');
ylabel('Projektion auf 2. Hauptkomponente');
title('Projektionen in den 2D-Unterraum der ersten beiden Hauptkomponenten');


figure(4)
subplot(1, 2, 2);
reconstructed_X_2D = origin + (pc1 * projections_2D(1, :)) + (pc2 * projections_2D(2, :)); % Rekonstruktion aus 2D
plot3(X(1, :), X(2, :), X(3, :), 'xb');
hold on;
plot3(reconstructed_X_2D(1, :), reconstructed_X_2D(2, :), reconstructed_X_2D(3, :), 'or');
legend('Originalpunkte', 'Rekonstruierte Punkte aus 2D');


% mittlerer quadratischer Rekonstruktionsfehler

% TODO
mse_2D = mean(sum((X - reconstructed_X_2D).^2, 1));
disp(['Mittlerer quadratischer Rekonstruktionsfehler (2D): ', num2str(mse_2D)]);
title('Rekonstruktionfehler aus 2D-Projektion: ', num2str(mse_2D));
mse_1D = mean(sum((X - reconstructed_X).^2, 1));
disp(['Mittlerer quadratischer Rekonstruktionsfehler (1D): ', num2str(mse_1D)]);


