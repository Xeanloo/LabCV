function SC = scCompute(P, X, nBinsTheta, nBinsR, rMin, rMax)
    
    n = size(P, 1);      % Anzahl Punkte in P (Aufgabe 1: n = 1)
    m = size(X, 1);      % Anzahl Punkte in X
    
    % Bestimme Abstände der Punkte X zu den Punkten P.
    
    
        % TODO
        distances = zeros(m, n);
        for i = 1:m
            for j = 1:n
                distances(i, j) = norm(X(i, :) - P(j, :));
            end
        end
    
    % Ordne die Punkte in X den verschiedenen Bins zu, d.h. abhängig von
    % dem Abstand zu den Punkten in P werden die Punkte zusammengefasst
    % und in die Bins 1 bis nBinsR eingeteilt.
    
    % a) Bestimme die Grenzen zwischen den Bins.
    %    in Matlab: logspace
    
    
        % TODO
        rEdges = logspace(log10(rMin), log10(rMax), nBinsR + 1);

    
    % b) Weise Punkte in X den entsprechenden Bins zu, d.h. rLabel(i, j)
    %    gibt an, in welchem Bin der Punkt X(i, :) in Bezug auf P(j, :)
    %    liegt.
    rLabel = zeros(m, n);
    
    
        % TODO
        for i = 1:m
            for j = 1:n
                % Ignore points outside [rMin, rMax]
                if distances(i, j) < rMin || distances(i, j) > rMax
                    rLabel(i, j) = 0;
                else
                    for k = 1:nBinsR
                        if distances(i, j) >= rEdges(k) && distances(i, j) < rEdges(k + 1)
                            rLabel(i, j) = k;
                            break;
                        end
                    end
                    if distances(i, j) == rMax
                        rLabel(i, j) = nBinsR;
                    end
                end
            end
        end
    
    % Bestimme Richtung der Punkte in X relativ zu den Punkten P, d.h. den 
    % Winkel zwischen X(i, :) - P(j, :) und der x-Achse.
    % in Matlab: atan2
    
    
        % TODO
        angles = zeros(m, n);
        for i = 1:m
            for j = 1:n
                delta = X(i, :) - P(j, :);
                angles(i, j) = atan2(delta(2), delta(1));
            end
        end
    
    
    % Ordne die Punkte in X den Bins zu
    % a) Bestimme Grenzen zwischen den Bins
    %    in Matlab: linspace
    
    
        % TODO
        thetaEdges = linspace(-pi, pi, nBinsTheta + 1);
    
    
    % b) Weise Punkte in X den entsprechenden Bins zu
    thetaLabel = zeros(m, n);
    
    
        % TODO
        for i = 1:m
            for j = 1:n
                for k = 1:nBinsTheta
                    if angles(i, j) >= thetaEdges(k) && angles(i, j) < thetaEdges(k + 1)
                        thetaLabel(i, j) = k;
                        break;
                    end
                end
                % Randfall: Winkel genau bei pi wird zu -pi zugeordnet
                if angles(i, j) == pi
                    thetaLabel(i, j) = 1;  % Erster Bin bei -pi
                end
            end
        end
    
    % Histogramm bestimmen, Bins auszählen
    SC = zeros(nBinsR, nBinsTheta, n);
    for it_r = 1:nBinsR
        for it_theta = 1:nBinsTheta
            SC(it_r, it_theta, :) = reshape(sum((thetaLabel == it_theta).*(rLabel == it_r), 1), 1, 1, n);
        end
    end
    % Histogramm normalisieren -> Wahrscheinlichkeiten
    SC = SC ./ (repmat(sum(sum(SC, 1), 2), [size(SC, 1), size(SC, 2), 1]) + eps);
end




