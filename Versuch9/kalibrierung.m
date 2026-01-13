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
points1 = [255.8321, 362.5493; ...
           303.1945, 337.9573; ...
           305.9269, 237.7676; ...
           346.9137, 228.6594; ...
           141.9801, 301.5247; ...
           0, 0; ...
           188.4317, 180.3861; ...
           242.1698, 174.9213];

points2 = [
      223.9535,  369.8359; ...
      340.5380,  347.0655; ...
      233.0617,  237.7676; ...
      354.2002,  221.3729; ...
      170.2154,  311.5436; ...
             0,         0; ...
      173.8586,  192.2268; ...
      288.6214,  179.4753; ...
]
% points1 = getPoints(img2);

% points2 = getPoints(img2);

% Projektionsmatrix bestimmen (getProjectionMatrix.m)
% Achtung: Im Bild nicht gefundene Eckpunkte werden auf 0 gesetzt und
% sollten nicht zur Kalibrierung verwendet werden.

% TODO

valid1 = points1(:,1) > 0;
valid2 = points2(:,1) > 0;

projectionMatrix1 = getProjectionMatrix(Xw(valid1, :), points1(valid1, :));
projectionMatrix2 = getProjectionMatrix(Xw(valid2, :), points2(valid2, :));

%% Aufgabe 1c) Test (Rückprojektion)
% Test: Projektion der Eckpunkte (X_w) des Kalibrierungsobjekts in das Bild
%  - qualitative Auswertung: Plot der projizierten Eckpunkte
%  - quantitative Auswertung: Bestimmung des mittleren Rückprojektionsfehlers

% TODO
projPoints1_hom = (projectionMatrix1 * [Xw, ones(size(Xw, 1), 1)]')';
projPoints1 = projPoints1_hom(:, 1:2) ./ projPoints1_hom(:, 3);
projPoints2_hom = (projectionMatrix2 * [Xw, ones(size(Xw, 1), 1)]')';
projPoints2 = projPoints2_hom(:, 1:2) ./ projPoints2_hom(:, 3);

figure(1); clf;
imshow(img1); hold on;
% draw the projected points
plot(projPoints1(:,1), projPoints1(:,2), 'go', 'MarkerSize', 10);
plot(points1(:,1), points1(:,2), 'r*', 'MarkerSize', 10);
title('Projektion der Kalibrierungspunkte in Bild 1');
figure(2); clf;
imshow(img2); hold on;
plot(projPoints2(:,1), projPoints2(:,2), 'go', 'MarkerSize', 10);
plot(points2(:,1), points2(:,2), 'r*', 'MarkerSize', 10);
title('Projektion der Kalibrierungspunkte in Bild 2');
error1 = sqrt(sum((points1(:,1:2) - projPoints1).^2, 2));
meanError1 = mean(error1(points1(:,1)>0));
error2 = sqrt(sum((points2(:,1:2) - projPoints2).^2, 2));
meanError2 = mean(error2(points2(:,1)>0));
fprintf('Mittlerer Rückprojektionsfehler Bild 1: %.2f Pixel\n', meanError1);
hold off;
fprintf('Mittlerer Rückprojektionsfehler Bild 2: %.2f Pixel\n', meanError2);       
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

