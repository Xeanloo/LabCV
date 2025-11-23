function elbowMethod(X, kMin, kMax)
    weights = zeros(kMax, 1);
    for it = kMin:kMax
        [~, weight] = kmeans(X, [], it);
        weights(it, :) = weight;
    end
    figure;
    plot(weights, 'LineWidth', 1.5)
    grid on
end