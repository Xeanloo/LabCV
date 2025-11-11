function test_region_growing
    clc; close all;

    % --- 1) Bild wählen & laden ---
    [fn, fp] = uigetfile({'*.png;*.jpg;*.jpeg;*.tif;*.bmp','Bilder'}, ...
                         'Bild auswählen');
    if isequal(fn,0); disp('Abbruch: kein Bild gewählt.'); return; end
    I = imread(fullfile(fp, fn));
    if ndims(I) == 3, Igray = rgb2gray(I); else, Igray = I; end
    

    keepGoing = true;
    while keepGoing
        % --- 2) Startpunkt wählen ---
        hFig = figure('Name','Region Growing – Startpunkt wählen');
        imshow(Igray,[]); title('Klicken Sie den Startpunkt (Seed).  [Enter] zum Bestätigen');
        axis image; hold on;
        [xC, yC] = ginput(1);  % eine Koordinate (x = Spalte, y = Zeile)
        if isempty(xC)
            close(hFig);
            disp('Abbruch: kein Seed gewählt.'); return;
        end
        xStart = round(yC);
        yStart = round(xC);
        plot(yStart, xStart, 'gx', 'LineWidth', 2, 'MarkerSize', 12);
        drawnow;

        % --- 3) Schwellwert abfragen ---
        defTau = '10';
        answer = inputdlg({'Schwellwert \tau (>=0):'}, 'Parameter', 1, {defTau});
        if isempty(answer)
            close(hFig);
            disp('Abbruch: kein Schwellwert eingetragen.'); return;
        end
        tau = str2double(answer{1});
        if isnan(tau) || tau < 0
            close(hFig);
            error('Ungültiger Schwellwert.');
        end

        % --- 4) Region Growing ausführen ---
        S = regionGrowing(Igray, xStart, yStart, tau);

        % --- 5) Ergebnisse darstellen ---
        close(hFig);
        figure('Name','Ergebnisdarstellung');
        subplot(1,3,1);
        imshow(Igray,[]); title('Original'); axis image;

        subplot(1,3,2);
        imshow(S); title('Segmentierung (Maske)'); axis image;

        subplot(1,3,3);
        imshow(Igray,[]); axis image; hold on;
        % Kontur der Segmentierung als Kurve überlagern:
        contour(S, [0.5 0.5], 'r', 'LineWidth', 1.8);
        plot(yStart, xStart, 'gx', 'LineWidth', 2, 'MarkerSize', 12);
        title(sprintf('Overlay (Seed grün, Kontur rot) – \\tau = %.3g', tau));

        % --- 6) Optional: weitere Segmentierung starten ---
        choice = questdlg('Weitere Segmentierung mit neuem Seed/τ?', ...
                          'Weitere Messung', 'Ja','Nein','Ja');
        keepGoing = strcmp(choice,'Ja');
    end
end