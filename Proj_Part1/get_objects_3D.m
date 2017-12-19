%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    get_objects_3D.m                                       %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ obj_cam ] = get_objects_3D(labels, fg_depth, xyz_cam)
    
    label_num = 1;
    obj_cam = [];
    % Find the rows and columns of pixels of a specific object
    [r,c] = find(labels == label_num);
    outliers = zeros(size(fg_depth));
    
    while( isempty(r) == 0 || isempty(c) == 0)
        
        % Detect outliers that are far from the mean depth
        soma = 0;
        for i = 1:length(r)
           soma = soma + double(fg_depth(r(i),c(i)));
        end
        avg_depth = soma/length(r);
        
        for i = 1:length(r)
            if(abs(double((fg_depth(r(i),c(i))) - avg_depth)) > 200)
                labels(r(i),c(i)) = 0;
            end
        end
        
        % Update to discard outliers
        [r,c] = find(labels == label_num);
    
        % Get the 3D points corresponding to "r" and "c"
        obj_cam(label_num).xyz = xyz_cam(sub2ind([480 640],r,c),:);
        
        % Delete invalid point
        todelete = (obj_cam(label_num).xyz(:,1) == 0 & obj_cam(label_num).xyz(:,2) == 0 & obj_cam(label_num).xyz(:,3) == 0);
        obj_cam(label_num).xyz(todelete,:) = [];
        
        % Get the centroid of these points
        [idx,C] = kmeans(obj_cam(label_num).xyz,1);
        obj_cam(label_num).centroid = C;
        
        label_num = label_num + 1;
        
        % Find the rows and columns of pixels of a specific object
        [r,c] = find(labels == label_num);
    end
end


