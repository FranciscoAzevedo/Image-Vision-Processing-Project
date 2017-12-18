%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    bg_fg_detect.m                                         %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Lu?s Almeida ()              %
%                              Francisco Pereira ()         %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Detects Background of a given RGB+D image using depth info
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
bg_rgb = reshape(median_rgb,[480 640]); 
bg_depth = reshape(median_depth,[480 640]);

% Getting the foreground (REMINDER: NOT PROCESSING COLOUR HERE)
load(d_d1(4).name);
fg_depth = abs(double(depth_array) - bg_depth);
fg_depth_bin = fg_depth > 700; %Detect close enough objects

% Calculate gradients
[grad_x, grad_y] = gradient(fg_depth);
mag_grad = sqrt(grad_x.^2 + grad_y.^2);
mag_grad(mag_grad < 2000) = 0;
mag_grad = not(mag_grad); % invert values

% Apply the filters (split different objects and filter garbage)
segmented_fg = fg_depth_bin.*mag_grad;
filtered_fg = imopen(segmented_fg,strel('disk',2));
filtered_fg_final = bwareaopen(filtered_fg,2000);

%% Projects points into XYZ coordinates to identify objects
xyz_1 = get_xyz_asus(filtered_fg_final(:),[480 640],1:640*480, cam_params.Kdepth ,1,0);

pc1 = pointCloud(xyz_1);
showPointCloud(pc1);
% 
% [idx3,C,sumd3] = kmeans(xyz_1,3,'Distance','cityblock','Replicates',5);
% [idx2,C,sumd2] = kmeans(xyz_1,2,'Distance','cityblock','Replicates',5);
% [idx1,C,sumd1] = kmeans(xyz_1,1,'Distance','cityblock','Replicates',5);

% end

