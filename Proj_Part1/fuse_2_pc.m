%FUSE_2_PC Fuses two point clouds into world reference frame
%   Inputs: 2 RGB+D images
%   Outputs: 1 PC in World Frame
%   Description: Given RGB+D from camera 1 project point cloud w/colours
%                Do the same for camera 2. Transform both cameras local 
%                Coordinate frame into world frame and fuse into 1 PC w/colour
%
clear ; clc;

%% Getting the RGB+D data into two seperate coloured PC
% Loading RGB+D image
load('calib_asus.mat');

depth_1 = load('depth1_1.mat');
rgb_1 = imread('rgb_image1_1.png');
depth_2 = load('depth2_1.mat');
rgb_2 = imread('rgb_image2_1.png');

figure(1);
imagesc([rgb_1 rgb_2]);
figure(2);
imagesc([depth_1.depth_array depth_2.depth_array]);

% Getting XYZ coordinates from depth file
xyz_1 = get_xyz_asus(depth_1.depth_array(:),[480 640],1:640*480, Depth_cam.K ,1,0);
xyz_2 = get_xyz_asus(depth_2.depth_array(:),[480 640],1:640*480, Depth_cam.K ,1,0);

% colour_xy: x is camera number, y is picture sequence number
colour_l1 = reshape(rgb_1, 480*640,3);
colour_21 = reshape(rgb_2, 480*640,3);

% Projecting colour into the XYZ coordinates making it a coloured PC
pc1 = pointCloud(xyz_1, 'Color', colour_l1);
pc2 = pointCloud(xyz_2, 'Color', colour_21);

% Showing results so far
figure(3)
showPointCloud(pc1);
figure(4)
showPointCloud(pc2);


%% Getting the cam_to_W.R and cam_to_W.T for both cameras
% Removing garbage points
m1 = depth_1.depth_array >0;
m2 = depth_2.depth_array >0;
 
imaux1 = double(repmat(m1,[1,1,3])).*(double(rgb_1)/255);
imaux2 = double(repmat(m2,[1,1,3])).*(double(rgb_2)/255);

% Testing Harris corner detect
% [bin_marker1, u1, v1] = harris(rgb2gray(imread('rgb_image1_1.png')), 2, 1000, 10, 1);
% [bin_marker2, u2, v2] = harris(rgb2gray(imread('rgb_image2_1.png')), 2, 1000, 10, 1);

% select figure with im1 and click 5 points
figure(5);
imagesc(imaux1);
[u1] = [210.638248847926;278.472350230415;274.048387096774;448.057603686636;452.481566820276;490.822580645161];
[v1] = 
% select figure with im2 and click in the corresponding points
figure(6);
imagesc(imaux2);
[u2,v2]= ginput(6);

ind1 = sub2ind([480 640],uint64(v1),uint64(u1));
ind2 = sub2ind([480 640],uint64(v2),uint64(u2));

% Compute Centroids
cent1 = mean(xyz_1(ind1,:))';
cent2 = mean(xyz_1(ind2,:))';

pc1 = xyz_1(ind1,:)' - repmat(cent1,1,6);
pc2 = xyz_2(ind2,:)' - repmat(cent2,1,6);

[a,b,c]=svd(pc2*pc1');
R = a*c';

%% Transforming local coordinate frame into world coordinate frame
T = cent2 - R*cent1;
xyzt_1 = R *(xyz_1'-repmat(T,1,length(xyz_1))) ;
xyzt_2 = xyz_2'-repmat(cent2,1,length(xyz_2));


% Merging 2 Point Clouds based on points already in world coord frame
ptotal = pointCloud([xyzt_1' ; xyzt_2'],'Color',[colour_l1; colour_21]);
figure(5);
showPointCloud(ptotal);

