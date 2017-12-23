function [] = plot_boxes_and_PC1(xyz1,xyz2,k, objects,R1,T1,R2,T2)
    
    xyz_2_to_w = (xyz2*R2) + ones(length(xyz2),1)*(T2');
     xyz_1_to_w = (xyz2*R1) + ones(length(xyz1),1)*(T1');
    figure();    
    pc1 = pointCloud(xyz_1_to_w);
    pc2 = pointCloud(xyz_2_to_w);
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