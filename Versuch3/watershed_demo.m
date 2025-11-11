I = imread("./bilder/Emphysem.png");
figure(2);
subplot(1, 4, 1);
I = imdiffusefilt(I, "NumberOfIterations", 4);
imshow(I);

% subplot(1, 4, 2);
% I = imgaussfilt(I, 1.5);
% imshow(I);

subplot(1, 4, 3);
I = im2gray(I);
imshow(I);
%I = RGB;

subplot(1, 4, 4);
Icomp = imcomplement(I);
imshow(I);
Ifilt = imhmin(Icomp, 5);
Lfilt = watershed(Ifilt);
plotWatershed(RGB, Lfilt)