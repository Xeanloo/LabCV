function [mOut, nOut, rOut] = houghCircle(E, nc, minR, maxR)
% Findet nc Kreise in einem Kantenbild E mit Radius zwischen minR und maxR
% mit Hilfe der Hough-Transformation für Kreise.
%
% Eingabe: E - Kantenbild
%          nc - maximale Anzahl an Kreisen
%          minR, maxR - minimaler/maximaler Radius der gesuchten Kreise
% Ausgabe: [mOut, nOut, rOut] - Parameter der gefundenen Kreise 
%                               (Mittelpunkt, Radius)

    % Initialisierung
    mOut = zeros(1, nc);
    nOut = zeros(1, nc);
    rOut = zeros(1, nc);
      
    % Bestimmung aller Kantenpixel im Kantenbild
    %edgeY
    % Befehl: find

    
        % TODO
    [edgeX, edgeY] = find(E); 
    
    
    % Initialisierung der dreidimensionalen (m, n, r) Akkumulatormatrix A 
    % mit geeigneter Quantisierung der Parameter
    %
    % Befehl: zeros
    
        
        % TODO    
    A = zeros(size(E, 1), size(E, 2), maxR - minR + 1);
    
    A_update = getAccumulatorUpdate(minR, maxR);    
    
    % Kantenpixel durchlaufen und Akkumulatormatrix erhöhen, d.h.
    % Update-Maske an entsprechender Position addieren.
    %
    % Matlab kann nur Matrizen gleicher Größe addieren, Sie müssen daher
    % den entsprechenden Bereich aus der Akkumulatormatrix auswählen.
    %
    % Achten Sie auch auf eine geeignete Randbehandlung.
    
    
    for i = 1:length(edgeX)
        x = edgeX(i);  
        y = edgeY(i); 
        
        if x - maxR < 1 || x + maxR > size(E, 2) || y - maxR < 1 || y + maxR > size(E, 1)
            continue;
        end
        
        region = A(y - maxR : y + maxR, x - maxR : x + maxR, :);
        region = region + A_update;
        A(y - maxR : y + maxR, x - maxR : x + maxR, :) = region;
    end
    
    % finde die nc größten Punkte in der Akkumulatormatrix
    % ensprechende Parameter werden in die Vektoren m, n, r geschrieben
    for it = 1:nc
        thr = round((maxR + minR)/2);
        thr = round((maxR + minR)/4);
        [~, ind] = max(A(:));
        [mOut(it), nOut(it), rOut(it)] = ind2sub(size(A), ind);
        % A(mOut(it), nOut(it), rOut(it)) = 0;
        A(mOut(it)-thr:mOut(it)+thr, nOut(it)-thr:nOut(it)+thr, rOut(it)-thr:rOut(it)+thr) = 0;
        % A(max(mOut(it)-thr, 1):min(mOut(it)+thr, size(A, 1)), max(nOut(it)-thr, 1):min(nOut(it)+thr, size(A, 2)), max(rOut(it)-thr, 1):min(rOut(it)+thr, size(A, 3))) = 0;
    end
end
