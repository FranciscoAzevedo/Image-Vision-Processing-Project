function [index] = find_objs_frame_x(objects,frame)  
    % Searches objects
    for i = 1:length(objects)
        cnt = 1;
        % Searches frames within objects
        for j = 1:length(objects(i).frames_tracked)
            if(objects(i).frames_tracked(j) == frame)
                index(cnt) = i; % Stores object's index 
                cnt = cnt +1;
            end
        end
    end
end