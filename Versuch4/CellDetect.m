clear all;
close all;
clc;

%% Bestimme ("ideale") Zellmaske

% Beispielbilder laden und als (dreidimensionale) Matrix abspeichern
dir = './Good/';
n_img = 150;

pos_images = [];
for im = 1:n_img
    filename = cat(2, dir, 'Good', num2str(im), '.bmp');
    if exist(filename, 'file')
        pos_images = cat(3, pos_images, im2double(imread(filename)));
    end
end


% Bestimmung einer "durchschnittlichen" Zelle aus den Beispielbildern
% Hinweis: imadjust kann den Kontrast in diesem Bild verbessern


    % TODO
avg_cell = mean(pos_images, 3);
avg_cell = imadjust(avg_cell);
figure(1);
subplot(1, 3, 1);
imshow(avg_cell);
colormap(gca, "gray");
%disp(size(avg_cell));
% return


% Histogramm bestimmen
% Befehl: imhist
figure(1);
subplot(1, 3, 2);
imhist(avg_cell);
[counts, binLocations] = imhist(avg_cell);


    % TODO


% Schwellwerte aus Histogramm bestimmen (manuell oder automatisch) und
% Zellen-Labelbild aus der Durchschnittszelle definieren, z.B.
% Wert  1 - Zellkern (helle Bereiche)
% Wert -1 - Zellwand (dunkle Bereiche)
% Wert  0 - übrige Bereiche

figure(1);
subplot(1, 3, 3);
white_threshold = 0.6;
black_threshold = 0.4;
avg_cell(avg_cell > white_threshold) = 1;
avg_cell(avg_cell < black_threshold) = -1;
avg_cell(avg_cell >= black_threshold & avg_cell <= white_threshold) = 0;
imagesc(avg_cell); axis image off;

cmap = [0 1 0;
        0 0 1;
        1 0 0];
colormap(gca, cmap);
clim([-1 1]); 
    % TODO


%% Bestimmung der Verteilungsfunktionen
%  Als Merkmal wird die Differenz des mittleren Grauwerts von Zellkern und
%  Zellwand verwendet. Es wird die Annahme getroffen dieses Merkmal ist
%  normalverteilt.

% Merkmal für die positiven Beispiele bestimmen, d.h. in jedem Beispielbild
% wird der Mittelwert im Bereich des Zellkerns und der Zellwand bestimmt
% und abschließend voneinander abgezogen.
% Die entsprechenden Bereiche sind durch die definierte Zellmaske gegeben.

pos_mask_cell_wall = (avg_cell == -1);
pos_mask_cell_core = (avg_cell == 1);
pos_diff_array = zeros(1, size(pos_images, 3));
for it = 1:size(pos_images, 3)
    im = pos_images(:, :, it);
    % TODO
    % cell_wall_avg = mean(im .* pos_mask_cell_wall);
    % cell_wall_avg = mean(cell_wall_avg);
    % cell_core_avg = mean(im .* pos_mask_cell_core);
    % cell_core_avg = mean(cell_core_avg);
    % diff = cell_core_avg - cell_wall_avg;
    %
    % Mittelwerte NUR über die maskierten Pixel:
    cell_wall_vals = im(pos_mask_cell_wall);
    cell_core_vals = im(pos_mask_cell_core);

    m_wall = mean(cell_wall_vals);
    m_core = mean(cell_core_vals);

    % Differenz: Kern minus Wand (für echte Zellen positiv)
    diff_val = m_core - m_wall;
    pos_diff_array(it) = diff_val;
    
end

% Bestimme Mittelwert und Varianz der postiven Beispiele


    % TODO
mu_pos = mean(pos_diff_array);
var_pos = var(pos_diff_array);
std_pos = sqrt(var_pos);

% Merkmal für die negativen Beispiele bestimmen.
dir = './Bad/';
n_img = 460;

neg_images = [];
for im = 1:n_img
    filename = cat(2, dir, 'Bad', num2str(im), '.bmp');
    if exist(filename, 'file')
        neg_images = cat(3, neg_images, im2double(imread(filename)));
    end
end




neg_diff_array = zeros(1, size(neg_images, 3));
for it = 1:size(neg_images, 3)
    im = neg_images(:, :, it);

    % TODO
    % cell_wall_avg = mean(im .* pos_mask_cell_wall);
    % cell_wall_avg = mean(cell_wall_avg);
    % cell_core_avg = mean(im .* pos_mask_cell_core);
    % cell_core_avg = mean(cell_core_avg);
    
    % diff = cell_core_avg - cell_wall_avg;
    % Gleiche Maske verwenden (Kern/Wand an derselben Stelle)
    cell_wall_vals = im(pos_mask_cell_wall);
    cell_core_vals = im(pos_mask_cell_core);

    m_wall = mean(cell_wall_vals);
    m_core = mean(cell_core_vals);

    diff_val = m_core - m_wall;
    neg_diff_array(it) = diff_val;
    
end

% Bestimme Mittelwert und Varianz der negativen Beispiele


