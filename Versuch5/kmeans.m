function [L, current_wcss] = kmeans(X, w, k)
    [m, n] = size(X);
    if m == 0
        L = [];
        return;
    end

    if isempty(w)
        w = ones(m, 1);
    end
    
    if size(w, 2) ~= 1
        w = reshape(w, [], 1);
    end


    % Initialize centroids by sampling k distinct points.
    centers = X(randperm(m, k), :); % k x n
    L = zeros(m, 1); % m x 1

    while true
        % m x k matrix stores from every point to every cluster centroidto the closest centroid.
        dists = zeros(m, k); 

        for it = 1:k

            diff = X - centers(it, :); % diff = m x n

            % assigning distances to it'th col of dist array
            dists(:, it) = sum(diff .^ 2, 2);
        end

        % finds min across second dim
        % -> which cluster center the i'th datapoint is closest to.
        [~, L] = min(dists, [], 2);

        % Compute new centroids using weighted averages.
        newCenters = zeros(k, n);
        current_wcss = 0;
        for it = 1:k

            % all points that belong to cluster 'it'
            idx = (L == it); 
            if ~any(idx)
                % Reinitialize empty clusters to a random point.
                newCenters(it, :) = X(randi(m), :);
                continue;
            end

            weights = w(idx); % idx x 1 , column vec
            clusterPoints = X(idx, :); % idx x n
            weightSum = sum(weights);
            if weightSum > 0
                % 1 x idx cross idx x n = 1 x n
                % update it'th cluster center
                newCenters(it, :) = (weights' * clusterPoints) / weightSum;
            else
                newCenters(it, :) = mean(clusterPoints, 1);
            end
            diff = clusterPoints - newCenters(it, :);
            square_diff = diff .^ 2;
            current_wcss = current_wcss + sum(square_diff(:));
        end

        % Stop once the centroids stop moving.
        if all(abs(newCenters - centers) < eps(class(newCenters)), 'all')
            centers = newCenters;
            break;
        end

        centers = newCenters;
    end
end
