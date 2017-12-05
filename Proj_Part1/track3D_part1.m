%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    peopletracking.m                                       %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luís Almeida ()              %
%                              Francisco Pereira ()         %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function objects = track3D_part1(imgseq1, imgseq2, cam_params, cam1toW, cam2toW)

%Get Foreground in depth points for both cameras

[fg_depth1,fg_depth1_bin, fg_img1, fg_img1_bin] = fg_detect( RGB_PATH1, RGB_PATH2, DEPTH_PATH1, DEPTH_PATH2);
[fg_depth2,fg_depth2_bin, fg_img2, fg_img2_bin] = fg_detect(RGB_PATH1, RGB_PATH2, DEPTH_PATH1, DEPTH_PATH2);

%Draw a 2D box around it


%Draw 3D around it and fix having it projected into the BG

%Using SIFT to get correspondence between points in RGB

%Get respective points in X,Y,Z

%Run RANSAC to eliminate outliers

%Drawing box around object and storing data

%Making correspondence between current and last image

end