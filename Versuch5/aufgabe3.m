img = imread('bilder/peppers.jpg');
if size(img, 3) == 3
    img = rgb2gray(img);
end


[counts, ~] = imhist(img);
X = (0:255)'; 

k = 5;
[L, wcss] = kmeans(X, counts, k);

% Map each pixel to its cluster center
segmented = zeros(size(img));
for i = 0:255
    cluster_id = L(i+1);  % which cluster this gray value belongs to
    % Find all pixels with this gray value and get cluster center
    mask = (img == i);
    cluster_center = mean(X(L == cluster_id));
    segmented(mask) = cluster_center;
end

figure;
subplot(1,2,1); imshow(img); title('Original');
subplot(1,2,2); imshow(uint8(segmented)); title('Segmented');