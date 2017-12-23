%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    object_consensus1                                       %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ objects ] = object_consensus1( obj_cam1, obj_cam2, R1, T1,R2,T2, frame_number, objects ) 
    %% If both cameras have objects
    cnt = 1;
    if(isempty(obj_cam1) == 0 && isempty(obj_cam2) == 0)    
        for i = 1:length(obj_cam1)
            new_centroid1= (obj_cam1(i).centroid)*R1 + T1';
            for j = 1:length(obj_cam2)
                % Transformar centroide cam2 na cam1
                new_centroid2 = (obj_cam2(j).centroid)*R2 + T2';
                
                % Comparar distancias entre centroides
                dist(i).distances(j) = sqrt(sum(new_centroid2 -  new_centroid1).^2);
            end

            % Escolher centroide mais perto
            [M,I] = min(dist(i).distances);
            
            if(M < 200)
                % Merge das respectivas point clouds
                xyz_2_to_W = obj_cam2(I).xyz*R2 + ones(length(obj_cam2(I).xyz),1)*(T2');
                xyz_1_to_W = obj_cam1(i).xyz*R1 + ones(length(obj_cam1(i).xyz),1)*(T1');
                pc1 = pointCloud(xyz_1_to_W);
                pc2 = pointCloud(xyz_2_to_W);
                PC = pcmerge(pc1,pc2,0.001);
                PC1 = pointCloud([ xyz_1_to_W ; xyz_2_to_W],'Color',[obj_cam1(i).rgb; obj_cam2(I).rgb]);

                % Storing index of matched objects
                idx_chosen1(cnt) = i;
                idx_chosen2(cnt) = I;
                cnt = cnt + 1; 
                
                % Detectar cornerpoints
                [corners] = get_cornerpoints(PC);
                
                % Store in objects structure
                init = length(objects);
                
                objects(1+init).X(1,:) = corners(:,1)';
                objects(1+init).Y(1,:) = corners(:,2)';
                objects(1+init).Z(1,:) = corners(:,3)';
                objects(1+init).frames_tracked(1) = frame_number;
                objects(1+init).PC_rgb = PC1;
            end   
        end
        
        % Finds the objects that are not matched (only in 1 of the cameras) 
        loners_1 = find_loners(idx_chosen1, length(obj_cam1));
        loners_2 = find_loners(idx_chosen2, length(obj_cam2));
        
        [objects] = detect_loners1( obj_cam1, 1, loners_1, objects,R1,T1, frame_number );
        [objects] = detect_loners1( obj_cam2, 2, loners_2, objects,R2,T2, frame_number );
    end
    
    %% If only camera 1 has objects
    if(isempty(obj_cam1) == 0 && isempty(obj_cam2) == 1)
        loners_1 = 1:length(obj_cam1);
        [objects] = detect_loners1( obj_cam1, 1, loners_1, objects,R1,T1,frame_number );
    end  
    %% If only camera 2 has objects
    if(isempty(obj_cam1) == 1 && isempty(obj_cam2) == 0)
        loners_2 = 1:length(obj_cam2);
        [objects] = detect_loners1( obj_cam2, 2, loners_2, objects,R2,T2,frame_number );
    end  