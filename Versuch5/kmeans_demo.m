% Load the point clouds stored in the MAT file and visualize them.
clear; clc; close all;

dataFile = 'test_data_clustering.mat';
dataStruct = load(dataFile);
varNames = fieldnames(dataStruct);

for idx = 1:numel(varNames)
    pts = dataStruct.(varNames{idx});
    
    [L, ~] = kmeans(pts, [], 3);
    figure(idx);
    plotClusterResults(pts, L);
end
