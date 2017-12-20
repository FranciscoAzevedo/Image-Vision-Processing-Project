function [ objects ] = object_consensus( obj_cam1, obj_cam2, R, T, frame_number, objects ) 
    
    cnt = 1;
    %% If both cameras have objects
    if(isempty(obj_cam1) == 0 && isempty(obj_cam2) == 0)    
        for i = 1:length(obj_cam1)
            for j = 1:length(obj_cam2)
                % Transformar centroide cam2 na cam1
                new_centroid2 = (obj_cam2(j).centroid)*R + T(1,:);
                % Comparar distancias entre centroides
                dist(i).distances(j) = sqrt(sum(new_centroid2-obj_cam1.centroid(i)).^2);
            end

            % Escolher centroide mais perto
            [M,I] = min(dist(i).distances);
            
            if(M < 200)
                % Merge das respectivas point clouds
                xyz_2_to_1 = obj_cam2(I).xyz*R + ones(length(obj_cam2(I).xyz),1)*(T(1,:));
                pc1 = pointCloud(obj_cam1(i).xyz);
                pc2 = pointCloud(xyz_2_to_1);
                PC = pcmerge(pc1,pc2,1);
                
                % Storing index of matched objects
                idx_chosen1(cnt) = i;
                idx_chosen2(cnt) = I;
                cnt = cnt + 1; 
                
                % Detectar cornerpoints
                [corners] = get_cornerpoints(PC);
                
                % Store in objects structure
                init = length(objects);
                objects(1+init).X(frame_number,:) = corners(:,1)';
                objects(1+init).Y(frame_number,:) = corners(:,2)';
                objects(1+init).Z(frame_number,:) = corners(:,3)';
                objects(1+init).frames_tracked = frame_number;
            end   
        end
        
        % Finds the objects that are not matched (only in 1 of the cameras) 
        loners_1 = find_loners(idx_chosen1, length(obj_cam1));
        loners_2 = find_loners(idx_chosen2, length(obj_cam2));
        
        [objects] = detect_loners( obj_cam1, 1, loners_1, objects,R,T );
        [objects] = detect_loners( obj_cam2, 2, loners_2, objects,R,T );

        showPointCloud(PC);
        hold on;
        
        % Detectar cornerpoints
        [corners] = get_cornerpoints(PC);
        plotminbox(corners);
        
        objects(i).X = corners(:,1)';
        objects(i).Y = corners(:,2)';
        objects(i).Z = corners(:,3)';
        objects(i).rgb_cam1=
        %adicionar campo "point_cloud" para converter para rbg o objeto -
        %util para fazer tracking entre frames
        %objects(i).PC = PC;

    end
    
    %% If only camera 1 has objects
    if(isempty(obj_cam1) == 0 && isempty(obj_cam2) == 1)
        loners_1 = 1:length(obj_cam1);
        [objects] = detect_loners( obj_cam1, 1, loners_1, objects,R,T );
    end  
    %% If only camera 2 has objects
    if(isempty(obj_cam1) == 1 && isempty(obj_cam2) == 0)
        loners_2 = 1:length(obj_cam2);
        [objects] = detect_loners( obj_cam2, 2, loners_2, objects,R,T );
    end  
 
end

