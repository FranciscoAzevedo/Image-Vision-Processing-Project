function [objects] = detect_loners1( obj_cam, flag, loners, objects,R,T, frame_number )
    
    if(flag == 1)
        for i = 1:length(loners)
            transformed_xyz = (obj_cam(loners(i)).xyz)*R + ones(length(obj_cam(loners(i)).xyz),1)*(T');
            PC = pointCloud(transformed_xyz);
            PC1 = pointCloud(transformed_xyz ,'Color',obj_cam(loners(i)).rgb);            
            
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
    if(flag == 2)
        for i = 1:length(loners)
            
            transformed_xyz = (obj_cam(loners(i)).xyz)*R + ones(length(obj_cam(loners(i)).xyz),1)*(T');
            PC = pointCloud(transformed_xyz);
            PC1 = pointCloud(transformed_xyz ,'Color',obj_cam(loners(i)).rgb);
            
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
end