%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    setup_img.m                                            %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [im1,im2,xyzd1,xyzd2,imd1,imd2] = setup_img(imgseq1, imgseq2, cam_params, k)

depth1 = load(imgseq1.depth(k).name);
depth1 = depth1.depth_array;

depth2 = load(imgseq2.depth(k).name);
depth2 = depth2.depth_array;

im1 = imread(imgseq1.rgb(k).name);
im2 = imread(imgseq2.rgb(k).name);

xyzd1 = get_xyz_asus(depth1(:),[480 640], 1:640*480, cam_params.Kdepth, 1, 0); 
xyzd2 = get_xyz_asus(depth2(:),[480 640], 1:640*480, cam_params.Kdepth, 1, 0);

imd1 = reshape(xyzd1,480,640,3);
imd2 = reshape(xyzd2,480,640,3);

end