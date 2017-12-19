%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    track3D_part2.m                                       %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luís Almeida ()              %
%                              Francisco Pereira ()         %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function objects = track3D_part2(imgseq1, imgseq2, cam_params, cam1toW, cam2toW)
%% Get Background for the whole program
imgseq1 = dir('*.png');
imgseq2 = dir('*.png');
dd = dir('*.mat');
ims = [];
imsd = [];

% Run RANSAC, SIFT and Procrustes to get R and T world
[R,T,P1,P2] = get_T_R_world( im1, imd1, im2, imd2 )

% Get foreground for both cameras
[fg_depth1,fg_depth1_bin, fg_img1, fg_img1_bin] = fg_detect(RGB_PATH1, DEPTH_PATH1, bg_depth1 );
[fg_depth2,fg_depth2_bin, fg_img2, fg_img2_bin] = fg_detect(RGB_PATH2, DEPTH_PATH2, bg_depth2);



% Draw 3D around it and fix having it projected into the BG


%Using SIFT to get correspondence between points in RGB
%Making correspondence between current and last image

end