I = imread('bilder/Zellen.jpg');
grayI = rgb2gray(I);
grayI = imgaussfilt(grayI, 5);
edges = edge(grayI, 'Canny');
[mOut, nOut, rOut] = houghCircle(edges, 50, 10, 20);

figure(1); subplot(1,2,1);
imshow(I);
plotCircle(mOut, nOut, rOut);
title('Circles detected');

figure(1); subplot(1,2,2);
imshow(edges);
title('Edge Image');