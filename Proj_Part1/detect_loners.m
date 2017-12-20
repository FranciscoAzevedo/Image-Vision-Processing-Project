function [objects] = detect_loners( obj_cam, flag, loners, objects,R,T )
    
    if(flag == 1)
        for i = 1:length(loners)
            PC = pointCloud(obj_cam(loners(i)).xyz);
                        
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
    if(flag == 2)
        for i = 1:length(loners)
            PC = pointCloud(obj_cam(loners(i)).xyz);
            
            transformed_PC = PC*R + ones(length(PC),1)*(T(1,:));

            % Detectar cornerpoints
            [corners] = get_cornerpoints(transformed_PC);

            % Store in objects structure
            init = length(objects);
            objects(1+init).X(frame_number,:) = corners(:,1)';
            objects(1+init).Y(frame_number,:) = corners(:,2)';
            objects(1+init).Z(frame_number,:) = corners(:,3)';
            objects(1+init).frames_tracked = frame_number;
        end
    end
end

