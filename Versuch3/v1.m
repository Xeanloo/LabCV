% --- Load and prepare the image ---
I = imread('./bilder/Emphysem.png');
figure; imshow(I); title('Original Image');

% Convert to grayscale
Igray = rgb2gray(I);

% --- Step 1: Smooth to reduce noise ---
I_filt = imgaussfilt(Igray, 2);

% --- Step 2: Compute gradient magnitude (for watershed topography) ---
gmag = imgradient(I_filt);

figure;
subplot(1,3,1), imshow(Igray,[]), title('Grayscale');
subplot(1,3,2), imshow(I_filt,[]), title('Smoothed');
subplot(1,3,3), imshow(gmag,[]), title('Gradient Magnitude');

% --- Step 3: Morphological preprocessing to find background ---
se = strel('disk', 3);
Io = imopen(I_filt, se);
Ie = imerode(I_filt, se);
Iobr = imreconstruct(Ie, I_filt);

% --- Step 4: Binary mask of tissue walls ---
bw = imbinarize(Iobr, 'adaptive');
bw = imcomplement(bw);  % walls should be foreground (dark)
bw = bwareaopen(bw, 50); % remove small noise

figure; imshow(bw); title('Binary tissue mask');

% --- Step 5: Distance transform and marker detection ---
D = -bwdist(~bw);
mask = imextendedmin(D, 2);     % detect internal markers
D2 = imimposemin(D, mask);      % suppress spurious minima

% --- Step 6: Watershed segmentation ---
L = watershed(D2);

% --- Step 7: Overlay results ---
figure;
imshow(Igray, []);
hold on;
contour(L == 0, 'r', 'LineWidth', 1);
title('Watershed Lines on Grayscale Image');

% --- Optional: use label2rgb for colored display ---
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
figure; imshow(Lrgb); title('Watershed Regions (Colored)');
