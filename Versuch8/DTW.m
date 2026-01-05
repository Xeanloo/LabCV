function [p1, p2, C, D] = DTW(v1, v2, weight, maxDisp)
% Dynamic Time Warping
%
% Eingabe: v1, v2  - Zeilenvektoren, enthalten Merkmale
%          weight  - Strafterm für "Verdeckung"
%          maxDisp - maximal zu untersuchende Disparität
% Ausgabe: p1, p2  - Zeilenvektoren, gibt (optimale) Pfade durch die
%                    Vektoren an
%          C - Kostenmatrix
%          D - Distanzmatrix
    
    n1 = size(v1, 2);
    n2 = size(v2, 2);
    
    % Bestimmung Kostenmatrix C
    % -> C(i, j) gibt Unterschied (z.B. SSD) zwischen v1(i) und v2(j) an
    C = zeros(n1, n2);
    
    
        % TODO
    
    
    % Bestimmung Distanzmatrix D und "Pfadmatrix" M:
    % - D enthält die minimale Kosten bis zu jedem Punkt D(i, j)
    % - M kodiert die Richtung, in der das vorherige Minimum liegt
    %   z.B.: M(i,j) = 1 -> Minimum links oben:        C(i,j) + D(i-1,j-1) ist minimal
    %         M(i,j) = 2 -> Minimum oben:       weight*C(i,j) + D(i-1,j)   ist minimal
    %         M(i,j) = 3 -> Minimum links:      weight*C(i,j) + D(i,  j-1) ist minimal
    D = inf * ones(n1, n2);
    M = zeros(n1, n2);
    
    
        % TODO
    
    
    % Backtracking mit Hilfe von M
    % -> Finden des optimalen Pfades von C(1, 1) nach C(n1, n2) über M
    %
    % - Start bei i = n1 und j = n2
    % - Ende bei i = 1 und j = 1
    % - p1 enthält die Werte von i (gewarpte Indizes aus v1)
    % - p2 enthält die Werte von j (gewarpte Indizes aus v2)
    
    
        % TODO
    
    
    % gegebenenfalls die Pfade umdrehen, damit Start bei 1
    
    
        % TODO
    
    
end
