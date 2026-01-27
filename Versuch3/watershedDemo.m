% filepath: c:\Users\saifu\Desktop\LabCV\Versuch3\segmentEmphysema.m
% Script for segmenting alveoli in emphysema images using watershed
% Clear workspace
clear; close all; clc;

% Load the emphysema image (replace with your actual image path)
I  = imread("./bilder/Emphysem.png");

% Convert to grayscale if needed
if size(I, 3) == 3
    I_gray = rgb2gray(I);
else
    I_gray = I;
end

% Preprocessing: Gaussian filtering to reduce noise
I_filtered = imgaussfilt(I_gray, 2);

% Enhance contrast
I_enhanced = adapthisteq(I_filtered);

% Compute gradient magnitude using Sobel operator
[Gmag, ~] = imgradient(I_enhanced, 'sobel');

% Morphological opening to remove small structures
se = strel('disk', 2);
Gmag_opened = imopen(Gmag, se);

% Find regional minima to use as markers (background)
minima = imregionalmin(Gmag_opened);

% Impose minima on gradient to force watershed lines
I_mod = imimposemin(Gmag_opened, minima);

% Alternative: Marker-based watershed for better control
% Create markers for foreground (alveoli interiors)
I_binary = imbinarize(I_enhanced);
I_binary = imfill(~I_binary, 'holes');
I_binary = imopen(I_binary, strel('disk', 3));

% Distance transform
D = bwdist(~I_binary);
D = -D;
D = imimposemin(D, minima);

% Apply watershed transformation
S = watershed(D);

% Display results using the provided plotWatershed function
plotWatershed(I, S);

% Optional: Display intermediate steps
figure(2);
subplot(2,3,1); imshow(I); title('Original Image');
subplot(2,3,2); imshow(I_enhanced); title('Enhanced Image');
subplot(2,3,3); imshow(Gmag, []); title('Gradient Magnitude');
subplot(2,3,4); imshow(I_binary); title('Binary Image');
subplot(2,3,5); imshow(D, []); title('Distance Transform');
subplot(2,3,6); imshow(label2rgb(S)); title('Watershed Segmentation');