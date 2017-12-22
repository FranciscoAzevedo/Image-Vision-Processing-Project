%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    track3D_part2.m                                        %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function objects = track3D_part2(imgseq1, imgseq2, cam_params)
    
    % Setups a specific first image to use on get_T_R_world
    [im1,im2,xyz1,xyz2,imd1,imd2] = setup_img(imgseq1, imgseq2, cam_params, 1);

    % Run RANSAC, SIFT and Procrustes to get R and T world
    [R,T,P1,P2] = get_T_R_world( im1, imd1, im2, imd2 );

    % Get background for both cameras
    [bg_depth1] = bg_detect(imgseq1);
    [bg_depth2] = bg_detect(imgseq2);
    
    number_of_frames = length(imgseq1.rgb);
    objects = [];
    actual_frame_objects = objects;
    
    %% Starts itearting the frames and detecting objects
    for k = 1:number_of_frames
        disp(k);
        % Trying to clear some issues
        obj_cam1 = [];
        obj_cam2 = [];
        
        % Setup of a given k-th image for both cameras
        [im1,im2,xyz1,xyz2,imd1,imd2] = setup_img(imgseq1, imgseq2, cam_params, k);
        
        % Get foreground for both cameras
        [fg_depth1,fg_depth1_bin] = fg_detect(imgseq1,k,bg_depth1);
        [fg_depth2,fg_depth2_bin] = fg_detect(imgseq2,k,bg_depth2);
        
        % Label objects in 2D
        labels_1 = bwlabel(fg_depth1_bin);
        labels_2 = bwlabel(fg_depth2_bin);

        % Get PC and centroids for camera 1 if there is objects
        if(isempty(find(labels_1 == 1, 1)) == 0)
           [obj_cam1] = get_objects_3D(labels_1,fg_depth1, xyz1, im1);         
        end
        
        % Get PC and centroids for camera 2 if there is objects
        if(isempty(find(labels_2 == 1, 1)) == 0)
            [obj_cam2] = get_objects_3D(labels_2,fg_depth2, xyz2, im2);
        end
        
        % Only process objects if it actually has objects 
        if(isempty(find(labels_1 == 1, 1)) == 0 || isempty(find(labels_2 == 1, 1)) == 0)
            
            % Get the final cornerpoints for all objects
            [objects] = object_consensus(obj_cam1, obj_cam2, R, T, k, objects);
        end
        
        %% Starts doing setup and tracking objects in frames      
        if(isempty(find(labels_1 == 1, 1)) == 0 || isempty(find(labels_2 == 1, 1)) == 0)
            
            %In the first frame there is no prev_frame_objects
            if(k > 1) 
                prev_frame_objects = actual_frame_objects;
            end
            
            % Gets PC_rgb and index and updates actual
            [index] = find_objs_frame_x(objects,k);
            for i = 1:length(index)
                actual_frame_objects(i).X = objects(index(i)).X;
                actual_frame_objects(i).Y = objects(index(i)).Y;
                actual_frame_objects(i).Z = objects(index(i)).Z;
                actual_frame_objects(i).frames_tracked = objects(index(i)).frames_tracked;
                actual_frame_objects(i).PC_rgb = objects(index(i)).PC_rgb;
                actual_frame_objects(i).index = index(i);
            end
            
            %Tracking begins in the 2nd frame
            if(k > 1)
                %Making correspondence between current and last image (TRACKING)
                [objects,  actual_frame_objects] = track_objects(prev_frame_objects, actual_frame_objects, objects,k);
            end  
        end
        
        %plot_boxes_and_PC(xyz1,xyz2,k,objects, R,T);
    end
end