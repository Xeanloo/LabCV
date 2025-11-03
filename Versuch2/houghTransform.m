% Findet Geraden in einem Bild mit Hilfe der Matlab-eigenen Funktionen zur
% Hough-Transformation

%% Bild einlesen und darstellen
I = im2double(imread('./bilder/wire_bond1.tif'));
if size(I, 3) > 1
    I = rgb2gray(I);
end

figure(1); clf; subplot(2, 2, 1);
imshow(I);
title('Bild');

%% Kantenbild erstellen und darstellen
%
%  Befehle: edge, imshow/image/imagesc
figure(1); subplot(2, 2, 3);            % (sub)figure anwählen

% TODO
% I = imgaussfilt(I, 3); % Rauschen reduzieren
bw = edge(I, "sobel", "vertical");
imshow(bw);

title('Kantenbild');

%% Hough-Transformation und Darstellung der Akkumulatormatrix
%
%  Befehle: hough, imagesc
figure(1); subplot(2, 2, [2, 4]);       % (sub)figure anwählen

% TODO
[H, T, R] = hough(bw);
imagesc(T, R, H);
xlabel('\theta (Grad)');
ylabel('\rho (Pixel)');
axis on; axis normal; colormap(gca, hot);


title('Akkumulatormatrix');    
    
%% Maxima der Akkumulatormatrix H bestimmen
%  und in Darstellung plotten
%
%  Befehle: houghpeaks, plot
figure(1); subplot(2, 2, [2, 4]);       % (sub)figure anwählen


    % TODO
% peaks = houghpeaks(H, 5, "Threshold", ceil(0.5 * max(H(:))));
peaks = houghpeaks(H, 4);
hold on;
plot(T(peaks(:, 2)), R(peaks(:, 1)), 'o', 'MarkerSize', 20, 'color', 'white');

hold off;

%% Geraden zu den entsprechenden Maxima in das Bild plotten
%
%  getEndpoints(I, theta, rho) gibt Endpunkte der implizit gegebenen
%  Geraden mit den Parametern theta und rho zurück. Die relevanten
%  Parameter können mit der Rückgabe von houghpeaks aus R und T bestimmt 
%  werden.
%
%  Befehl: plot
figure(1); subplot(2, 2, 1);            % (sub)figure anwählen

hold on;

    % TODO

for k = 1:size(peaks, 1)
    theta = T(peaks(k, 2));
    rho = R(peaks(k, 1));
    linePoints = getEndpoints(I, theta, rho);
    % Swap x and y coordinates for proper display
    plot([linePoints(3), linePoints(4)], [linePoints(1), linePoints(2)], 'LineWidth', 2, 'Color', 'red');
end

title('Bild mit gefundenen Geraden');


hold off;
