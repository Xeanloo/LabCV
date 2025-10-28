function I_gauss = gaussFilter(I, sigma)
% Filtert das Bild I mit einem (zweidimensionalen) Gauss-Filter mit
% Standardabweichung sigma.
    
    % Konvertierung des Bildes
    I = double(I);
    % I = I / 255; 

    [X, Y] = meshgrid(-3*sigma:3*sigma, -3*sigma:3*sigma);

    % Bestimme Impulsantwort des zweidimensionalen Gauss-Filters
    % (siehe z.B. Normalverteilung Einführung).
    gaussFilter = (1/sqrt(2*pi*sigma^2)) * exp(-((X.^2 + Y.^2)/(2*sigma^2)));
    gaussFilter = gaussFilter / sum(gaussFilter(:));
    
    % TODO
    
    % Faltung des Bildes mit dem Filter
    % Befehl: conv2, imfilter
    I_gauss = conv2(I, gaussFilter, 'same');
    I_gauss = uint8(I_gauss);
    
end