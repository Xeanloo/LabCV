function [X] = getPoints(img)
    
    X = zeros(8, 2);
    h = size(img, 1);
    w = size(img, 2);
    
    % Plot
    fig = figure();
    figure(fig);
    imshow(img);
    text(0, h + 15, 'Zahlen 1-8:')
    text(0, h + 30, 'Linksklick:')
    text(0, h + 45, 'Rechtsklick')
    text(80, h + 15, 'Punkt an der Stelle des Mauszeigers setzen')
    text(80, h + 30, 'lösche den dichtesten Punkt')
    text(80, h + 45, 'fertig!')
    
    % setze Punkte
    while 1
        % Klicken
        [x, y, button] = ginput(1);
        
        % Klick auswerten
        if ~isempty(button)
            switch button
                case 1
                    % Lösche nächsten Punkt
                    if x >= 1 && x <= w && y >= 1 && y <= h
                        dists = dist([x, y], X');
                        [~, ind] = min(dists);
                        X(ind, :) = [0, 0];
                    end
                case 3
                    % Abbruch
                    break;
                case {49, 50, 51, 52, 53, 54, 55, 56}
                    % Zahl 1-8
                    if x >= 1 && x <= w && y >= 1 && y <= h
                        X(button-48, :) = [x, y];
                    end
            end
        end
        
        % Plot
        imshow(img);
        hold on;
        ind = find(any(X, 2));
        plot(X(ind, 1), X(ind, 2), 'xr', 'MarkerSize', 20, 'LineWidth', 3);
        text(X(ind, 1), X(ind, 2), cellstr(num2str(ind)), 'VerticalAlignment', 'bottom', 'Color', 'red', 'FontSize', 20, 'FontWeight', 'bold');
        hold off;
        text(0, h + 15, 'Zahlen 1-8:')
        text(0, h + 30, 'Linksklick:')
        text(0, h + 45, 'Rechtsklick')
        text(80, h + 15, 'Punkt an der Stelle des Mauszeigers setzen')
        text(80, h + 30, 'lösche den dichtesten Punkt')
        text(80, h + 45, 'fertig!')
    end
    
    close(fig);
end
