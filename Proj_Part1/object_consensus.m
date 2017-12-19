function [ objects ] = object_consensus( obj_cam1, obj_cam2, R,T ) 
    
    for i = 1:length(obj_cam1)
        for j = 1:length(obj_cam2)
            
            % Transformar centroide cam2 na cam1
            new_centroid2 = (obj_cam2(j).centroid)*R + T;
            
            % Comparar distâncias entre centróides
            dist(i).distances(j) = sqrt(sum(new_centroid2-obj_cam1.centroid(i)).^2);
            
        end
        
        % Escolher centróide mais perto
        [M,I] = min(dist(i).distances);
        
        % Merge das respectivas point clouds
        xyz_2_to_1 = obj_cam2(I).xyz*R + ones(length(obj_cam2(I).xyz),1)*(T(1,:));
        
        PC = pcmerge(obj_cam1(i).xyz, xyz_2_to_1, 1);
        
        % Detectar cornerpoints
        [corners] = get_cornerpoints(PC);
        
        objects(i).X = corners(:,1)';
        objects(i).Y = corners(:,2)';
        objects(i).Z = corners(:,3)';
        
    end
end

