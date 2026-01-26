function [p, particles] = particleFilterTracking(M, particles)
% Partikelfilter zum Verfolgen von Bereichen mit einer bestimmten Farbe.
%
% Eingabe: M         - Video, (m x n x 3 x t)-Array
%          particles - bekannte Partikel aus früherer Anwendung (optional,
%                      benötigt für Webcam)
% Ausgabe: p         - (2 x t)-Array, verfolgter Pfad
%          particles - letzte bekannte Partikel (benötigt für Webcam)
    
    % Initialisierung
    [m, n, ~, t] = size(M);
    
    if nargin < 2
        % Erzeuge Partikel
        nParticle = 50;
        [X, V] = createParticles(m, n, nParticle);
    else
        % Nutze bekannte Partikel
        X = particles.X;
        V = particles.V;
    end
    
    p = zeros(2, t);
    for i = 1:t
        I = M(:, :, :, i);
        
        % Verschiebe Partikel
        [X, V] = updateParticles(X, V);
        
        % Bestimme Likelihood
        L = likelihood(X, I);
        
        % Bestimme Mittelpunkt
        p(1:2, i) = L / sum(L) * X';
        
        % Resampling
        [X, V] = resampleParticles(X, V, L);
        
        % Informationen über die letzten Partikel für die Webcam-Application
        particles.X = X;
        particles.V = V;
        
        % plot
        if nargin < 2
            figure(2);
            imshow(I);
            hold on
            plot(X(1, :), X(2, :), 'xw', 'MarkerSize', 6, 'LineWidth', 2);
            plot(p(1, i), p(2, i), '.g', 'MarkerSize', 40);
            plot(p(1, i), p(2, i), '.r', 'MarkerSize', 20);
            hold off
            drawnow;
        end
    end
end

function [X, V] = createParticles(m, n, nParticles)
    
    % Generiere zufällige Partikel
    X = [randi(n, 1, nParticles); randi(m, 1, nParticles)];
    V = zeros(2, nParticles);
    
end

function [X_updated, V_updated] = updateParticles(X, V)
    
    % Parameter
    stdMovement = 25;       % Standardabweichung für die Verschiebung
    stdVelocity = 5;        % Standardabweichung für die Geschwindigkeit
    
    % Verschiebe X und aktualisiere Geschwindigkeit
    
        % TODO
    nParticles = size(X, 2);

    X_new = X + V + stdMovement * randn(2, nParticles);

    V_updated = 0.5 * (V + (X_new - X)) + stdVelocity * randn(2, nParticles);

    X_updated = X_new;
    
end

function L = likelihood(X, I)
    
    % Initialisierung
    [m, n, ~] = size(I);
    nParticles = size(X, 2);
    I = double(I);
    
    stdColor = 50;
    meanColor = [255, 0, 0];
    
    L = zeros(1, nParticles);
    
    x = round(X(1, :));
    y = round(X(2, :));
    
    ind = (x >= 1 & x <= n & y >= 1 & y <= m);
    subInd = sub2ind([m, n], y(ind), x(ind));
    d = [I(subInd) - meanColor(1); I(m*n+subInd) - meanColor(2); I(2*m*n+subInd) - meanColor(3)];
    d = sum(d.^2, 1);
    
    L(ind) = 1 / sqrt(2*pi*stdColor^2) * exp(-d/(2 * stdColor^2));
end

function [X_sampled, V_sampled] = resampleParticles(X, V, L)
    
    % Schätze Verteilungsfunktion der Partikel
    
        % TODO
    L = L + 1e-12;

    L = L / sum(L);

    cdf = cumsum(L); 

    cdf(end) = 1;

    nParticles = size(X, 2);

    % Ziehe zufällig Partikel aus der obigen Verteilungsfunktion
    randomValues = rand(1, nParticles);

    indices = arrayfun(@(rv) find(cdf >= rv, 1, 'first'), randomValues);
    
    % Resampling
    X_sampled = X(:, indices);
    V_sampled = V(:, indices);
end
