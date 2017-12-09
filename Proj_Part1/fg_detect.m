%function [fg_depth, fg_img] = fg_detect( RGB_PATH1, RGB_PATH2, DEPTH_PATH1, DEPTH_PATH2)
% Detects Foreground of a given RGB+D image using depth info
clc;

load('cameraparametersAsus.mat');

% Opening dataset
d1 = dir('rgb_image1_14.png');
d_d1 = dir('depth1_14.mat');

% Allocating memory
ims1 = [];
ims_d1 = [];

% Getting the foreground in depth between 2 images (store value and bin matrix)
load(d_d1.name);
fg_depth = abs(double(depth_array) - bg_depth1);
fg_depth_bin = fg_depth > 50; %Save binary img
fg_filtered = bwareaopen(fg_depth_bin,50);

fg_final = fg_depth.*fg_filtered;

%Plots
figure(1);
imshow([im 255*fg_depth])
figure(2);
imshow([im 255*fg_filtered]);

%end

% 3 LABELING NOT WORKING
xyz_1 = get_xyz_asus(fg_depth(:),[480 640],1:640*480, cam_params.Kdepth ,1,0);

pc1 = pointCloud(xyz_1);
figure(3);
showPointCloud(pc1);

CC = bwconncomp(xyz_1, 18);


