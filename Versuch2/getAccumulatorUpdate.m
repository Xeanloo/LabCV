function AUpdate = getAccumulatorUpdate(minR, maxR) 

    % Bestimmung einer Maske zur Erhöhung der Akkumulatormatrix:
    % Für jeden Kantenpixel müssen die Zellen der Matrix erhöht werden, die
    % den Kantenpixel generiert haben können. Zur Beschleunigung des
    % Verfahrens kann dies als Maske vorab initialisiert werden.
    
    % 1. Initialisierung der dreidimensionalen Maske (AUpdate) in
    %    geeigneter Größe
    %    1./2. Dimension: Mittelpunkt (m, n) der Kreise
    %    3.    Dimension: Radius (r) des Kreises
    %
    %    Befehl: zeros
   
    
    	% TODO
    M = 2*maxR+1;
    N = 2*maxR+1;
    R = maxR - minR + 1;               
    AUpdate = zeros(M, N, R);
    
    
    % 2. In der Maske für jeden Radius r die Punkte auf 1 setzen, deren
    %    Abstand zum Bildmittelpunkt (gerundet) r entspricht.
    %
    %    mögliche Lösung: (m, n)-Werte der Maske durchlaufen und Abstand zum 
    %    Mittelpunkt (Radius r) bestimmen und das Tripel (m, n, r) in der 
    %    Maske auf 1 setzen, wenn r im relevanten Bereich ist.
    
    
    % TODO
    center = [maxR + 1, maxR + 1]; 
    for m = 1:M
        for n = 1:N
            dist = round(sqrt((m - center(1))^2 + (n - center(2))^2));
            if dist >= minR && dist <= maxR
                rIndex = dist - minR + 1; 
                AUpdate(m, n, rIndex) = 1;
            end
        end
    end
end