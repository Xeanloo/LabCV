function HC = histCost(SCx, SCy)
% Chi^2-Test zum Vergleich zweier Histogramme
    
    % TODO
    if size(SCx, 3) == size(SCy, 3) & size(SCx, 3) == 1
        a = SCx(:);
        b = SCy(:);
        diff = a - b;
        sum_ab = a + b;
        % Vermeide Division durch Null
        valid = sum_ab ~= 0;
        HC = 0.5 * sum((diff(valid).^2) ./ sum_ab(valid)); 
    else
        HC = 0;
    end
end
