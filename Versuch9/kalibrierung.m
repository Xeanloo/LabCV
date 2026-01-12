close all
%% Verwendung gegebener Stereobilder
load('focusedStereoSetup.mat');
% load('parallelStereoSetup.mat');

%% Definition Kalibrierungsobjekt
Xw = [0, 0, 0; ... % 1 Ecke 1,3,5 (gelb, rot, blau)
      6, 0, 0; ... % 2 Ecke 1,4,5 (gelb, magenta, blau)
      0, 0, 6; ... % 3 Ecke 1,2,3 (gelb, cyan, rot)
      6, 0, 6; ... % 4 Ecke 1,2,4 (gelb, cyan, magenta)
      0, 6, 0; ... % 5 Ecke 3,5,6 (rot, blau, grün)
      6, 6, 0; ... % 6 Ecke 4,5,6 (magenta, blau, grün)
      0, 6, 6; ... % 7 Ecke 2,3,6 (cyan, rot, grün)
      6, 6, 6];    % 8 Ecke 2,4,6 (cyan, magenta, grün)
     
%% Plotte Kalibrierungsobjekt
figure(1); clf;
plotCube(Xw, true);
view(-30, 30); axis off;


%% Aufgabe 1b) Kalibrierung einer Kamera anhand eines Bildes
% Projizierte Eckpunkte des Würfels bestimmen (getPoints.m)

% TODO

% Projektionsmatrix bestimmen (getProjectionMatrix.m)
% Achtung: Im Bild nicht gefundene Eckpunkte werden auf 0 gesetzt und
% sollten nicht zur Kalibrierung verwendet werden.

% TODO

%% Aufgabe 1c) Test (Rückprojektion)
% Test: Projektion der Eckpunkte (X_w) des Kalibrierungsobjekts in das Bild
%  - qualitative Auswertung: Plot der projizierten Eckpunkte
%  - quantitative Auswertung: Bestimmung des mittleren Rückprojektionsfehlers

% TODO


%% Aufgabe 2: Szenenrekonstruktion und Triangulation
% a) Bestimmung der Projektionsmatrix der zweiten Kamera

% TODO

% b) Bestimmung der Kamerazentren (in Matlab: null)

% TODO

% Plot der 3D-Szene: Kalibrierungsobjekt und Kamerazentren

% TODO

% c) Rekonstruktion von 3D-Punkten mittels Triangulation

% TODO

% d) Visualisierung und Berechnung des Rekonstruktionsfehlers

% TODO

