function SC = scCompute(P, X, nBinsTheta, nBinsR, rMin, rMax)
    
    n = size(P, 1);      % Anzahl Punkte in P (Aufgabe 1: n = 1)
    m = size(X, 1);      % Anzahl Punkte in X
    
    % Bestimme Abstände der Punkte X zu den Punkten P.
    
    
        % TODO
    
    
    % Ordne die Punkte in X den verschiedenen Bins zu, d.h. abhängig von
    % dem Abstand zu den Punkten in P werden die Punkte zusammengefasst
    % und in die Bins 1 bis nBinsR eingeteilt.
    
    % a) Bestimme die Grenzen zwischen den Bins.
    %    in Matlab: logspace
    
    
        % TODO
    
    
    % b) Weise Punkte in X den entsprechenden Bins zu, d.h. rLabel(i, j)
    %    gibt an, in welchem Bin der Punkt X(i, :) in Bezug auf P(j, :)
    %    liegt.
    rLabel = zeros(m, n);
    
    
        % TODO
    
    
    % Bestimme Richtung der Punkte in X relativ zu den Punkten P, d.h. den 
    % Winkel zwischen X(i, :) - P(j, :) und der x-Achse.
    % in Matlab: atan2
    
    
        % TODO
    
    
    % Ordne die Punkte in X den Bins zu
    % a) Bestimme Grenzen zwischen den Bins
    %    in Matlab: linspace
    
    
        % TODO
    
    
    % b) Weise Punkte in X den entsprechenden Bins zu
    thetaLabel = zeros(m, n);
    
    
        % TODO
    
    
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




