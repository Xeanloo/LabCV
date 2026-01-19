clear all;
close all;

%% Beispielgesichter (Trainingsdaten) laden
CPath = './att_faces';
ReconPath = './recon_faces';

subjects = 40;
images = 10;

filename = sprintf('%s/s%i/%i.pgm', CPath, 1, 1);
Img = im2double(imread(filename));
[six, siy] = size(Img);

F = [];
% fülle Datenmatrix
for sub = 1:subjects
%     if sub ~= 8
    for im = 1:images
        filename = sprintf('%s/s%i/%i.pgm', CPath, sub, im);
        if exist(filename, 'file')
            % Speicher Bilder spaltenweise
            F = [F, reshape(im2double(imread(filename)), [], 1)];
        end
    end
%     end
end

%% a) Erstellung des PCA-Raums

% "Meanface" erstellen und darstellen

% TODO
meanFace = mean(F, 2);

% mittelwertfreie Gesichter generieren

% TODO
F_centered = F - meanFace;

% Singulärwertzerlegung der mittelwertfreien Gesichter (svd)
%
% Die svd löst das Eigenwertproblem zu der Matrix F'*F (siehe
% "algebraischer Trick" aus der Vorlesung) und generiert direkt eine
% orthonormale Basis.
% Die Eigenvektoren stehen spaltenweise in U und sind bereits absteigend geordnet.
% Die Singulärwerte stehen auf der Hauptdiagonalen in S. Es gilt EW = SW^2.
% Die Matrix V ist für uns ohne Bedeutung.

% TODO
[U, S, V] = svd(F_centered, 'econ');
%% b) Visualisieren Sie 4 Hauptkomponenten (z.B. 1, 50, 100, 300)
% Verwenden Sie imagesc oder normalisieren Sie die Bilder.

% TODO


%% c) Bildrekonstruktion aus dem Unterraum
filename = sprintf('%s/%i.pgm', ReconPath, 8);
F_original = reshape(im2double(imread(filename)), [], 1);

% Anzahl Eigenfaces
% Testen Sie auch verschiedene Werte!
d = 300;

% ersten d Eigenvektoren (Eigenfaces) auswählen

% TODO
U_d = U(:, 1:d);

% Mittelwert vom Bild abziehen

% TODO
F_centered_single = F_original - meanFace;

% Projektion in den Unterraum

% TODO
coeffs = U_d' * F_centered_single;

% Rekonstruktion aus dem Unterraum

% TODO
F_reconstructed = U_d * coeffs + meanFace;

% Rekonstruktion darstellen

% TODO
figure;
subplot(1,2,1);
imshow(reshape(F_original, six, siy));
title('Originalbild');
subplot(1,2,2);
imshow(reshape(F_reconstructed, six, siy));
title(sprintf('Rekonstruiertes Bild mit d=%d', d));


%% d) Rekonstruktion fehlender Daten
filename = sprintf('%s/%i.pgm', ReconPath, 11);
F_corrupted = reshape(im2double(imread(filename)), [], 1);

% Bereich fehlender Daten bestimmen

% TODO
mask = F_corrupted == 0;

% iterative Rekonstruktion:
% Projektion -> Rekonstruktion -> Bereich mit Daten füllen -> Projektion...

% TODO


%% e) Rekonstruktion ohne exakte Trainingsdaten
%  -> Wiederholen Sie obige Schritte, ohne dass Bilder der zu
%  rekonstruierenden Person in den PCA-Raum integriert werden, d.h. laden
%  Sie Bilder von Person 8 nicht zum Training.

% TODO


%% *Rekonstruktion des eigenen Gesichts
% Mit webcam_simple.mlapp kann ein Bild aufgenommen werden.
% Mit prepareFace kann ein passender Bildausschnitt gewählt werden.
% Erfordert Image Acquisition Toolbox + Support Package for OS Generic Video Interface

% Screenshot der Webcam aufnehmen
webcam_simple; % nutze "Save Screenshot"
pause
face = prepareFace('screenshot.png');
% face = im2double(imread('screenshot.pgm'));
% face = im2double(imread('att_faces/s41/1.pgm'));

% TODO


%% *Rekonstruktion des eigenen Gesichts - Aufnahme zusätzlicher Trainingsamples für bessere Ergebnisse
% Anschließend das Skript mit subjects = 41 ausführen

webcam_simple; % nutze "Save to att_faces"
pause
for im = 1:10
    filename = sprintf('%s/s41/%i.png', CPath, im);
    if exist(filename, 'file') && ~exist(filename(1:end-3) + "pgm", 'file')
        prepareFace(filename);
    end
end
