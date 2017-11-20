% function obj = fg_detect( blah, blah2)
% Detects Foreground of a given RGB+D image
clear all; clc;

% Opening dataset
d = dir('rgb_image1_2.png');
dd = dir('depth1_2.mat');

d1 = dir('rgb_image1_1.png');
dd1 = dir('depth1_1.mat');

ims=[];
imsd=[];

% Converting image to gray and column vectors
for i=1:length(d),
    im = rgb2gray(imread(d(i).name));
    imshow(im); colormap(gray);
    load(dd(i).name);
    drawnow;
    
    %Convert to column vector to apply filters
    ims = [ims im(:)];
    imsd =[imsd depth_array(:)];
end

% Apply filter to have stronger border contrast
median_im = median(double(ims),2);
median_depth = median(double(imsd),2);

% Getting vector back into 640x480
bgim = reshape(median_im,[480 640]);
bgimd = reshape(median_depth,[480 640]);

% for i=1:length(d),
    
    im = rgb2gray(imread(d(i).name));
    
    foreg = abs(double(im) - double(bgim)) > 40; %foreground metric for colour
    
    load(dd(i).name);
    
    foregd = abs(double(depth_array) - bgimd) > 0; %foreground metric for depth
    
    figure(2);
    imshow([im foreg]);
    figure(3);
    imagesc([im foregd]);
    colormap('jet');

% end

% end


