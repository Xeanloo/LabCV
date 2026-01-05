function [p1, p2, C, D] = DTW(v1, v2, weight, maxDisp, windowSize)
% Dynamic Time Warping
%
% Eingabe: v1, v2  - Zeilenvektoren, enthalten Merkmale
%          weight  - Strafterm für "Verdeckung"
%          maxDisp - maximal zu untersuchende Disparität
% Ausgabe: p1, p2  - Zeilenvektoren, gibt (optimale) Pfade durch die
%                    Vektoren an
%          C - Kostenmatrix
%          D - Distanzmatrix

    if nargin < 5
        windowSize = 1;
    end

    n1 = size(v1, 2);
    n2 = size(v2, 2);
    
    % Bestimmung Kostenmatrix C
    % -> C(i, j) gibt Unterschied (z.B. SSD) zwischen v1(i) und v2(j) an
    % C = zeros(n1, n2);
    
    if windowSize > 1
        % Mehrdimensionale Merkmale
        dims = size(v1, 1);
        C = zeros(n1, n2);
        for d = 1:dims
            [x_d, y_d] = meshgrid(v2(d, :), v1(d, :));
            C = C + (x_d - y_d).^2;
        end
    else
        % Eindimensionale Merkmale
    [x, y] = meshgrid(v2, v1);
        C = (x - y).^2;
    end
    
    
    % Bestimmung Distanzmatrix D und "Pfadmatrix" M:
    % - D enthält die minimale Kosten bis zu jedem Punkt D(i, j)
    % - M kodiert die Richtung, in der das vorherige Minimum liegt
    %   z.B.: M(i,j) = 1 -> Minimum links oben:        C(i,j) + D(i-1,j-1) ist minimal
    %         M(i,j) = 2 -> Minimum oben:       weight*C(i,j) + D(i-1,j)   ist minimal
    %         M(i,j) = 3 -> Minimum links:      weight*C(i,j) + D(i,  j-1) ist minimal
    D = inf * ones(n1, n2);
    M = zeros(n1, n2);

    D(1, 1) = C(1, 1);
    M(1, 1) = 1;

    for i = 2:maxDisp+1
        D(i, 1) = D(i-1, 1) + weight * C(i, 1);
        M(i, 1) = 2;
    end

    for j = 2:maxDisp+1
        D(1, j) = D(1, j-1) + weight * C(1, j);
        M(1, j) = 3;
    end

    for i = 2:n1
        for j = max(2, i - maxDisp):min(n2, i + maxDisp)
            if abs(i - j) <= maxDisp
                % TODO: Implement the rest of the DTW algorithm here
                costs = [D(i-1, j-1), D(i-1, j), D(i, j-1)];
                penalties = [1, weight, weight];
                totalCosts = costs + penalties * C(i, j);
                [D(i, j), M(i, j)] = min(totalCosts);
            end
        end
    end

    % Backtracking mit Hilfe von M
    % -> Finden des optimalen Pfades von C(1, 1) nach C(n1, n2) über M
    %
    % - Start bei i = n1 und j = n2
    % - Ende bei i = 1 und j = 1
    % - p1 enthält die Werte von i (gewarpte Indizes aus v1)
    % - p2 enthält die Werte von j (gewarpte Indizes aus v2)
    
    
        % TODO
    i = n1;
    j = n2;
    p1 = [];
    p2 = [];
    while i > 1 || j > 1
        p1 = [i, p1];
        p2 = [j, p2];
        if M(i, j) == 1
            i = i - 1;
            j = j - 1;
        elseif M(i, j) == 2
            i = i - 1;
        elseif M(i, j) == 3
            j = j - 1;
        end
    end
    p1 = [1, p1];
    p2 = [1, p2];

end
