% Lade MNIST Daten
data = load('ShapeContextData.mat');

% Wähle ein Bild (z.B. das erste Trainingsbeispiel)
img = data.train_data(:, :, 5);

% Bestimme Randpunkte
nPoints = 100;
X = getEdgePoints(img, nPoints);

% Definiere Referenzpunkt P (Mittelpunkt)
P = [0.5, 0.5];

% Parameter für Shape Context
nBinsTheta = 12;  
nBinsR = 5;       
rMin = 0.1;       
rMax = 1.0;       

% Berechne Shape Context Deskriptor
SC = scCompute(P, X, nBinsTheta, nBinsR, rMin, rMax);

% Visualisierung
figure();

subplot(1, 3, 1);
imshow(img, []);
colormap(gca, gray);

subplot(1, 3, 2);
plot(X(:, 1), X(:, 2), 'b.', 'MarkerSize', 10);
hold on;
plot(P(1), P(2), 'r*', 'MarkerSize', 15, 'LineWidth', 2);
hold off;
axis equal;
axis([0 1 0 1]);
grid on;
xlabel('x');
ylabel('y');
legend('Edge Points', 'Reference P', 'Location', 'best');

%subplot 3: Shape Context Histogram,  compare theta and r 
subplot(1, 3, 3);
imagesc(squeeze(SC));
colorbar;
colormap(gray);
title('Shape Context Histogram');
xlabel('#theta bin');
ylabel('#r bin');
set(gca, 'XTick', 1:nBinsTheta);
set(gca, 'YTick', 1:nBinsR);
axis xy;