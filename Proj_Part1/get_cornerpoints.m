function [ cornerpoints ] = get_cornerpoints( PC )

    min_x = min(PC(:,1));
    max_x = max(PC(:,1));
    min_y = min(PC(:,2));
    max_y = max(PC(:,2));
    min_z = min(PC(:,3));
    max_z = max(PC(:,3));
    
    cornerpoints(1,:) = [min_x, min_y, min_z];
    cornerpoints(2,:) = [min_x, max_y, min_z];
    cornerpoints(3,:) = [max_x, min_y, min_z];
    cornerpoints(4,:) = [max_x, max_y, min_z];
    cornerpoints(5,:) = [min_x, min_y, max_z];
    cornerpoints(6,:) = [min_x, max_y, max_z];
    cornerpoints(7,:) = [max_x, min_y, max_z];
    cornerpoints(8,:) = [max_x, max_y, max_z];
    

end

