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
    
    
    % 2. In der Maske für jeden Radius r die Punkte auf 1 setzen, deren
    %    Abstand zum Bildmittelpunkt (gerundet) r entspricht.
    %
    %    mögliche Lösung: (m, n)-Werte der Maske durchlaufen und Abstand zum 
    %    Mittelpunkt (Radius r) bestimmen und das Tripel (m, n, r) in der 
    %    Maske auf 1 setzen, wenn r im relevanten Bereich ist.
    
    
        % TODO
        
        
end
