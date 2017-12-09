% UNTITLED Summary of this function goes here
% Detects Background of a given RGB+D image using depth info
d1 = dir('*.png');
d_d1 = dir('*.mat');

% Allocating memory
ims = [];
ims_d = [];

% Opening images and storing in ims and imsd struct
for i=1:length(d1), 
    im = rgb2gray(imread(d1(i).name));
    load(d_d1(i).name);

    % Convert to column vector to apply filters
    ims = [ims im(:)];
    ims_d = [ims_d depth_array(:)];
end

% Apply filter to have stronger border contrast 
median_rgb = median(double(ims),2);
median_depth = median(double(ims_d),2);

% Convert to matrix again 
bg_img = reshape(median_rgb,[480 640]); 
bg_depth = reshape(median_depth,[480 640]);

% Getting the foreground (REMINDER: NOT PROCESSING COLOUR HERE)
load(d_d1(4).name);
fg_depth = abs(double(depth_array) - bg_depth);
fg_depth_bin = fg_depth > 700; %Detect close enough objects

% Calculate gradients
[grad_x, grad_y] = gradient(fg_depth_bin);
grad_x = not(grad_x);
grad_y = not(grad_y);

segmented_fg = fg_depth_bin.*grad_x;
filtered_fg = imopen(segmented_fg,strel('disk',2));
filtered_fg2 = bwareaopen(filtered_fg,100);

figure(1);
imshow(filtered_fg);
figure(2);
imshow(filtered_fg2);


% end

