% Testet den Harris-Corner-Detektor.
I = imread('./bilder/bloecke.jpg');
ecken = harrisCorner(I, 1, 4, 1e6);



 %disp(ecken);

 % Darstellung
figure(1); clf;
subplot(121); imshow(I);
subplot(122); imshow(I);

hold on;        % ermöglicht weitere Objekte in die figure zu zeichnen

% Ecken markieren
% Hinweis: Bilder werden in Matlab als Array in einem ij-Koordinatensystem
% dargestellt, mit dem Nullpunkt in der linken, oberen Ecke. Die i-Achse
% verläuft senkrecht, die j-Achse waagerecht.


plot(ecken(:,2), ecken(:,1), 'r+', 'MarkerSize', 8, 'LineWidth', 1.5);


hold off;  

