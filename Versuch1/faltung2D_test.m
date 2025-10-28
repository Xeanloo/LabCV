input_image = imread('bilder/baboon.jpg');
% input_image = imread('bilder/blox.gif');
%input_image = rand(5120, 5120)*255;
sigma = 10;

timer = tic;
blurred_image = gaussFilter(input_image, sigma);
elapsedTime = toc(timer);
disp(['Elapsed time for gaussFilter: ', num2str(elapsedTime), ' seconds']);
timer1 = tic;
blurred_image_sep = gaussFilterSep(input_image, sigma);
blurred_image_sep = uint8(blurred_image_sep);
elapsedTime = toc(timer1);
disp(['Elapsed time for gaussFilterSep: ', num2str(elapsedTime), ' seconds']);
figure(1);
subplot(1,3,1);
imshow(input_image);
title('Original Image');
subplot(1,3,2);
imshow(blurred_image);
title('Gaussian Filter 2D');
subplot(1,3,3);
imshow(blurred_image_sep);
title('Gaussian Filter Separable');

