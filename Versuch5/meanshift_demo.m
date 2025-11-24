% Load the point clouds stored in the MAT file and visualize them.
clear; clc; close all;

dataFile = 'test_data_clustering.mat';
dataStruct = load(dataFile);
varNames = fieldnames(dataStruct);

for idx = 1:numel(varNames)-1
    pts = dataStruct.(varNames{idx});
    b = 2;
    [L, C] = meanshift(pts, b, 0);
    disp(unique(L));
    disp(C);
end