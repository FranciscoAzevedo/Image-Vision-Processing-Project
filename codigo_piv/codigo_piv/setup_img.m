%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    setup_img.m                                            %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [im1,im2,xyzd1,xyzd2,imd1,imd2] = setup_img(imgseq1, imgseq2, cam_params, k)

depth11 = load(imgseq1(k).depth);
depth1=depth11.depth_array;  

depth22 = load(imgseq2(k).depth);
depth2=depth22.depth_array;
im1 = imread(imgseq1(k).rgb);
im2 = imread(imgseq2(k).rgb);

xyzd1 = get_xyz_asus(depth1(:),[480 640], 1:640*480, cam_params.Kdepth, 1, 0); 
xyzd2 = get_xyz_asus(depth2(:),[480 640], 1:640*480, cam_params.Kdepth, 1, 0);

imd1 = reshape(xyzd1,480,640,3);
imd2 = reshape(xyzd2,480,640,3);

end