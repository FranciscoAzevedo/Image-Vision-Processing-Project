function [depth1,depth2,im1,im2,xyzd1,xyzd2,imd1,imd2] = setup_img(depth_name1,depth_name2, filename1, filename2)

depth1 = load(depth_name1);
depth1 = depth1.depth_array;

depth2 = load(depth_name2);
depth2 = depth2.depth_array;

im1 = imread(filename1);
im2 = imread(filename2);

xyzd1 = get_xyz_asus(depth1(:),[480 640], 1:640*480, cam_params.Kdepth, 1, 0); 
xyzd2 = get_xyz_asus(depth2(:),[480 640], 1:640*480, cam_params.Kdepth, 1, 0);

imd1 = reshape(xyzd1,480,640,3);
imd2 = reshape(xyzd2,480,640,3);

end