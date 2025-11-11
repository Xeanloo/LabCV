function S = regionGrowing(I, xStart, yStart, tau)
% Eingabe: I              - Bild
%          xStart, yStart - Saatpunkt
%          threshold      - Schwellwert für die Ähnlichkeit in der Region
%
% Einfacher Steppenbrand-Algorithmus.

    if ndims(I) == 3
        I = rgb2gray(I);
    end
    I = double(I);
    [m,n] = size(I);

    % --- Initialize ---
    S = false(m,n);                % segmentation mask (0/1)
    visited = false(m,n);          % to avoid re-adding points
    apList = false(m,n);           % available points set
    apList(xStart, yStart) = true;

    regionMean = I(xStart,yStart);
    regionCount = 0;

    % 8-neighborhood (use 4-neigh if preferred)
    neigh = [ -1 -1; -1 0; -1 1;
               0 -1;         0 1;
               1 -1;  1 0;   1 1];

    while any(apList(:))
        % --- Step 5: pick p = argmin |I(x) - regionMean|, x in apList ---
        [rows, cols] = find(apList);
        idx = sub2ind([m n], rows, cols);
        diffs = abs(I(idx) - regionMean);
        [~, k] = min(diffs);
        px = rows(k);  py = cols(k);
        p_lin = idx(k);

        % --- Step 6–8: threshold test ---
        if abs(I(p_lin) - regionMean) > tau
            % early stop: no more similar candidates
            return
        end

        % --- Step 9–10: move p from available to region S ---
        apList(px,py) = false;
        S(px,py) = true;
        visited(px,py) = true;

        % --- Step 13: update running mean efficiently ---
        regionCount = regionCount + 1;
        regionMean = (regionMean*(regionCount-1) + I(p_lin)) / regionCount;

        % --- Step 11–12: discover new neighbors of p ---
        for t = 1:size(neigh,1)
            nx = px + neigh(t,1);
            ny = py + neigh(t,2);
            if nx>=1 && nx<=m && ny>=1 && ny<=n
                if ~visited(nx,ny) && ~S(nx,ny) && ~apList(nx,ny)
                    apList(nx,ny) = true;  % add newly discovered neighbor
                end
            end
        end
    end
end