%% Schwellwert für die Klassifikation bestimmen

% Verteilungen (positive und negative Beispiele) plotten

% Mittelwert und Varianz der negativen Beispiele
mu_neg  = mean(neg_diff_array);
var_neg = var(neg_diff_array);
std_neg = sqrt(var_neg);

fprintf('Positive: mu = %.4f, sigma = %.4f\n', mu_pos, std_pos);
fprintf('Negative: mu = %.4f, sigma = %.4f\n', mu_neg, std_neg);

%% Schwellwert für die Klassifikation bestimmen

% Verteilungen (positive und negative Beispiele) plotten

% Mittelwert und Varianz der negativen Beispiele
mu_neg  = mean(neg_diff_array);
var_neg = var(neg_diff_array);
std_neg = sqrt(var_neg);

fprintf('Positive: mu = %.4f, sigma = %.4f\n', mu_pos, std_pos);
fprintf('Negative: mu = %.4f, sigma = %.4f\n', mu_neg, std_neg);

%% Schwellwert für die Klassifikation bestimmen (Bayes)

% Wir nehmen gleiche Priors P(pos)=P(neg)=0.5 an.
P_pos = 0.5;
P_neg = 0.5;

% Verteilungen plotten
diff_min = min([pos_diff_array(:); neg_diff_array(:)]);
diff_max = max([pos_diff_array(:); neg_diff_array(:)]);
x_vals = linspace(diff_min - 0.5, diff_max + 0.5, 1000);

pdf_pos = normpdf(x_vals, mu_pos, std_pos);
pdf_neg = normpdf(x_vals, mu_neg, std_neg);

figure;
plot(x_vals, pdf_pos, 'b', 'LineWidth', 2); hold on;
plot(x_vals, pdf_neg, 'r', 'LineWidth', 2);
xlabel('Merkmalswert (m_{Kern} - m_{Wand})');
ylabel('Dichte');
legend('Positiv (Zelle)', 'Negativ (kein Zelle)');
title('Verteilungen des Merkmals');

%return
% Schwellwert bestimmen, der eine (optimale) Trennung zwischen Zelle und
% Hintergrund auf der Basis des Merkmals angibt und im Plot markieren

% Finde Schnittpunkte der Dichten
A = 1/(2*std_neg^2) - 1/(2*std_pos^2);
B = mu_pos/(std_pos^2) - mu_neg/(std_neg^2);
C = mu_neg^2/(2*std_neg^2) - mu_pos^2/(2*std_pos^2) + log((std_neg * P_pos) / (std_pos * P_neg));
thresholds = roots([A, B, C]);
% Wähle den Schnittpunkt, der zwischen den Mittelwerten liegt
valid_thresholds = thresholds(thresholds > min(mu_pos, mu_neg) & thresholds < max(mu_pos, mu_neg));
if ~isempty(valid_thresholds)
    threshold = valid_thresholds(1);
    disp(['Gefundener Schwellwert: ', num2str(threshold)]);
    % Markiere den Schwellwert im Plot in grün  

    y_limits = ylim;
    plot([threshold, threshold], y_limits, 'g--', 'LineWidth', 2);
    text(threshold + 0.01, y_limits(2) * 0.9, sprintf('Schwellwert = %.4f', threshold), 'Color', 'g');
    hold off;
else
    error('Kein gültiger Schwellwert gefunden.');
end
    % TODO
%% Bild(ausschnitte) klassifizieren und gefundene Zellen markieren

% Testbild laden
img = im2double(rgb2gray(imread('CellDetectPostFreeze.jpg')));

% Bild mit einem "Sliding Window" absuchen und Zellen über die Differenz des
% mittleren Grauwerts der maskierten Zellbestandteile und den Schwellwert detektieren.
% Zur Beschleunigung ist es ausreichend, das Fenster in 5er-Schritten weiterzuschieben.

    
    % TODO
    [height, width] = size(img);
    % 5-steps sliding window
    cell_positions = [];
    step_size = 5;
    [mask_height, mask_width] = size(avg_cell);
    for row = 1:step_size:(height - mask_height + 1)
        for col = 1:step_size:(width - mask_width + 1)
            window = img(row:(row + mask_height - 1), col:(col + mask_width - 1));
            % Calculate mean values for cell core and wall
            cell_wall_vals = window(pos_mask_cell_wall);
            cell_core_vals = window(pos_mask_cell_core);

            m_wall = mean(cell_wall_vals);
            m_core = mean(cell_core_vals);

            diff_val = m_core - m_wall;

            if diff_val > threshold
                cell_positions = [cell_positions; row, col];
            end
        end
    end

% Bild und gefundene Zellen darstellen

    
    % TODO
    
    figure;
    imshow(img); hold on;
    for i = 1:size(cell_positions, 1)
        plot(cell_positions(i, 2) + mask_width/2, cell_positions(i, 1) + mask_height/2, 'r+', 'MarkerSize', 2, 'LineWidth', 1);
    end
    hold off;
    title('Gefundene Zellen (rote Kreuze)');

