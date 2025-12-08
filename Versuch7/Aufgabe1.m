function [maxValue, optimalX] = graphicalMethod(f, A, b)
    % graphicalMethod - Graphical solution of linear programming problem
    %   Solves: max f'*x such that Ax <= b and x >= 0
    %
    % Input:
    %   f - objective function coefficient vector (2x1)
    %   A - constraint matrix (mx2)
    %   b - constraint bound vector (mx1)
    %
    % Output:
    %   maxValue - maximum value of objective function found
    %   optimalX - optimal solution vector (2x1)
    
    % Initialize variables
    selectedPoints = [];
    selectedValues = [];
    validPoints = [];
    maxValue = -inf;
    optimalX = [0; 0];
    
    % Create figure
    figure('Name', 'Graphical LP Solver', 'NumberTitle', 'off');
    hold on;
    grid on;
    axis equal;
    
    % Determine plot limits based on constraints
    [xMin, xMax, yMin, yMax] = determinePlotLimits(A, b);
    xlim([xMin, xMax]);
    ylim([yMin, yMax]);
    xlabel('x_1');
    ylabel('x_2');
    title('Linear Programming Problem - Click to select points (Right-click to finish)');
    
    % Plot constraints
    plotConstraints(A, b, xMin, xMax, yMin, yMax);
    
    % Plot feasible region (shaded)
    plotFeasibleRegion(A, b, xMin, xMax, yMin, yMax);
    
    % Plot objective function vector (orthogonal direction)
    plotObjectiveVector(f, xMin, xMax, yMin, yMax);
    
    % Interactive point selection
    fprintf('Click on the plot to select points.\n');
    fprintf('Right-click or press Enter to finish.\n\n');
    
    while true
        % Get mouse click
        [x, y, button] = ginput(1);
        
        % Check for exit condition (right-click or empty)
        if isempty(button) || button ~= 1
            break;
        end
        
        % Store selected point
        selectedPoints = [selectedPoints; x, y];
        
        % Check if point is valid (satisfies all constraints)
        isValid = checkFeasibility([x; y], A, b);
        
        % Evaluate objective function
        objValue = f' * [x; y];
        selectedValues = [selectedValues; objValue];
        
        % Plot the selected point
        if isValid
            plot(x, y, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'LineWidth', 2);
            validPoints = [validPoints; x, y, objValue];
            fprintf('Point (%.4f, %.4f): VALID, f(x) = %.4f\n', x, y, objValue);
            
            % Update maximum if better solution found
            if objValue > maxValue
                maxValue = objValue;
                optimalX = [x; y];
                fprintf('  -> New best solution!\n');
            end
        else
            plot(x, y, 'rx', 'MarkerSize', 10, 'LineWidth', 2);
            fprintf('Point (%.4f, %.4f): INVALID, f(x) = %.4f\n', x, y, objValue);
        end
        
        % Display objective value at clicked point
        text(x, y, sprintf('  %.2f', objValue), 'FontSize', 8);
    end
    
    % Display results
    fprintf('\n=== Results ===\n');
    if ~isempty(validPoints)
        fprintf('Maximum valid objective value: %.4f\n', maxValue);
        fprintf('Optimal solution: x1 = %.4f, x2 = %.4f\n', optimalX(1), optimalX(2));
        
        % Highlight optimal solution
        plot(optimalX(1), optimalX(2), 'b*', 'MarkerSize', 15, 'LineWidth', 3);
        text(optimalX(1), optimalX(2), '  OPTIMAL', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'blue');
    else
        fprintf('No valid points were selected.\n');
        maxValue = NaN;
        optimalX = [NaN; NaN];
    end
    
    hold off;
end

function [xMin, xMax, yMin, yMax] = determinePlotLimits(A, b)
    maxX = 1;
    maxY = 1;
    
    % Find maximum intercepts with axes
    for i = 1:size(A, 1)
        if A(i, 1) > 0
            maxX = max(maxX, b(i) / A(i, 1));
        end
        if A(i, 2) > 0
            maxY = max(maxY, b(i) / A(i, 2));
        end
    end
    
    % Set limits with some margin
    xMin = 0;
    xMax = maxX * 1.1;
    yMin = 0;
    yMax = maxY * 1.1;
end

function plotConstraints(A, b, xMin, xMax, yMin, yMax)
    for i = 1:size(A, 1)
        a1 = A(i, 1);
        a2 = A(i, 2);
        bi = b(i);
        
        % Plot constraint line: a1*x1 + a2*x2 = bi
        if a1 ~= 0 && a2 ~= 0
            % Solve for x2 in terms of x1
            x1 = linspace(xMin, xMax, 100);
            x2 = (bi - a1 * x1) / a2;
            plot(x1, x2, '--', 'LineWidth', 1.5);
        elseif a2 == 0
            % Vertical line
            x1 = bi / a1;
            plot([x1, x1], [yMin, yMax], '--', 'LineWidth', 1.5);
        elseif a1 == 0
            % Horizontal line
            x2 = bi / a2;
            plot([xMin, xMax], [x2, x2], '--', 'LineWidth', 1.5);
        end
    end
    
    % Plot non-negativity constraints
    plot([0, 0], [yMin, yMax], 'k-', 'LineWidth', 1);
    plot([xMin, xMax], [0, 0], 'k-', 'LineWidth', 1);
end

function plotFeasibleRegion(A, b, xMin, xMax, yMin, yMax)
    numPoints = 1000;
    x1_vals = linspace(xMin, xMax, numPoints);
    x2_vals = linspace(yMin, yMax, numPoints);
    [X1, X2] = meshgrid(x1_vals, x2_vals);
    
    % Check each point if it satisfies all constraints
    feasible = ones(size(X1));
    
    for i = 1:numPoints
        for j = 1:numPoints
            point = [X1(i, j); X2(i, j)];
            
            % Check if point is valid
            if any(A * point > b) || any(point < 0)
                feasible(i, j) = 0;
            end
        end
    end
    
    % Shade the feasible region
    contourf(X1, X2, feasible, 1, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
end

function plotObjectiveVector(f, xMin, xMax, yMin, yMax)
    startX = 0;
    startY = 0;
    
    % Scale the vector for visibility
    scale = min(xMax - xMin, yMax - yMin) * 0.3;
    vectorLength = sqrt(f(1)^2 + f(2)^2);
    f_scaled = f / vectorLength * scale;
    
    quiver(startX, startY, f_scaled(1), f_scaled(2), 0, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
    text(f_scaled(1), f_scaled(2), sprintf('  f'), 'Color', 'red');
end

function isValid = checkFeasibility(x, A, b)
    % Check Ax <= b and x >= 0
    isValid = all(A * x <= b) && all(x >= 0);
end


% [maxValue, optimalX] = graphicalMethod([30; 20], [2, 1; 1, 1; 1, 0], [1500; 1200; 500]);
% [maxValue, optimalX] = graphicalMethod([12; 7], [2, 1; 3, 2], [10000; 16000]);
[maxValue, optimalX] = graphicalMethod([2; 5], [1, 4; 3, 1; 1, 1; 0, 1], [24; 21; 9;  4]);