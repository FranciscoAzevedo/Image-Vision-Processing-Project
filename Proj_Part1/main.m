% Main
close all;
clear;
clc;
tic;
load('cameraparametersAsus');

[ imgseq1,imgseq2 ] = creates_structures( );

% O k é o numero da imagem
%[objects, cam1toW, cam2toW]= track3D_part2(imgseq1, imgseq2, cam_params);

[objects]= track3D_part2(imgseq1, imgseq2, cam_params);

% for i=2:length(objects)
%    showPointCloud(objects(i).PC_rgb); 
% end
toc;