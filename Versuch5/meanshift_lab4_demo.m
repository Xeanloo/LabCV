IPreFreeze = im2double(rgb2gray(imread('./bilder/lab4Picts/CellDetectPreFreeze.jpg')));
IFreeze = im2double(rgb2gray(imread('./bilder/lab4Picts/CellDetectFreeze.jpg')));
IPostFreeze = im2double(rgb2gray(imread('./bilder/lab4Picts/CellDetectPostFreeze.jpg')));

freeze = load("CellDetectFreeze.mat");
prefreeze = load("CellDetectPreFreeze.mat");
postfreeze = load("CellDetectPostFreeze.mat");

[~, freezeCluster] = meanshift(freeze.cell_positions, 15, 0);
[~, prefreezeCluster] = meanshift(prefreeze.cell_positions, 15, 0);
[~, postfreezeCluster] = meanshift(postfreeze.cell_positions, 15, 0);

figure;
imshow(IPreFreeze);
hold on;
for i = 1:size(prefreezeCluster, 1)
    plot(prefreezeCluster(i, 2)+50, 50+prefreezeCluster(i, 1), 'r*', 'MarkerSize', 5);
end
hold off;

figure;
imshow(IFreeze);
hold on;
for i = 1:size(freezeCluster, 1)
    plot(freezeCluster(i, 2)+50, 50+freezeCluster(i, 1), 'r*', 'MarkerSize', 5);
end
hold off;

figure;
subplot(1,2,1);
imshow(IPostFreeze);
hold on;
for i = 1:size(postfreezeCluster, 1)
    plot(postfreezeCluster(i, 2)+50, 50+postfreezeCluster(i, 1), 'r*', 'MarkerSize', 5);
end
hold off;
subplot(1,2,2);
imshow(IPostFreeze);
hold on;
for i = 1:size(postfreeze.cell_positions, 1)
    plot(postfreeze.cell_positions(i, 2)+50, 50+postfreeze.cell_positions(i, 1), 'r*', 'MarkerSize', 5);
end
hold off;