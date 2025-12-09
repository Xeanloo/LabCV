% Aufgabe 3 - Ganzzahlige lineare Optimierung (Rucksackproblem)

% Gewichte der Objekte (kg)
weights = [3, 7, 4, 12, 8, 10, 9, 14, 10, 12];

% Nutzwerte der Objekte
values = [3, 5, 2, 11, 4, 6, 2, 15, 12, 9];

% Maximallast des Rucksacks (kg)
max_weight = 60;

% Zielfunktion für intlinprog (Minimierung).
% Da wir maximieren wollen, negieren wir die Nutzwerte.
f = -values;

% Indizes der ganzzahligen Variablen (alle 10 Variablen sind ganzzahlig)
intcon = 1:10;

% Ungleichungsbedingungen A*x <= b (Gewichtsbeschränkung)
A = weights;
b = max_weight;

% Untere und obere Schranken (binäre Entscheidung: 0 oder 1)
lb = zeros(10, 1);
ub = ones(10, 1);

% Lösen des Problems
[x, fval] = intlinprog(f, intcon, A, b, [], [], lb, ub);

% Ausgabe der Ergebnisse
fprintf('Ausgewählte Objekte (Indizes): \n');
selected_indices = find(round(x));
disp(selected_indices');

fprintf('Gesamtgewicht: %d kg\n', sum(weights(selected_indices)));
fprintf('Gesamtnutzwert: %d\n', -fval);
