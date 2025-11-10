grayImage = imread('bilder/rectangle.png');

figure('Name', 'Region Growing');
subplot(1, 2, 1);
imshow(grayImage);
title('Click to select seed point');

% Get Input
[x, y] = ginput(1);
xStart = round(x);
yStart = round(y);

% Mark chosen point
hold on;
plot(xStart, yStart, 'x', 'MarkerSize', 15, 'LineWidth', 2);
plot(xStart, yStart, 'x', 'MarkerSize', 20, 'LineWidth', 2);
hold off;

% Get threshold input
prompt = {'Enter threshold value (e.g., 10-200):'};
dlgtitle = 'Enter Threshold';
dims = [1 200];
defaultans = {'65'};
answer = inputdlg(prompt, dlgtitle, dims, defaultans);

if isempty(answer)
    threshold = 65;
    fprintf('Cancel - using default threshold: %d\n', threshold);
else
    threshold = str2double(answer{1});
    fprintf('Selected seed point: (%d, %d)\n', xStart, yStart);
    fprintf('Selected threshold: %d\n', threshold);
end

segmentedRegions = regionGrowing(grayImage, xStart, yStart, threshold);

subplot(1, 2, 2);
imshow(grayImage);
hold on;

contour(segmentedRegions, [0.5 0.5], 'r', 'LineWidth', 2);

plot(xStart, yStart, 'x', 'MarkerSize', 15, 'LineWidth', 2);
plot(xStart, yStart, 'x', 'MarkerSize', 20, 'LineWidth', 2);

hold off;
title(sprintf('Segmentation (Threshold: %d)', threshold));
xlabel('Red contour shows the segmented region');

figure('Name', 'Segmentation Mask');
imshow(segmentedRegions);
title(sprintf('Segmentation Mask (Seed point: (%d,%d), Threshold: %d)', ...
    xStart, yStart, threshold));