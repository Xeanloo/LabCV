I = im2double(rgb2gray(imread('./bilder/lab4Picts/CellDetectPreFreeze.jpg')));

freeze = load("CellDetectFreeze.mat");
prefreeze = load("CellDetectPreFreeze.mat");
postfreeze = load("CellDetectPostFreeze.mat");

[~, freezeCluster] = meanshift(freeze.cell_positions, 14, 0);
[~, prefreezeCluster] = meanshift(prefreeze.cell_positions, 4, 0);
[~, postfreezeCluster] = meanshift(postfreeze.cell_positions, 4, 0);

figure;
imshow(I);
hold on;
for i = 1:size(freezeCluster, 1)
    plot(freezeCluster(i, 2), freezeCluster(i, 1), 'r*', 'MarkerSize', 10);
end
hold off;
