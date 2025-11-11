RGB = imread("./bilder/Emphysem.png");

figure(2);
subplot(1, 4, 1);
I = im2gray(RGB);
imshow(I)

figure(2);
subplot(1, 4, 2);
I = imdiffusefilt(I);
I = imgaussfilt(I, 3);
imshow(I);

figure(2);
subplot(1, 4, 3);
I = imsharpen(I, 'Radius', 2, 'Amount', 1.5);
% I = adapthisteq(I);
imshow(I);

figure(2);
subplot(1, 4, 4);
Icomp = imcomplement(I);


Ifilt = imhmin(Icomp, 6.5);
Ifilt(Ifilt > 100) = 0;
imshow(Ifilt);
Lfilt = watershed(Ifilt);

figure(3);
subplot(1, 1, 1);
imshow(RGB);
plotWatershed(RGB, Lfilt);