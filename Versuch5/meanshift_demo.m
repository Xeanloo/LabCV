% Load the point clouds stored in the MAT file and visualize them.
clear; clc; close all;

dataFile = 'test_data_clustering.mat';
dataStruct = load(dataFile);
varNames = fieldnames(dataStruct);
bArr = [1.0, 0.75, 0.5,1.5];


for idx = 1:numel(varNames)-1
    pts = dataStruct.(varNames{idx});
    b = bArr(idx);
    [L, C] = meanshift(pts, b, 0);
    disp(unique(L));
    disp(C);
    figure;
    plotClusterResults(pts, L);
end