function [foreground_depth, foreground_img] = fg_detect( blah, blah2)
% Detects Foreground of a given RGB+D image using depth info
clear all; clc;

load('cameraparametersAsus.mat')

% Opening dataset
d1 = dir('rgb_image1_2.png');
d_d1 = dir('depth1_2.mat');
d2 = dir('rgb_image1_3.png');
d_d2 = dir('depth1_3.mat');

% Allocating memory
ims1 = [];
ims_d1 = [];
ims2 = [];
ims_d2 = [];

% Converting image 1 to gray and to column vectors
im = rgb2gray(imread(d1.name));
load(d_d1.name);
ims1 = [ims1 im(:)];
ims_d1 =[ims_d1 depth_array(:)];

% Converting image 2 to gray and to column vectors
im2 = rgb2gray(imread(d2.name));
load(d_d2.name);
ims2 = [ims2 im2(:)];
ims_d2 =[ims_d2 depth_array(:)];

% Apply filter to have stronger border contrast
median_im1 = median(double(ims1),2);
median_depth1 = median(double(ims_d1),2);

median_im2 = median(double(ims2),2);
median_depth2 = median(double(ims_d2),2);

% Apply interpolation to fix some background


% Getting vector back into 640x480
bg_img1 = reshape(median_im1,[480 640]); %RGB BG can be usefull but prob not
bg_depth1 = reshape(median_depth1,[480 640]);

bg_img2 = reshape(median_im2,[480 640]); %RGB BG can be usefull but prob not
bg_depth2 = reshape(median_depth2,[480 640]);

% Getting the foreground between 2 images
foreground_depth = abs(bg_depth2 - bg_depth1) > 200; 
foreground_img = abs(bg_img2 - bg_img1) > 50; %Mostly useless

%Plots
figure(1);
imshow(foreground_depth);
figure(2);
imshow(foreground_img);

end


