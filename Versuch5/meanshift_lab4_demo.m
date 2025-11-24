I = im2double(rgb2gray(imread('./bilder/lab4Picts/CellDetectPostFreeze.jpg')));
vals = I(:);
numPixels = numel(I);

[row, col] = ind2sub(size(I), 1:numPixels);

result = [col(:), row(:), vals];
disp(size(I));
disp(size(result)); % this is 1.1 mil x 3

%%
% [~, C] = meanshift(result, 2, 2);
%     figure;
%     imshow(I); hold on;
%     for i = 1:size(C, 1)
%         plot(C(i, 2), C(i, 1), 'r+', 'MarkerSize', 2, 'LineWidth', 1);
%     end
%     hold off;
%     title('Gefundene Zellen (rote Kreuze)');