function [] = plot_boxes_and_PC(k,xyz1,xyz2,objects,R,T)
    
    xyz_2_to_1 = (xyz2*R) + ones(length(xyz2),1)*(T(1,:));
    
    figure(1);    
    pc1 = pointCloud(xyzd1);
    showPointCloud(pc1);
    title('CAM 1');
    
    for i = length(objects)
        figure(i);
        plotminbox(objects.(i))
        hold on;
    end
end