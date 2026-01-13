close all
%% Verwendung gegebener Stereobilder
load('focusedStereoSetup.mat');

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
error1 = sqrt(sum((points1(:,1:2) - projPoints1).^2, 2));
meanError1 = mean(error1(points1(:,1)>0));
title(sprintf('MSE: %.2f', meanError1));
figure(2); clf;
imshow(img2); hold on;
plot(projPoints2(:,1), projPoints2(:,2), 'go', 'MarkerSize', 10);
plot(points2(:,1), points2(:,2), 'r*', 'MarkerSize', 10);
error2 = sqrt(sum((points2(:,1:2) - projPoints2).^2, 2));
meanError2 = mean(error2(points2(:,1)>0));
title(sprintf('MSE: %.2f', meanError2));

%% Aufgabe 2: Szenenrekonstruktion und Triangulation
% a) Bestimmung der Projektionsmatrix der zweiten Kamera

% TODO
load('parallelStereoSetup.mat');
% stereoPoints2 = getPoints(img2);
stereoPoints2 = [
  174.7694,  255.9839;...
  294.0863,  269.6461;...
  157.4639,  165.8131;...
  269.4943,  186.7619;...
  132.8719,  338.8681;...
  249.4564,  347.9763;...
  121.0313,  251.4298;...
         0,         0;...
]
stereoPoints1 = [  345.0920,  248.6973;...
                  448.9250 , 262.3596;...
                  308.6594 , 160.3482;...
                  406.1167 , 178.5645;...
                  284.9782 , 330.6708;...
                  390.6328 , 341.6006;...
                  260.3861 , 244.1433;...
                        0  ,       0;...
];
validStereo2 = stereoPoints2(:,1) > 0;
validStereo1 = stereoPoints1(:,1) > 0;
projectionMatrixStereo2 = getProjectionMatrix(Xw(validStereo2, :), stereoPoints2(validStereo2, :));
projectionMatrixStereo1 = getProjectionMatrix(Xw(validStereo1, :), stereoPoints1(validStereo1, :));
% b) Bestimmung der Kamerazentren (in Matlab: null)

% TODO

cameraCenterStereo2 = null(projectionMatrixStereo2);
cameraCenterStereo2 = cameraCenterStereo2(1:3) ./ cameraCenterStereo2(4);
cameraCenterStereo1 = null(projectionMatrixStereo1);
cameraCenterStereo1 = cameraCenterStereo1(1:3) ./ cameraCenterStereo1(4);

cameraCenter1 = null(projectionMatrix1);
cameraCenter1 = cameraCenter1(1:3) ./ cameraCenter1(4);
cameraCenter2 = null(projectionMatrix2);
cameraCenter2 = cameraCenter2(1:3) ./ cameraCenter2(4);

% Plot der 3D-Szene: Kalibrierungsobjekt und Kamerazentren

% TODO
figure(3); clf;
hold on;
plotCube(Xw, false);
plot3(cameraCenterStereo1(1), cameraCenterStereo1(2), cameraCenterStereo1(3), 'bo', 'MarkerSize', 15, 'MarkerFaceColor', 'b');
plot3(cameraCenterStereo2(1), cameraCenterStereo2(2), cameraCenterStereo2(3), 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
plot3(cameraCenter1(1), cameraCenter1(2), cameraCenter1(3), 'ko', 'MarkerSize', 15, 'MarkerFaceColor', 'k');
plot3(cameraCenter2(1), cameraCenter2(2), cameraCenter2(3), 'go', 'MarkerSize', 15, 'MarkerFaceColor', 'g');
legend('Kalibrierungsobjekt', 'Kamerazentrum Stereo 1', 'Kamerazentrum Stereo 2', 'Kamerazentrum 1', 'Kamerazentrum 2');
view(-30, 30); axis on;

figure(4); clf;
subplot(1,2,1);
imshow(img1); hold on;
subplot(1,2,2);
imshow(img2); hold on;

% c) Rekonstruktion von 3D-Punkten mittels Triangulation

% TODO
reconstructedPoints = myTriangulation(stereoPoints1(validStereo1, :), stereoPoints2(validStereo2, :), projectionMatrixStereo1, projectionMatrixStereo2);

% d) Visualisierung und Berechnung des Rekonstruktionsfehlers

% TODO
figure(5); clf;
view(-30, 30); axis on;
for i = 1:size(reconstructedPoints, 1)
    plot3(reconstructedPoints(i, 1), reconstructedPoints(i, 2), reconstructedPoints(i, 3), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    hold on;
end

meanReconstructionError = mean(sqrt(sum((Xw(validStereo1, :) - reconstructedPoints).^2, 2)));
title(sprintf('MSE: %.2f', meanReconstructionError));