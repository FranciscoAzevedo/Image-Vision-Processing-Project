% Main
close all;
clear;
clc;
tic;
load('cameraparametersAsus');
load('lab1JPC');
 cam1toW.R=R1;
 cam1toW.T=T1;
 cam2toW.R=R2;
 cam2toW.T=T2;
[ imgseq1,imgseq2 ] = creates_structures( );

% O k � o numero da imagem
%[objects, cam1toW, cam2toW]= track3D_part2(imgseq1, imgseq2, cam_params);

[objects]= track3D_part1(imgseq1, imgseq2, cam_params, cam1toW, cam2toW);

% for i=2:length(objects)
%    showPointCloud(objects(i).PC_rgb); 
% end
toc;