function I_gauss = gaussFilterSep(I, sigma)
    I = double(I);

    f = linspace(-3*sigma, 3*sigma, 6*sigma + 1);
    % Bestimme Impulsantwort des zweidimensionalen Gauss-Filters
    % (siehe z.B. Normalverteilung Einführung).
    gaussFilter_x = (1/sqrt(2*pi*sigma^2)) * exp(-((f.^2)/(2*sigma^2)));
    gaussFilter_x = gaussFilter_x / sum(gaussFilter_x(:));
    gauss_transposed = gaussFilter_x';
    % TODO
    
    % Faltung des Bildes mit dem Filter
    % Befehl: conv2, imfilter
    I_gauss = conv2(gauss_transposed, gaussFilter_x, I, 'same');

    I_gauss = uint8(I_gauss);
end