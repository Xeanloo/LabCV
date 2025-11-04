I = imread('bilder/Zellen.jpg');
grayI = rgb2gray(I);
grayI = imgaussfilt(grayI, 5);
% grayI = imbilatfilt(grayI, 75, 9);
edges = edge(grayI, 'canny');
[mOut, nOut, rOut] = houghCircle(edges, 100, 10, 35);

disp(size(rOut, 2) + " circles detected.");

figure(1); subplot(1,3,1);
imshow(I);
plotCircle(mOut, nOut, rOut);
title('Circles detected');

figure(1); subplot(1,3,2);
imshow(edges);
title('Edge Image');

figure(1); subplot(1,3,3);
histogram(rOut);
title('Radius Histogram');
xlabel('Radius (pixels)');
ylabel('Frequency');