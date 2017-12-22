function [] = plot_boxes_and_PC(xyz1,xyz2,k, objects,R,T)
    
    xyz_2_to_1 = (xyz2*R) + ones(length(xyz2),1)*(T(1,:));
    
    figure();    
    pc1 = pointCloud(xyz1);
    pc2 = pointCloud(xyz_2_to_1);
    PC = pcmerge(pc1,pc2,0.001);
    showPointCloud(PC);
    title('CAM 1');
    if (isempty(objects)==0)
        for i = length( objects)
        
            if (objects(i).frames_tracked(length(objects(i).frames_tracked))==k)
            hold on;
            cornerpoints(:,1) = objects(i).X(length(objects(i).frames_tracked),:)';
            cornerpoints(:,2) = objects(i).Y(length(objects(i).frames_tracked),:)';
            cornerpoints(:,3) = objects(i).Z(length(objects(i).frames_tracked),:)';
            plotminbox( cornerpoints );
            end
        end
    end
end