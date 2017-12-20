function [ objects ] = object_consensus( obj_cam1, obj_cam2, R, T, frame_number ) 


    for i = 1:length(obj_cam1)
        for j = 1:length(obj_cam2)
            
            % Transformar centroide cam2 na cam1
            new_centroid2 = (obj_cam2(j).centroid)*R + T(1,:);
            
            % Comparar distancias entre centroides
            dist(i).distances(j) = sqrt(sum(new_centroid2-obj_cam1.centroid(i)).^2);
            
        end
        
        % Escolher centroide mais perto
        [M,I] = min(dist(i).distances);
        
        % Merge das respectivas point clouds
        xyz_2_to_1 = obj_cam2(I).xyz*R + ones(length(obj_cam2(I).xyz),1)*(T(1,:));
        
        pc1 = pointCloud(obj_cam1(i).xyz);
        pc2 = pointCloud(xyz_2_to_1);
        PC = pcmerge(pc1,pc2,1);
        
        showPointCloud(PC);
        hold on;
        
        % Detectar cornerpoints
        [corners] = get_cornerpoints(PC);
        plotminbox(corners);
        
        objects(i).X(frame_number,:) = corners(:,1)';
        objects(i).Y(frame_number,:) = corners(:,2)';
        objects(i).Z(frame_number,:) = corners(:,3)';
        objects(i).frames_tracked = frame_number;
        %adicionar campo "point_cloud" para converter para rbg o objeto -
        %util para fazer tracking entre frames
        %objects(i).PC = PC;
       
    end
end

