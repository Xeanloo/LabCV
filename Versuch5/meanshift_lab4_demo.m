I = im2double(rgb2gray(imread('./bilder/lab4Picts/CellDetectPreFreeze.jpg')));

freeze = load("CellDetectFreeze.mat");
prefreeze = load("CellDetectPreFreeze.mat");
postfreeze = load("CellDetectPostFreeze.mat");

%[~, freezeCluster] = meanshift(freeze.cell_positions, 35, 0);
 [~, prefreezeCluster] = meanshift(prefreeze.cell_positions, 15, 0);
% [~, postfreezeCluster] = meanshift(postfreeze.cell_positions, 4, 0);

figure;
imshow(I);
hold on;
for i = 1:size(prefreezeCluster, 1)
    plot(prefreezeCluster(i, 2)+50, 50+prefreezeCluster(i, 1), 'r*', 'MarkerSize', 5);
end
hold off;
