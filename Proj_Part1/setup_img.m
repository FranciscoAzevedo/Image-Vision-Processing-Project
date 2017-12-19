% Simple scripts usefull to open and do a quick test on a pair of images

depth1 = load('depth1_15.mat');
depth1 = depth1.depth_array;

depth2 = load('depth2_15.mat');
depth2 = depth2.depth_array;

im1 = imread('rgb_image1_15.png');
im2 = imread('rgb_image2_15.png');

xyzd1 = get_xyz_asus(depth1(:),[480 640], 1:640*480, cam_params.Kdepth, 1, 0); 
xyzd2 = get_xyz_asus(depth2(:),[480 640], 1:640*480, cam_params.Kdepth, 1, 0);

imd1 = reshape(xyzd1,480,640,3);
imd2 = reshape(xyzd2,480,640,3);