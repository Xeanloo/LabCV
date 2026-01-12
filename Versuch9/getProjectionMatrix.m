function P = getProjectionMatrix(Xw, Ximg)
% Bestimme Projektionsmatrix aus den Korrespondenzen Xw(i, :) <-> Ximg(i, :)
%
% Eingabe: Xw    - nx3-Array, enthält 3D-Punkte
%          Ximg  - nx2-Array, enthält 2D-Punkte
% Ausgabe: P - Projektionsmatrix, 3x4-Matrix
    
    % TODO
    n = size(Xw, 1);
    A = zeros(2*n, 12);    
    for i = 1:n
        X = Xw(i, 1);
        Y = Xw(i, 2);
        Z = Xw(i, 3);
        x = Ximg(i, 1);
        y = Ximg(i, 2);
        
        A(2*i-1, :) = [0,0,0,0, -X, -Y, -Z, -1, y*X, y*Y, y*Z, y];
        A(2*i, :)   = [X, Y, Z, 1, 0, 0, 0, 0, -x*X, -x*Y, -x*Z, -x];
    end
    [~, ~, V] = svd(A);
    p = V(:, end);
    P = reshape(p, 4, 3)';

end
