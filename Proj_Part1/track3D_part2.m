%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    track3D_part2.m                                       %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Lu�s Almeida ()              %
%                              Francisco Pereira ()         %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function objects = track3D_part2(imgseq1, imgseq2, cam_params)
    
    imgseq1 = dir('*.png');
    imgseq2 = dir('*.png');
    load(cam_params);

    [depth1,depth2,im1,im2,xyzd1,xyzd2,imd1,imd2] = setup_img('depth1_15.mat','depth2_15.mat','rgb_image1_15.png','rgb_image2_15.png');

    % Run RANSAC, SIFT and Procrustes to get R and T world
    [R,T,P1,P2] = get_T_R_world( im1, imd1, im2, imd2 )

    % Get foreground for both cameras
    [fg_depth1,fg_depth1_bin, fg_img1, fg_img1_bin] = bg_fg_detect(RGB_PATH1, DEPTH_PATH1, bg_depth1 );
    [fg_depth2,fg_depth2_bin, fg_img2, fg_img2_bin] = fg_detect(RGB_PATH2, DEPTH_PATH2, bg_depth2);

    % Label objects in 2D
    labels = bwlabel(fg_depth1_bin);
    labels_2 = bwlabel(fg_depth2_bin);
    
    % Get PC and centroids for each object in each camera
    [obj_cam1]= get_objects_3D(labels_1,fg_depth1, xyz1);
    [obj_cam2]= get_objects_3D(labels_2,fg_depth2, xyz2);
    
    % Get the final cornerpoints for all objects
    [objects] = object_consensus(obj_cam1, obj_cam2, R, T);


    %Using SIFT to get correspondence between points in RGB
    %Making correspondence between current and last image

end